# Imports
import os
import threading
import time

import pymysql
from flask import Flask, render_template, request
from turbo_flask import Turbo

# FLASK & TURBO SETUP
app = Flask(__name__)
app.config["SERVER_NAME"] = os.environ.get("SERVER_NAME", "127.0.0.1:5000")

turbo = Turbo(app) # if i want to use this later on

# DATABASE CONNECTION
connection = pymysql.connect(
    host=os.environ.get("HOST"),
    user=os.environ.get("USER"),
    database=os.environ.get("DATABASE"),
    cursorclass=pymysql.cursors.DictCursor,
    autocommit=True,
)

def execute_sql(command, values=None):
    """Runs a query on a thread-safe cursor, reconnecting if needed."""
    connection.ping(reconnect=True)
    cursor = connection.cursor()
    cursor.execute(command, values)
    return cursor

# DATA HELPERS
def get_fixture(fixture_id):
    """Retrieves everything needed for a fixture."""
    sql = """
        SELECT f.*,
        ta.team_name AS team_a_name,
        ta.team_logo AS team_a_logo,
        tb.team_name AS team_b_name,
        tb.team_logo AS team_b_logo,
        l.league_name,
        cap_a.first_name AS cap_a_first,
        cap_a.last_name AS cap_a_last,
        cap_b.first_name AS cap_b_first,
        cap_b.last_name AS cap_b_last,
        wk_a.first_name AS wk_a_first,
        wk_a.last_name AS wk_a_last,
        wk_b.first_name AS wk_b_first,
        wk_b.last_name AS wk_b_last
        FROM fixtures f
        JOIN teams ta ON ta.id = f.team_a_id
        JOIN teams tb ON tb.id = f.team_b_id
        JOIN leagues l ON l.id = f.league_id
        LEFT JOIN players cap_a ON cap_a.id = f.captain_a_id
        LEFT JOIN players cap_b ON cap_b.id = f.captain_b_id
        LEFT JOIN players wk_a ON wk_a.id = f.wk_a_id
        LEFT JOIN players wk_b ON wk_b.id = f.wk_b_id
        WHERE f.id = %s
    """
    cursor = execute_sql(sql, [fixture_id])
    return cursor.fetchone()

def get_innings(fixture_id):
    """Get main data of all the innings"""
    cursor = execute_sql( "SELECT *, `is complete` AS `is_complete` FROM `innings` WHERE `fixture_id` = %s ORDER BY `innings_no`",[fixture_id])
    return cursor.fetchall()

def team_scores(fixture_id):
    """Main information and scores for both teams."""
    # Get fixture details and innings for match
    details = get_fixture(fixture_id)
    innings_list = get_innings(fixture_id)

    team_a_id, team_b_id = details["team_a_id"], details["team_b_id"] # both teams ids

    # Creates default score structure for a team with no innings yet
    def zero_score():
        return {"score": 0, "wkts": 0, "overs": 0.0, "extras": 0}

    # Create default score for both teams
    scores_by_team = {team_a_id: zero_score(), team_b_id: zero_score()} 

    # Go through each innings and update the batting teams score
    for inn in innings_list:
        extras = inn["byes"] + inn["leg_byes"] + inn["wides"] + inn["no_balls"] + inn["penalty_runs"] # calculate total extras
        scores_by_team[inn["batting_team_id"]] = {"score": inn["runs"], "wkts": inn["wickets"], "overs": inn["overs_bowled"], "extras": extras} # store innings information under the batting team's id

    first_inning = innings_list[0] if innings_list else None # Get the first innings, IF an innings exists
    last_inning = innings_list[-1] if innings_list else None # Get most recent innigns, IF an innings exists

    first_team_inning = 1 if first_inning and first_inning["batting_team_id"] == team_a_id else 2 # Determine whether Team A or B batted first
    current_team_inning = (1 if last_inning and last_inning["batting_team_id"] == team_a_id else 2) # Determine who is currently batting

    # Get the target from the current/last innings
    # If there is no innings, 0 is used as default
    target = last_inning.get("target", 0) if last_inning else 0

    # Return all the fixture information and scores
    return {
        "game_exist": True,
        "id": details["id"],
        "teamA": details["team_a_name"],
        "teamB": details["team_b_name"],
        "teamA_image": details["team_a_logo"],
        "teamB_image": details["team_b_logo"],
        "progress": details["progress"],
        "status": details["status_text"],
        "datetime": details["scheduled_at"].strftime("%d %b %Y %H:%M"),
        "venue": details["venue"],
        "format": details["match_format"],
        "toss": details["toss_text"],
        "league": details["league_id"],
        "league_name": details["league_name"],
        "scores": {
            "teama_score": scores_by_team[team_a_id]["score"],
            "teama_wkts": scores_by_team[team_a_id]["wkts"],
            "teama_overs": scores_by_team[team_a_id]["overs"],
            "teama_extras": scores_by_team[team_a_id]["extras"],
            "teamb_score": scores_by_team[team_b_id]["score"],
            "teamb_wkts": scores_by_team[team_b_id]["wkts"],
            "teamb_overs": scores_by_team[team_b_id]["overs"],
            "teamb_extras": scores_by_team[team_b_id]["extras"],
            "target": target,
            "total_overs": details["overs_limit"] or 0,
            "current_team_inning": current_team_inning,
            "first_team_inning": first_team_inning,
        },
    }

