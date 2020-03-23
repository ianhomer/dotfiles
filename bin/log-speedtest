#!/bin/bash
#
# brew install speedtest-cli
#

export LOG=~/.speedtest.log
echo "----" >> ${LOG}
date >> ${LOG}
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep " SSID" >> ${LOG}
/usr/local/bin/speedtest-cli --simple >> ${LOG}
