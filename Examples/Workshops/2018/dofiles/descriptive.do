
/***

Summarize the data
-------------------

***/

sysuse auto, clear
summarize

histogram price
img, title("Histogram of the `price` variable") w(200) h(130)

