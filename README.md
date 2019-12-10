# Script for downloading consumption values from a Kentix PowerManager

## Requirements
OS: macOS or Linux
Dependencies: wget, bash

## Installing
1. Checkout the script
2. chmod a+x ./get_history.sh

## Usage
```
get_history.sh [OPTIONS]

OPTIONS:
  -h|--help	Help
  -m|--mode       Mode [2=Last day | 1=Parameter]
  -a|--address    Host IP of the Kentix PowerManager
  -s|--start      Start date [YYYY-MM-DD]
  -e|--end        End date [YYYY-MM-DD]
  -k|--key        API Key
  -i|--id         Smartmeter id
```
