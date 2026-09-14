# Imports
from flask import Flask, render_template, request, url_for
from turbo_flask import Turbo as turbo
import pymysql
import os

# Database Connection
'''connection = pymysql.connect(
    host=os.environ.get('HOST'),
    user=os.environ.get('USER'),
    password=os.environ.get('PASS'),
    database=os.environ.get('DB'),
    cursorclass=pymysql.cursors.DictCursor,
    autocommit=True
)'''
'''connection = pymysql.connect(
    host="localhost",
    user="devlc",
    password="lcdev123",
    database="lc_new",
    cursorclass=pymysql.cursors.DictCursor,
    autocommit=True
)
cursor = connection.cursor()'''

connection = pymysql.connect(
    host="127.0.0.1",
    user="root",
    #password="lcdev123",
    database="lc_new",
    cursorclass=pymysql.cursors.DictCursor,
    autocommit=True
)
cursor = connection.cursor()

# Keep connection open and prevent timeout
def execute_sql(command, values=None):
    connection.ping(reconnect=True)
    cursor.execute(command, values)
    return cursor

# Flask Setup
app = Flask(__name__)
app.config['SERVER_NAME'] = "127.0.0.1:5000"

# TO DO: Sort by league
def match_list():
    """Retrieves all matches that is currently live"""
    game_list = []

    # Retrieves all games
    cursor = execute_sql("SELECT * FROM `fixtures` WHERE `progress` = 2 OR `progress` = 3 OR `progress` = 4 ORDER BY `datetime` DESC, `leagueID` DESC;")
    games = cursor.fetchall()

    # Gets Team Scores
    for game in games:
        fixture_id = game["id"]
        game_list.append(team_scores(fixture_id))
    return game_list

def team_scores(fixture_id):
    """Returns team scores for gameblock header"""
    # Gets match details
    cursor = execute_sql("SELECT * FROM `fixtures` WHERE `id` = %s", [fixture_id])
    details = cursor.fetchall()
    details = details[0] 

    # Gets league details
    cursor = execute_sql("SELECT * FROM `leagues` WHERE `id` = %s", [details['leagueID']])
    league_details = cursor.fetchone()

    # Gets team logos
    cursor = execute_sql("SELECT * FROM `teams` WHERE `id` = %s", [details['teamAID']])
    if cursor.rowcount == 0:
        team_a = "default_1.png"
    else:
        team_a = cursor.fetchone()
        team_a = team_a['teamLogo']

    cursor = execute_sql("SELECT * FROM `teams` WHERE `id` = %s", [details['teamBID']])
    if cursor.rowcount == 0:
        team_b = "default_2.png"
    else:
        team_b = cursor.fetchone()
        team_b = team_b['teamLogo']

    infos = {
        "game_exist": True,
        # Game Details
        "id": details["id"],
        "teamA": details["teamA"],
        "teamB": details["teamB"],
        "teamA_image": team_a,
        "teamB_image": team_b,
        "progress": details["progress"],
        "status": details["status"],
        "datetime": details["datetime"].strftime("%d %b %Y %H:%M"),
        "venue": details["venue"],
        "format": details["format"],
        "toss": details["toss"],
        "league": details["leagueID"],
        "league_name": league_details["leagueName"]
    }

    # If match is not a fixture
    if details['progress'] != 1:
        # Gets match scores
        cursor = execute_sql("SELECT * FROM `live_games` WHERE `fixtureID` = %s", [fixture_id])
        scores = cursor.fetchall()
        scores = scores[0] 

        infos.update({
            "scores": {
                "teama_score": scores["teamAScore"],
                "teama_wkts": scores["teamAWkts"],
                "teama_overs": scores["teamAOvers"],
                "teama_extras": scores["teamAExtras"],
                "teamb_score": scores["teamBScore"],
                "teamb_wkts": scores["teamBWkts"],
                "teamb_overs": scores["teamBOvers"],
                "teamb_extras": scores["teamBExtras"],
                "target": scores["target"],
                "total_overs": scores["totalOvers"],
                "current_team_inning": scores["currentTeamInnings"],
                "first_team_inning": scores["firstTeamInnings"],
            }
        })
    else:
        infos.update({
            "scores": {
                "teama_score": 0,
                "teama_wkts": 0,
                "teama_overs": 0,
                "teama_extras": 0,
                "teamb_score": 0,
                "teamb_wkts": 0,
                "teamb_overs": 0,
                "teamb_extras": 0,
                "target": 0,
                "total_overs": 0,
                "current_team_inning": 0,
                "first_team_inning": 0
            }
        })
    return infos

