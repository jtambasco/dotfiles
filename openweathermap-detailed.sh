#!/bin/sh

get_icon() {
    case $1 in
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *) icon="";
    esac

    echo $icon
}

KEY="23a2c2a7dc0013ee24a45f4eae4bb548"
CITY=""
UNITS="metric"
SYMBOL="°C"
WEATHER_FONT_IDX=3 # Index of the weather icons font in the Polybar config file.

CITY=${CITY// /+}

until wget -q -O - http://www.google.com | grep Lucky > /dev/null; do
    sleep 10
done

if [ ! -z $CITY ]; then
    weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&q=$CITY&units=$UNITS")
    # weather=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&q=$CITY&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ ! -z "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ ! -z "$weather" ]; then
    weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
    echo "%{T$WEATHER_FONT_IDX}$(get_icon "$weather_icon")%{T-}" "${weather_desc^}", "$weather_temp$SYMBOL"
fi
