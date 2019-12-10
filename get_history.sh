#!/bin/bash 

## Defaults
KPM_IP="192.168.100.225"
API_KEY="1d707811988069ca760826861d6d63a10e8c3b7f171c4441a6472ea58c11711b"
SMARTMETER_ID="1"
START_DATE="2019-12-06"
END_DATE="2019-12-06"

## Parse Parameter
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -a|--address)
    shift # skip argument
    KPM_IP="$1"
    ;;
    -m|--mode)
    shift # skip argument
    MODE="$1"
    ;;
    -s|--start)
    shift # skip argument
    START_DATE="$1"
    ;;
    -e|--end)
    shift # skip argument
    END_DATE="$1"
    ;;
    -i|--id)
    shift # skip argument
    SMARTMETER_ID="$1"
    ;;
    -k|--key)
    shift # skip argument
    API_KEY="$1"
    ;;
    -h|--help|*)
    HELP="1"
    ;;
    esac
    shift # skip parameter
done

## Echo Help
if [ "$HELP" = "1" ]; then
	echo "Basic usage: "
	echo `basename "$0"` "[OPTIONS]"
	echo ""
	echo "OPTIONS:"
	echo "  -h|--help	Help"
	echo "  -m|--mode       Mode [2=Last day | 1=Parameter]"
	echo "  -a|--address    Host IP of the Kentix PowerManager"
 	echo "  -s|--start      Start date [YYYY-MM-DD]"
	echo "  -e|--end        End date [YYYY-MM-DD]"
	echo "  -k|--key        API Key"
	echo "  -i|--id         Smartmeter id"
	exit 0
fi

if [ "$MODE" = "2" ]; then
        END_DATE=`date -d "yesterday 13:00" +%F`
        START_DATE=$END_DATE
fi

## Download history csv
wget --no-check-certificate -O ./"$KPM_IP"_"$SMARTMETER_ID"_"$START_DATE"_"$END_DATE".txt  "https://${API_KEY}:@${KPM_IP}/api/devices/smartmeter/${SMARTMETER_ID}/history?format=csv&sum-to=raw&start=${START_DATE}&end=${END_DATE}" 
