# tinyprinter-scripts
This repo contains scripts I use to start and print to my Paperang printer

start-tinyprinter.sh - I call this from /etc/rc.local: su my_login -c "/usr/local/tinyprinter/bin/start-tinyprinter.sh" > /var/log/tinyprinter.log 2>&1 &

print-news-to-tinyprinter.sh {-b || -w || -W} - -b print current bitcoin price; -w print current NYC weather; -W print NYC weather now, in three hours, and in six hours. I call this fron my crontab: 30 7 * * * /usr/local/tinyprinter/bin/print-news-to-tinyprinter.sh -b -W

read-weather.py - Python script called by print-news-to-tinyprinter.sh to grab the weather report from api.openweathermap.org. Add your API key to the appid= argument to request.urlopen()

These scripts need to be in your PATH.

The repos sirius-client and python-paperang from this collection: https://github.com/tinyprinter must be downloaded and installed in /usr/local/tinyprinter/.

Thanks to @KTamas for his great Bang Bang Con talk in 2019. Read about his great work at https://tinyprinter.club.

To do: Render and print the BTC price graph for the last 12 or 24 hours. Do the same for ETH. There's probably other useful stuff for print-news-to-tinyprinter.sh to do.

