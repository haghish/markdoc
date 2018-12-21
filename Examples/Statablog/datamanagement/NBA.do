qui log using _NBA, replace

/***
Web scraping NBA data into Stata
================================

- Author: Kevin Crow, Senior Software Developer
- https://blog.stata.com/2018/10/10/web-scraping-nba-data-into-stata/

This is a replication of a post from Stata blog to test MarkDoc package. Unfortunately, the example was not replicable on Stata 15.1 and Windows 10. Though, this post is based on a user-written program.

---

Since our intern, Chris Hassell, finished __nfl2stata__ 
earlier than expected, he went ahead and created another 
command to web scrape https://stats.nba.com for data on the 
NBA. The command is __nba2stata__. To install the command type

***/

net install http://www.stata.com/users/kcrow/nba2stata, replace

/***
When Chris first wrote the command, I knew I wanted to look 
at how the three-point shot has changed the way the game is 
played. For example, I can find the best three-point shooter 
from last season.
***/

nba2stata playerstats _all, season(2017) seasontype(reg) stat(season) clear

/***
---
***/

gsort -threepointfieldgoalsmade
list playername teamname threepointfieldgoalsmade in 1/10

/***
---

Or I can check a player’s regular-season three-point percentage 
for the last five years.
***/

nba2stata playerstat "Dirk", stat(season) seasontype(reg) clear
gsort -playerage 
list playername playerage threepointfieldgoalpercentage in 1/5

/***
---

Or I can see how three-point percentage affects your favorite 
team’s chance of winning.
***/

nba2stata teamstats "HOU", season(2017) stat(game) seasontype(reg) clear
keep if threepointfieldgoalpercentage > .35
tab winloss

/***
__nba2stata__ is great if you are planning on doing pro basketball 
analysis. Although this command looks identical to 
__nfl2stata__, it is not. The command works quite differently.

---

Web scraping JSON
-----------------

In our last blog post, we talked about web scraping the 
https://www.nfl.com and extracting the data from the HTML pages. 
The NBA data are different. You can access the data via JSON 
objects from https://stats.nba.com. JSON is a lightweight 
data format. This data format is easy to parse; therefore, 
we don’t have a scrape command for these data. We scrape and 
load these data on the fly.

The NBA’s copyright is similar to that of the NFL; you can 
use a personal copy of the data on your own personal computer. 
If you “use, display or publish” anything using these data, 
you must include “a prominent attribution to http://www.nba.com“. 
Another difference is that the NBA data stored on 
http://stats.nba.com can go as far back as the 1960s, 
depending on the team.

---

### Command

There are only four subcommands to nba2stata, though we 
could have developed more. Chris had to go back to school.

- To scrape player statistics data into Stata, use

     nba2stata playerstats name_pattern [, playerstats_options]

- To scrape player profile data into Stata, use

     nba2stata playerprofile name_pattern [, playerprofile_options]

- To scrape team statistics data into Stata, use

     nba2stata teamstats team_adv [, teamstats_options]

- To scrape team roster data into Stata, use

     nba2stata teamroster team_adv [, teamroster_options]

Just like with nfl2stata, you will need to use Stata commands 
like collapse, gsort, and merge to generate the statistics, 
sort the data, and merge two or more NBA datasets together 
to examine the data.

---

#### Examples

One thing I’m always curious about is which college teams 
produce the most NBA players. This is easy to find out using 
__nba2stata__, __collapse__, and __gsort__.
***/

nba2stata playerprofile "_all", clear

/***
---
***/

save playerprofile, replace
drop if school == ""
gen ct = 1
collapse (count) ct, by(school)
gsort -ct
list in 1/10

/***
Because of the amount of data fetched, you might want to save 
the player profile data after fetching it because it does 
take some time to download. On my machine, it took about an 
hour. The time largly depends on the amount of data that must 
be fetched. In the above case, it’s all the player profile 
data from the NBA.

Another interesting example would be to find the oldest and 
youngest teams in the NBA. You can use the team roster to do 
this.
***/

nba2stata teamroster _all, season(2017) clear
collapse (mean) age, by(teamname)
sort age
list teamname age in 1/5
list teamname age in -5/l


qui log c









