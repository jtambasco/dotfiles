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
MATERIAL_FONT_IDX=2 # Index of the material icons font in the Polybar config file.
WEATHER_FONT_IDX=3 # Index of the weather icons font in the Polybar config file.

until wget -q -O - http://www.google.com | grep Lucky > /dev/null; do
    sleep 10
done

if [ ! -z $CITY ]; then
    current=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$CITY&units=$UNITS")
    forecast=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ ! -z "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
        forecast=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
    fi
fi

if [ ! -z "$current" ] && [ ! -z "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    current_icon=$(echo "$current" | jq -r ".weather[0].icon")

    forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].icon")

    if [ "$current_temp" -gt "$forecast_temp" ]; then
        trend="%{T$MATERIAL_FONT_IDX}%{T-}"
    elif [ "$forecast_temp" -gt "$current_temp" ]; then
        trend="%{T$MATERIAL_FONT_IDX}%{T-}"
    else
        trend="%{T$MATERIAL_FONT_IDX}%{T-}"
    fi

    echo "%{T$WEATHER_FONT_IDX}$(get_icon "$current_icon"%{T-}) $current_temp$SYMBOL $trend %{T$WEATHER_FONT_IDX}$(get_icon "$forecast_icon")%{T-} $forecast_temp$SYMBOL"
fi
