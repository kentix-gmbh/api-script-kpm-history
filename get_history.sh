#!/bin/bash 

function check_pram_set(){
	if [ "$1" = "" ]; then
		echo $2
	fi

	echo $1
}

## Defaults
KPM_IP_D="10.15.20.60"
API_KEY_D="1d707811988069ca760826861d6d63a10e8c3b7f171c4441a6472ea58c11711b"
SMARTMETER_ID_D="41"
START_DATE_D="2019-12-06"
END_DATE_D="2019-12-06"

## Parse Parameter
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    HELP="1"
    shift # past argument
    shift # past value
    ;;
    -a|--address)
    KPM_IP="$2"
    shift # past argument
    shift # past value
    ;;
    -m|--mode)
    MODE="2"
    shift # past argument
    shift # past value
    ;;
    -s|--start)
    START_DATE="$2"
    shift # past argument
    ;;
    -e|--end)
    END_DATE="$2"
    shift # past argument
    ;;
    -i|--id)
    SMARTMETER_ID="$2"
    shift # past argument
    ;;
    -k|--key)
    API_KEY="$2"
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

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
        echo "x"
fi

## Check parameter Values
KPM_IP=$(check_pram_set $KPM_IP $KPM_IP_D)
API_KEY=$(check_pram_set $API_KEY $API_KEY_D)
SMARTMETER_ID=$(check_pram_set $SMARTMETER_ID $SMARTMETER_ID_D)
START_DATE=$(check_pram_set $START_DATE $START_DATE_D)
END_DATE=$(check_pram_set $END_DATE $END_DATE_D)

## Download history csv
wget --no-check-certificate -O ./"$KPM_IP"_"$SMARTMETER_ID"_"$START_DATE"_"$END_DATE".txt  "https://${API_KEY}:@${KPM_IP}/api/devices/smartmeter/${SMARTMETER_ID}/history?format=csv&sum-to=raw&start=${START_DATE}&end=${END_DATE}" 
