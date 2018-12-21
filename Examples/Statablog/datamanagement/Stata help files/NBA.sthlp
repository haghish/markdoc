{smcl}

{title:Web scraping NBA data into Stata}

{break}    - Author: Kevin Crow, Senior Software Developer
{break}    - https://blog.stata.com/2018/10/10/web-scraping-nba-data-into-stata/

{p 4 4 2}
This is a replication of a post from Stata blog to test MarkDoc package. Unfortunately, the example was not replicable on Stata 15.1 and Windows 10. Though, this post is based on a user-written program.

{title:}

{p 4 4 2}
Since our intern, Chris Hassell, finished {bf:nfl2stata} 
earlier than expected, he went ahead and created another 
command to web scrape https://stats.nba.com for data on the 
NBA. The command is {bf:nba2stata}. To install the command type

{p 4 4 2}
When Chris first wrote the command, I knew I wanted to look 
at how the three-point shot has changed the way the game is 
played. For example, I can find the best three-point shooter 
from last season.
{hline}
{hline}

{p 4 4 2}
Or I can check a player’s regular-season three-point percentag
for the last five years.
{hline}

{p 4 4 2}
Or I can see how three-point percentage affects your favorite 
team’s chance of winnin
{bf:nba2stata} is great if you are planning on doing pro basketball 
analysis. Although this command looks identical to 
{bf:nfl2stata}, it is not. The command works quite differently.

{title:}


{title:Web scraping JSON}

{p 4 4 2}
In our last blog post, we talked about web scraping the 
https://www.nfl.com and extracting the data from the HTML pages. 
The NBA data are different. You can access the data via JSON 
objects from https://stats.nba.com. JSON is a lightweight 
data format. This data format is easy to parse; therefore, 
we don’t have a scrape command for these data. We scrape an
load these data on the fly.

{p 4 4 2}
The NBA’s copyright is similar to that of the NFL; you ca
use a personal copy of the data on your own personal computer. 
If you “use, display or publish” anything using these da
you must include “a prominent attribution to http://www.nba.com�
Another difference is that the NBA data stored on 
http://stats.nba.com can go as far back as the 1960s, 
depending on the team.

{title:}

{p 4 4 2}{bf:Command}

{p 4 4 2}
There are only four subcommands to nba2stata, though we 
could have developed more. Chris had to go back to school.

{break}    - To scrape player statistics data into Stata, use

     nba2stata playerstats name_pattern [, playerstats_options]

{break}    - To scrape player profile data into Stata, use

     nba2stata playerprofile name_pattern [, playerprofile_options]

{break}    - To scrape team statistics data into Stata, use

     nba2stata teamstats team_adv [, teamstats_options]

{break}    - To scrape team roster data into Stata, use

     nba2stata teamroster team_adv [, teamroster_options]

{p 4 4 2}
Just like with nfl2stata, you will need to use Stata commands 
like collapse, gsort, and merge to generate the statistics, 
sort the data, and merge two or more NBA datasets together 
to examine the data.

{title:}

{p 4 4 2}{it:Examples}

{p 4 4 2}
One thing I’m always curious about is which college team
produce the most NBA players. This is easy to find out using 
{bf:nba2stata}, {bf:collapse}, and {bf:gsort}.
{hline}
Because of the amount of data fetched, you might want to save 
the player profile data after fetching it because it does 
take some time to download. On my machine, it took about an 
hour. The time largly depends on the amount of data that must 
be fetched. In the above case, it’s all the player profil
data from the NBA.

{p 4 4 2}
Another interesting example would be to find the oldest and 
youngest teams in the NBA. You can use the team roster to do 
this.