def currently(last_innings):
    """Batsmen currently at the crease (not out), and the last two bowlers used."""
    # If there is no current innings, return an empty list
    if not last_innings:
        return [], []

    # Gets all batsmen who is currently not out in the innings
    cursor = execute_sql(
        "SELECT bi.*, p.first_name, p.last_name FROM `batting_innings` bi "
        "JOIN `players` p ON p.id = bi.player_id "
        "WHERE bi.innings_id = %s AND bi.is_not_out = 1 ORDER BY bi.bat_position", [last_innings["id"]])

    # Converts database results into a list of dictionaries with info needed for the current batsmen
    bat_list = [
        {
            "name": b["first_name"], "surname": b["last_name"], "runs": b["runs"],
            "balls_faced": b["balls_faced"], "fours": b["fours"], "sixes": b["sixes"],
        }
        for b in cursor.fetchall()
    ]

    # Gets the two most recently used bowlers in the current innings
    cursor = execute_sql(
        "SELECT bo.*, p.first_name, p.last_name FROM `bowling_innings` bo "
        "JOIN `players` p ON p.id = bo.player_id "
        "WHERE bo.innings_id = %s ORDER BY bo.last_bowled_over DESC LIMIT 2",
        [last_innings["id"]],
    )

    # Converts the database results into a list of dictionaries with info needed for last two bowlers
    bowl_list = [
        {
            "name": b["first_name"], "surname": b["last_name"], "overs": float(b["overs_bowled"]),
            "maidens": b["maidens"], "runs": b["runs_conceded"], "wickets": b["wickets"],
            "noballs": b["no_balls"], "wides": b["wides"],
        }
        for b in cursor.fetchall()
    ]
    return bat_list, bowl_list

def dismissal_text(bat_row):
    """Turns the batting data row its "how out" text""" # (e.g. "b Smith", "c Jones / b Smith").
    # Not out batsmen just show "n/o" - nothing to look up
    if bat_row["is_not_out"]:
        return "n/o"

    # No linked ball means we don't have dismissal detail for this row
    if not bat_row.get("dismissal_ball_id"):
        return "out"

    # Look up the actual delivery that got them out, along with who bowled it and who fielded it
    cursor = execute_sql(
        "SELECT b.wicket_type, "
        "bowler.first_name AS bowler_first, bowler.last_name AS bowler_last, "
        "fielder.first_name AS fielder_first, fielder.last_name AS fielder_last "
        "FROM `balls` b "
        "JOIN `players` bowler ON bowler.id = b.bowler_id "
        "LEFT JOIN `players` fielder ON fielder.id = b.fielder_id "
        "WHERE b.id = %s",
        [bat_row["dismissal_ball_id"]],
    )
    d = cursor.fetchone()
    if not d:
        return "out"

    bowler_name = f"{d['bowler_first']} {d['bowler_last']}"
    fielder_name = f"{d['fielder_first']} {d['fielder_last']}" if d["fielder_first"] else bowler_name

    # Builds the correct display text for each wicket type
    return {
        "bowled": f"b {bowler_name}",
        "lbw": f"lbw b {bowler_name}",
        "caught": f"c & b {bowler_name}" if fielder_name == bowler_name else f"c {fielder_name} / b {bowler_name}",
        "run_out": f"r/o {fielder_name}",
        "stumped": f"st {fielder_name} / b {bowler_name}",
        "hit_wicket": f"hit wkt b {bowler_name}",
        "retired_out": "retired out",
        "obstructing_field": "obstructing the field",
    }.get(d["wicket_type"], "out")

def scoresheet_bat(innings_row):
    """Full batting scorecard for one innings, in batting order."""
    # No innings played yet
    if not innings_row:
        return []

    cursor = execute_sql(
        "SELECT bi.*, p.first_name, p.last_name FROM `batting_innings` bi "
        "JOIN `players` p ON p.id = bi.player_id "
        "WHERE bi.innings_id = %s ORDER BY bi.bat_position", [innings_row["id"]])

    # Converts each row into the info needed for the scorecard, including how they got out
    return [
        {
            "name": b["first_name"], "surname": b["last_name"], "runs": b["runs"],
            "balls_faced": b["balls_faced"], "fours": b["fours"], "sixes": b["sixes"],
            "method": dismissal_text(b),
        }
        for b in cursor.fetchall()
    ]

