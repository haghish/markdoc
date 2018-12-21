{smcl}

{title:Handling gaps in time series using business calendars}

{p 4 4 2}
Author: Ashish Rajbhandari, Senior Econometrician

{p 4 4 2}
https://blog.stata.com/2016/02/04/handling-gaps-in-time-series-using-business-calendars/

{p 4 4 2}
This is a replication of a post from Stata blog to test MarkDoc package

{title:}

{p 4 4 2}
Time-series data, such as financial data, often have known 
gaps because there are no observations on days such as 
weekends or holidays. Using regular Stata datetime formats 
with time-series data that have gaps can result in 
misleading analysis. Rather than treating these gaps as 
missing values, we should adjust our calculations 
appropriately. I illustrate a convenient way to work with 
irregularly spaced dates by using Stata’s business calendar

{p 4 4 2}
In nasdaq.dta, I have daily data on the NASDAQ index from 
February 5, 1971 to March 23, 2015 that I downloaded from 
the St. Louis Federal Reserve Economic Database (FRED).

{title:}
{hline}

{p 4 4 2}
date is the time variable in our data, which is a string 
format ordered as year, month, and day. I use the {bf:date()} 
function to convert the string daily date to a Stata numeric
date and store the values in mydate. To find out more about
converting string dates to numeric, you can read A tour of
datetime in Stata.
{hline}

{p 4 4 2}
I tsset these data with mydate as the time variable and then list the first five observations, along with the first lag of index.
{hline}

{p 4 4 2}
The first observation on l.index is missing; I expect this 
because there are no observations prior to the first 
observation on index. However, the second observation on 
{bf:l.index} is also missing. As you may have already noticed, 
the dates are irregularly spaced in my dataset—the firs
observation corresponds to a Friday and the second 
observation to a Monday.

{p 4 4 2}
I get missing data in this case because mydate is a regular 
date, and tsset–ing by a regular date will treat al
weekends and other holidays as if they are missing in the 
dataset instead of ignoring them in calculations. To avoid 
the problem of gaps inherent in business data, I can create 
a business calendar. Business calendars specify which dates 
are omitted. For daily financial data, a business calendar 
specifies the weekends and holidays for which the markets 
were closed.

{title:}


{title:Creating business calendars}

{p 4 4 2}
Business calendars are defined in files named calname.stbcal. 
You can create your own calendars, use the ones provided by 
StataCorp, or obtain them directly from other users or via 
the SSC. Calendars can also be created automatically from 
the current dataset using the bcal create command.

{p 4 4 2}
Every stbcal-file requires you to specify the following 
four things:

{break}    - the version of Stata being used
{break}    - the range of the calendar
{break}    - the center date of the calendar
{break}    - the dates to be omitted

{p 4 4 2}
I begin by creating nasdaq.stbcal, which will omit Saturdays 
and Sundays of every month. I do this using the Do-file 
editor, but you can use any text editor.

{title:}

{asis}
     version 14.1
     purpose "Converting daily financial data into business calendar dates"
     dateformat dmy
     range 05feb1971 23mar2015
     centerdate 05feb1971
     omit dayofweek (Sa Su)
{smcl}

{p 4 4 2}
The first line specifies the current version of Stata I am 
using. The second line is optional, but the text typed there 
will display if I type {bf:bcal describe nasdaq} and is good 
for record keeping when I have multiple calenders. Line 3 
specifies the display date format and is also optional. 
Line 4 specifies the range of dates in the dataset.

{title:}

{p 4 4 2}
Line 5 specifies the center of the date to be 05feb1971. I 
picked the first date in the sample, but I could have picked 
any date in the range specified for the business calendar. 
centerdate does not mean choosing a date that is in fact the 
center of the sample. For example, Stata’s default %t
calendar uses 01jan1960 as its center.

{p 4 4 2}
The last statement specifies to omit weekends of every month. 
Later, I will show several variations of the omit command to 
omit other holidays. Once I have a business calendar, I can 
use this to convert regular dates to business dates, share 
this file with colleagues, and also make further changes to 
my calendar.

{title:}


{title:Using a business calendar}

{hline}

{p 4 4 2}
To create business dates using {bf:bofd()}, I specified two 
arguments: the name of the business calendar and the name of 
the variable containing regular dates. The assert statement 
verifies that all dates recorded in mydate appear in the 
business calendar. This is a way of checking that I created 
my calendar for the complete date range—the {bf:bofd()} functio
returns a missing value when mydate does not appear on the 
specified calendar.

{p 4 4 2}
Business dates have a specific display format, {bf:%tbcalname}, 
which in my case is {bf:%tbnasdaq}. In order to display business 
dates in a Stata date format I will apply this format to 
bcaldate just as I would for a regular date.

{title:}
{hline}

{p 4 4 2}
Although {bf:mydate} and {bf:bcaldate} look similar, they have 
different encodings. Now, I can {bf:tsset} on the business 
date {bf:bcaldate} and list the first five observations with 
the lag of {bf:index} recalculated.
{hline}

{p 4 4 2}
As expected, the issue of gaps due to weekends is now 
resolved. Because I have a calendar that excludes Saturdays 
and Sundays, {bf:bcaldate} skipped the weekend between 
{bf:05feb1971} and {bf:08feb1971} when calculating the lagged 
index value and will do the same for any subsequent weekends 
in the data.


{title:Excluding specific dates}

{p 4 4 2}
So far I have not excluded gaps in the data due to other 
major holidays, such as Thanksgiving and Christmas. Stata 
has several variations on the {bf:omit} command that let you 
exclude specific dates. For example, I use the {bf:omit} command 
to omit the Thanksgiving holiday (the fourth Thursday of 
November in the U.S.) by adding the following statement in 
my business calendar.

{title:}

     omit dowinmonth +4 Th of Nov

{p 4 4 2}
{bf:dowinmonth} stands for day of week in month and 
{bf:+4 Th of Nov} refers to the fourth Thursday of November. 
This rule is applied to every year in the data.

{p 4 4 2}
Another major holiday is Christmas, with the NASDAQ closed 
on the 25th of December every year. I can omit this holiday 
in the calendar as

     omit date 25dec*

{title:}

{p 4 4 2}
The {bf:*} in the statement above indicates that December 25 
should be omitted for every year in my {bf:nasdaq} calendar.

{p 4 4 2}
This rule is misleading since the 25th may be on a weekend, 
in which case the holidays are on the preceeding Friday or 
following Monday. To capture these cases, I add the 
following statements:

     omit date 25dec* and (-1) if dow(Sa)
     omit date 25dec* and (+1) if dow(Su)

{p 4 4 2}
The first statement omits December 24 if Christmas is on a 
Saturday, and the second statement omits December 26 if 
Christmas is on a Sunday.


{title:Encodings}

{p 4 4 2}
I mentioned earlier that the encodings of regular date 
{bf:mydate} and business date {bf:bcaldate} are different. To 
see the encodings of my date variables, I apply the 
numerical format and list the first five observations.

{title:}
The variable {bf:bcaldate} starts with 0 because this was the 
centerdate in my calendar {bf:nasdaq.stbcal}. The business 
date encoding is consecutive without gaps, which is why 
using lags or any time-series operators will yield correct values.


{title:Summary}

{p 4 4 2}
Using regular dates with time-series data instead of 
business dates may be misleading in case there are gaps in 
the data. In this post, I showed a convenient way to work 
with business dates by creating a business calendar. Once I 
loaded a calendar file into Stata, I created business dates 
using the {bf:bofd()} function. I also showed some variations 
of the omit command used in business calendars to 
accommodate specific gaps due to different holidays.


