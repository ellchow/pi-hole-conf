#!/usr/bin/env bash

tmpfile=`mktemp /tmp/XXXXX`
out="aggregated-blacklist.txt"

echo "tmpfile" $tmpfile

echo "#### " `date` > $tmpfile

for url in "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardApps.txt" \
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardDNS.txt" \
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileAds.txt" \
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileSpyware.txt" \
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardTracking.txt" \
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/EasyPrivacy3rdParty.txt" \
        "https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/EasyPrivacySpecific.txt" \
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts" \
        "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" \
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt" \
        "https://v.firebog.net/hosts/RPiList-Malware.txt" \
        "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt"
do
    echo "fetching" $url

    echo "############## SOURCE:$url #######################" >> $tmpfile
    curl --fail $url >> $tmpfile
    echo >> $tmpfile
done

mv $tmpfile $out

git add $out

git commit -m "update $out"
