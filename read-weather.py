#!/usr/bin/python3
# https://openweathermap.org/api/one-call-api#data
#
# treed Tue Jun 16 14:06:33 EDT 2020
#
# dict=object, list=array, str/int/long/float, True/False
# current.dt, temp, feels_like
# current.weather: [
#                 {
#                     "id": 800,
#                     "main": "Clear",
#                    "description": "clear sky",
# hourly.dt Time of historical data, unix, UTC
# hourly.temp Temperature. Unit 
# hourly.feels_like Temperature. 
#get ['current'].['dt'] and convert
#get ['current'].['temp']
#get ['current'].['feels_like']
#get ['current'].['weather'].['main'] and ['description']
# print(data['cosponsors']['0']['thomas_id']

import datetime
import urllib.request as request
import json

with request.urlopen('https://api.openweathermap.org/data/2.5/onecall?lat=40.678177&lon=-73.944160&exclude=minutely,current,daily&units=imperial&appid=your_api_key_here') as response:
	if response.getcode() == 200:
		source = response.read()
		data = json.loads(source)
	else:
		print('Failed to load weather data')

# print( datetime.datetime.fromtimestamp( int(data['current']['dt'] )).strftime('%Y-%m-%d %H:%M:%S') )
for x in ( 0, 3, 6 ):
	datestamp = datetime.datetime.fromtimestamp( int(data['hourly'][x]['dt'] )).strftime('%Y-%m-%d %H:%M')
	temp = str( data['hourly'][x]['temp'] ) 
	feels_like = str( data['hourly'][x]['feels_like'] ) 
	main = data['hourly'][x]['weather'][0]['main']
	description = data['hourly'][x]['weather'][0]['description']
	print( datestamp + ": " + main + ", " + description + " " + temp + ", feels like " + feels_like ) 
	