def currently(fixture_id, batting, bowling):
    "Currently batting and bowling in a fixture"
    # Retrieves batsmen scores
    cursor = execute_sql("SELECT * FROM `batsmen_scores` WHERE `fixtureID` = %s AND `team` = %s AND `notOut` = 1", [fixture_id, batting])
    current_batsmen = cursor.fetchall()

    bat_list = []
    for batsmen in current_batsmen:
        batters = {
            "name": batsmen["playerName"],
            "surname": batsmen["playerSurname"],
            "runs": batsmen["runs"],
            "balls_faced": batsmen["ballsFaced"],
            "fours": batsmen["4"],
            "sixes": batsmen["6"],
        }
        bat_list.append(batters)

    # Retrieves bowler scores
    cursor = execute_sql("SELECT * FROM `bowlers_scores` WHERE `fixtureID` = %s AND `team` = %s ORDER BY `prevBowled` DESC LIMIT 2", [fixture_id, bowling])
    current_bowlers = cursor.fetchall()

    bowl_list = []
    for bowler in current_bowlers:
        bowlers = {
            "name": bowler["playerName"],
            "surname": bowler["playerSurname"],
            "overs": bowler["overs"],
            "maidens": bowler["maidens"],
            "runs": bowler["runs"],
            "wickets": bowler["wickets"],
            "noballs": bowler["noBalls"],
            "wides": bowler["wides"],
        }
        bowl_list.append(bowlers)
    return bat_list, bowl_list

def scoresheet_bat(fixture_id, batting):
    "Batting scorecard for entire team"
    # Gets entire batting list for team
    cursor = execute_sql("SELECT * FROM `batsmen_scores` WHERE `fixtureID` = %s AND `team` = %s", [fixture_id, batting])
    batting_scores = cursor.fetchall()

    # Batsmen dismissals
    cursor = execute_sql("SELECT * FROM `batsmen_dismassals` WHERE `fixtureID` = %s AND `team` = %s", [fixture_id, batting])
    batting_dismissals = cursor.fetchall()

    # Batting Scores
    scoresheet_batting = []
    for batsmen in batting_scores:
        batters = {
            "name": batsmen["playerName"],
            "surname": batsmen["playerSurname"],
            "runs": batsmen["runs"],
            "balls_faced": batsmen["ballsFaced"],
            "fours": batsmen["4"],
            "sixes": batsmen["6"],
            "not_out": batsmen["notOut"]
        }
        scoresheet_batting.append(batters)

    # Adds dismissal // no idea how this works but it works
    for score in scoresheet_batting:
        if score["not_out"] == 0:
            for dismissal in batting_dismissals:
                if (
                    score["name"] == dismissal["playerName"]
                    and score["surname"] == dismissal["playerSurname"]
                ):
                    score["method"] = mode_of_dismissal(dismissal["bowler"], dismissal["fielder"], dismissal["method"])
                    break
        else:
            score["method"] = "n/o"
    return scoresheet_batting

