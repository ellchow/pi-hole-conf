#!/usr/bin/env bash

tmpfile=`mktemp /tmp/XXXXX`
out="aggregated-comms.txt"

echo "tmpfile" $tmpfile

echo "#### " `date` > $tmpfile

cat custom-comms.txt >> $tmpfile

for url in "https://raw.githubusercontent.com/jmdugan/blocklists/refs/heads/master/corporations/apple/all" \
               "https://raw.githubusercontent.com/jmdugan/blocklists/refs/heads/master/corporations/facebook/all" \
               "https://raw.githubusercontent.com/jmdugan/blocklists/refs/heads/master/corporations/google/all"
do
    echo "fetching" $url

    echo "############## SOURCE:$url #######################" >> $tmpfile
    buffile=`mktemp /tmp/XXXXX`
    curl --fail $url >> $buffile

    grep '^#' $buffile >> $tmpfile
    echo >> $tmpfile

    grep -v '^#' $buffile | sort >> $tmpfile
    echo >> $tmpfile
    rm $buffile
done

mv $tmpfile $out

git add $out

git commit -m "update $out"
