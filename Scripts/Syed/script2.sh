#!/bin/bash
mkdir -p lgfilesgen/
a=planet
echo $(awk -v tourname="$a" '/<LookAt>/,/<\/LookAt>/{if (/<LookAt>/) print tourname"@"name"@flytoview="$0""; else print} /<name>/,/<\/name>/ {gsub(/<.?name>/,"");name=$0}' doc.kml)   | sed -e 's/ //g;s/'$a'@/\n'$a'@/g' > queries.txt
sed -n '/name/{s/.*<name>//;s/<\/name.*//;p;}' doc.kml > lgfilesgen/name.txt
sed -n '/latitude/{s/.*<latitude>//;s/<\/latitude.*//;p;}' doc.kml > lgfilesgen/latitude.txt
sed -n '/longitude/{s/.*<longitude>//;s/<\/longitude.*//;p;}' doc.kml > lgfilesgen/longitude.txt
sed -n '/altitude/{s/.*<altitude>//;s/<\/altitude.*//;p;}' doc.kml > lgfilesgen/altitude1.txt
grep -v "<gx:altitudeMode>" lgfilesgen/altitude1.txt > lgfilesgen/altitude.txt
sed -n '/heading/{s/.*<heading>//;s/<\/heading.*//;p;}' doc.kml > lgfilesgen/heading.txt
sed -n '/tilt/{s/.*<tilt>//;s/<\/tilt.*//;p;}' doc.kml > lgfilesgen/tilt.txt
sed -n '/range/{s/.*<range>//;s/<\/range.*//;p;}' doc.kml > lgfilesgen/range.txt
sed -n '/gx:altitudeMode/{s/.*<gx:altitudeMode>//;s/<\/gx:altitudeMode.*//;p;}' doc.kml > lgfilesgen/altitudeMode.txt
sed 1d lgfilesgen/name.txt > lgfilesgen/temp1.txt
sed 1d lgfilesgen/temp1.txt > lgfilesgen/temp.txt
lines= wc -l < lgfilesgen/temp.txt
lines1=1
echo "Name;Latitude;Longitude;Altitude;Heading;Tilt;Range;Altitude Mode;" >> queries.csv
cat lgfilesgen/temp.txt | while read line
do
echo $lines1
sed -n ''$lines1'p' lgfilesgen/temp.txt >> queries$lines1.txt 
sed -n ''$lines1'p' lgfilesgen/latitude.txt >> queries$lines1.txt
sed -n ''$lines1'p' lgfilesgen/longitude.txt >> queries$lines1.txt
sed -n ''$lines1'p' lgfilesgen/altitude.txt >> queries$lines1.txt
sed -n ''$lines1'p' lgfilesgen/heading.txt >> queries$lines1.txt
sed -n ''$lines1'p' lgfilesgen/tilt.txt >> queries$lines1.txt
sed -n ''$lines1'p' lgfilesgen/range.txt >> queries$lines1.txt
sed -n ''$lines1'p' lgfilesgen/altitudeMode.txt >> queries$lines1.txt
cat queries$lines1.txt > tempo$lines1.txt
sed 's/[[:space:]]\+/;/g' tempo$lines1.txt >> queries$lines1.csv
awk 'NR%8{printf "%s ;",$0;next;}1' queries$lines1.csv >> queries.csv
sudo rm tempo$lines1.txt
sudo rm queries$lines1.txt
sudo rm queries$lines1.csv
lines1=$(($lines1+1))
done
sudo rm -rf lgfilesgen