# Mode of Dismissal // Changes the big dictionary of dismissal to adapt to front-end needs
def mode_of_dismissal(bowler, fielder, dismissed):
    how = ""
    if dismissed == "bowled":
        how = f"b {bowler}"
    elif dismissed == "lbw":
        how = f"lbw b {bowler}"
    elif dismissed == "caught":
        how = f"c {fielder} / b {bowler}"
    elif dismissed == "run out":
        how = f"r/o {fielder}"
    elif dismissed == "stumped":
        how = f"st {fielder} / b {bowler}"
    elif dismissed == "caught" and fielder == bowler:
        how = f"c & b {bowler}"
    return how

def fow(fixture_id, batting):
    cursor = execute_sql("SELECT * FROM `batsmen_dismassals` WHERE `fixtureID` = %s AND `team` = %s", [fixture_id, batting])
    wickets_down = cursor.fetchall()

    wickets = []
    if cursor.rowcount == 0:
        return None
    else:
        for wicket in wickets_down:
            w = {
                "name": wicket["playerName"],
                "surname": wicket["playerSurname"],
                "team_runs": wicket["fow"],
            }
            wickets.append(w)
    return wickets

# Bowling Scorecard
def scorecard_bowl(fixture_id, bowling):
    # Gets all bowling scores
    cursor = execute_sql("SELECT * FROM `bowlers_scores` WHERE `fixtureID` = %s AND `team` = %s", [fixture_id, bowling])
    bowling_scores = cursor.fetchall()

    # Bowling Scores
    scoresheet_bowling = []
    for bowler in bowling_scores:
        bowlers = {
            "name": bowler["playerName"],
            "surname": bowler["playerSurname"],
            "overs": bowler["overs"],
            "maidens": bowler["maidens"],
            "runs": bowler["runs"],
            "wickets": bowler["wickets"],
            "noballs": bowler["noBalls"],
            "wides": bowler["wides"]
        }
        scoresheet_bowling.append(bowlers)
    return scoresheet_bowling

# Home Page
@app.route('/')
async def index():
    return render_template('index.html')

# Matches Page
@app.route('/matches', methods=['GET'])
async def matches():
    game_list = match_list()
    sorted_list = sorted(game_list, key=lambda x: x['league'])

    return render_template('matches/index.html', data=sorted_list)

# Livegame page
@app.route('/livegame', methods=['GET'])
async def livegame():
    # Gets match ID from parameter
    game_id = request.args.get('id')

    # Checks to see if game exists
    cursor = execute_sql("SELECT * FROM `fixtures` WHERE `id` = %s", [game_id])
    if cursor.rowcount == 0:
        # What to display if the game does not exist
        infos = {
            "game_exist": False,
            # Game Details
            "id": 0,
            "teamA": 'Team A',
            "teamB": 'Team B',
            "teamA_image": 'default_1.png',
            "teamB_image": 'default_2.png',
            "progress": 4,
            "status": 'N/A',
            "datetime": '1 Jan 2000 00:00',
            "venue": 'N/A',
            "format": 'N/A',
            "toss": 'N/A',
            "scores": {
                "teama_score": 0,
                "teama_wkts": 0,
                "teama_overs": 0,
                "teama_extras": 0,
                "teamb_score": 0,
                "teamb_wkts": 0,
                "teamb_overs": 0,
                "teamb_extras": 0 
                }
            }
    # If game does exist
    else:
        infos = team_scores(game_id)

        # If match is not a fixture
        if infos['progress'] != 1:
            # Determines who is batting
            current_batting = infos['scores']['current_team_inning']
            batting_first = infos['scores']['first_team_inning']

            if current_batting == 1:
                bowling_team = 2
            elif current_batting == 2:
                bowling_team = 1

            if batting_first == 1:
                batting_second = 2
            elif batting_first == 2:
                batting_second = 1

            # Gets current batsmen and bowler scores
            bat_list, bowl_list = currently(game_id, current_batting, bowling_team)

            # Scorecards
            # 1st Innings
            batting_1st = scoresheet_bat(game_id, batting_first)
            batting_1st_fow = fow(game_id, batting_first)
            bowling_1st = scorecard_bowl(game_id, batting_second)

            # 2nd Innings
            batting_2nd = scoresheet_bat(game_id, batting_second)
            batting_2nd_fow = fow(game_id, batting_second)
            bowling_2nd = scorecard_bowl(game_id, batting_first)

            # Captains & WK
            cursor = execute_sql("SELECT * FROM `fixtures` WHERE `id` = %s", [game_id])
            details = cursor.fetchone()
            
            cap_a = details['capA']
            cap_b = details['capB']
            wk_a = details['wkA']
            wk_b = details['wkB']


        # If the match is only a fixture
        else:
            bat_list = []
            bowl_list = []
            batting_1st = []
            batting_2nd = []
            bowling_1st = []
            bowling_2nd = []
            batting_1st_fow = []
            batting_2nd_fow = []
        
    return render_template("livegame/index.html", game = infos, # Match info
                                                  current_batsmen = bat_list, # Current batters
                                                  current_bowlers = bowl_list, # Current bowlers
                                                  first_bat = batting_1st, # Batting scorecards
                                                  second_bat = batting_2nd, # Batting scorecards
                                                  first_bowling = bowling_1st, # Bowling scorecards
                                                  second_bowling = bowling_2nd, # Bowling scorecards
                                                  first_fow = batting_1st_fow, # Fow
                                                  second_fow = batting_2nd_fow, # fow
                                                  captain_a = cap_a,
                                                  captain_b = cap_b,
                                                  wk_a = wk_a,
                                                  wk_b = wk_b,
                                                )