def fow(innings_row):
    """Fall of wickets data for an innings."""
    if not innings_row:
        return None

    cursor = execute_sql(
        "SELECT bi.*, p.first_name, p.last_name FROM `batting_innings` bi "
        "JOIN `players` p ON p.id = bi.player_id "
        "WHERE bi.innings_id = %s AND bi.is_not_out = 0 ORDER BY bi.fow_runs", [innings_row["id"]])
    rows = cursor.fetchall()

    # No wickets fallen yet
    if not rows:
        return None

    return [
        {"name": r["first_name"], "surname": r["last_name"], "team_runs": r["fow_runs"]}
        for r in rows
    ]

def scorecard_bowl(innings_row):
    """Full bowling figures for one innings, in the order bowlers were first used."""
    if not innings_row:
        return []

    cursor = execute_sql(
        "SELECT bo.*, p.first_name, p.last_name FROM `bowling_innings` bo "
        "JOIN `players` p ON p.id = bo.player_id "
        "WHERE bo.innings_id = %s ORDER BY bo.bowl_position",
        [innings_row["id"]],
    )

    return [
        {
            "name": b["first_name"], "surname": b["last_name"], "overs": float(b["overs_bowled"]),
            "maidens": b["maidens"], "runs": b["runs_conceded"], "wickets": b["wickets"],
            "noballs": b["no_balls"], "wides": b["wides"],
        }
        for b in cursor.fetchall()
    ]

def match_list():
    """All matches that are currently live and in-progress."""
    cursor = execute_sql("SELECT `id` FROM `fixtures` WHERE `progress` IN ('live', 'toss', 'completed') ORDER BY `scheduled_at` DESC, `league_id` DESC")
    return [team_scores(row["id"]) for row in cursor.fetchall()]

def full_name(data, first, last):
    return f"{data.get(first, '')} {data.get(last, '')}".strip()

EMPTY_GAME = {
    "game_exist": False, 
    "id": 0, 
    "teamA": "Team A", 
    "teamB": "Team B",
    "teamA_image": "default_1.png",
    "teamB_image": "default_2.png",
    "progress": 4, 
    "status": "N/A",
    "datetime": "1 Jan 2000 00:00",
    "venue": "N/A", 
    "format": "N/A", 
    "toss": "N/A",
    "scores": {k: 0 for k in (
        "teama_score", 
        "teama_wkts", 
        "teama_overs", 
        "teama_extras",
        "teamb_score", 
        "teamb_wkts", 
        "teamb_overs", 
        "teamb_extras",
        "target", 
        "total_overs", 
        "current_team_inning", 
        "first_team_inning")}
}

EMPTY_SCORECARD_CONTEXT = {
    "current_batsmen": [], 
    "current_bowlers": [],
    "first_bat": [], 
    "second_bat": [], 
    "first_bowling": [], 
    "second_bowling": [],
    "first_fow": [], 
    "second_fow": [], 
    "captain_a": "", 
    "captain_b": "",
    "wk_a": "", 
    "wk_b": "",
}

def build_livegame_context(game_id):
    """Everything the livegame page needs."""
    details = get_fixture(game_id)
    if not details:
        return {"game": EMPTY_GAME, **EMPTY_SCORECARD_CONTEXT}

    game = team_scores(game_id)
    innings_list = get_innings(game_id)

    captain_a = full_name(details, "cap_a_first", "cap_a_last")
    captain_b = full_name(details, "cap_b_first", "cap_b_last")
    wk_a = full_name(details, "wk_a_first", "wk_a_last")
    wk_b = full_name(details, "wk_b_first", "wk_b_last")

    if not innings_list:
        return {"game": game, **EMPTY_SCORECARD_CONTEXT, "captain_a": captain_a, "captain_b": captain_b, "wk_a": wk_a, "wk_b": wk_b}

    first_innings = innings_list[0]
    second_innings = innings_list[1] if len(innings_list) > 1 else None
    last_innings = innings_list[-1]

    bat_list, bowl_list = currently(last_innings if not last_innings["is_complete"] else None)

    return {
        "game": game,
        "current_batsmen": bat_list,
        "current_bowlers": bowl_list,
        "first_bat": scoresheet_bat(first_innings),
        "first_fow": fow(first_innings),
        "first_bowling": scorecard_bowl(first_innings),
        "second_bat": scoresheet_bat(second_innings),
        "second_fow": fow(second_innings),
        "second_bowling": scorecard_bowl(second_innings),
        "captain_a": captain_a, "captain_b": captain_b, "wk_a": wk_a, "wk_b": wk_b,
    }

# FLASK ROUTES
@app.route("/")
def index():
    return render_template("index.html", active_page="home")

@app.route("/matches", methods=["GET"])
def matches():
    game_list = sorted(match_list(), key=lambda x: x["league"])
    return render_template("matches.html", data=game_list, active_page="matches")

@app.route("/livegame", methods=["GET"])
def livegame():
    game_id = request.args.get("id")
    if game_id:
        context = build_livegame_context(game_id)
    else:
        # No id in the URL - show the empty placeholder game instead of erroring out
        context = {"game": EMPTY_GAME, **EMPTY_SCORECARD_CONTEXT}
    return render_template("livegame.html", active_page="matches", **context)

if __name__ == "__main__":
    app.run(debug=True, threaded=True)