# Logs
@app.route('/logs', methods=["POST", "GET"])
async def logs():
    # Gets logs to display
    cursor = execute_sql("SELECT * FROM `leagues` WHERE `totalTeams` != '0'")
    available_logs = cursor.fetchall()

    leagues = []
    structures = []
    regions = []
    seasons = []

    for log in available_logs:
        if log['leagueName'] not in leagues:
            leagues.append(log['leagueName'])
        if log['structure'] not in structures:
            structures.append(log['structure'])
        if log['region'] not in regions:
            regions.append(log['region'])
        if log['season'] not in seasons:
            seasons.append(log['season'])

    if request.method == "POST":
        # Assuming you have logic to fetch logs based on form data
        league = request.form['league']
        season = request.form['season']
        
        # Fetch log data based on league and season
        cursor = execute_sql("SELECT * FROM `leagues` WHERE `leagueName` = %s AND `season` = %s", [league, season])
        info = cursor.fetchone()

        cursor = execute_sql("SELECT * FROM `league_standings` WHERE `leagueID` = %s ORDER BY `totalPoints` DESC", [info['id']])
        log_data = cursor.fetchall()

        i = 0

        # Gets team badge
        for team in log_data:
            cursor = execute_sql("SELECT * FROM `teams` WHERE `id` = %s", [log_data[i]['teamID']])
            badge = cursor.fetchone()
            log_data[i].update({'image': badge['teamLogo']}) 
            
            i = i + 1

        # Pass the log data to index.html
        return render_template('logs/index.html', logs=log_data,
                                                  info=info,
                                                  leagues=leagues, 
                                                  structures=structures, 
                                                  regions=regions, 
                                                  seasons=seasons)

    # If GET request, just render the logs page
    return render_template('logs/base.html', 
                           leagues=leagues, 
                           structures=structures, 
                           regions=regions, 
                           seasons=seasons)

# Logs
@app.route('/fixtures', methods=["POST", "GET"])
async def fixtures():
    cursor = execute_sql("SELECT * FROM `fixtures` WHERE `leagueID` = 2")
    fixtures = cursor.fetchall()

    game_list = []
    i = 0
    for game in fixtures:
        game_list.append(team_scores(fixtures[i]['id']))
        i = i + 1

    return render_template('fixtures/index.html', data=game_list)

# this.
if __name__ == "__main__":
    app.run(debug=True)