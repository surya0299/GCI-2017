#!/bin/bash
echo "Installing Unzip first"
sudo apt-get install unzip
FILE_NAME=""
read -p "Enter the name of the exported file: " FILE_NAME
echo "Unzipping KMZ file"
unzip $FILE_NAME.kmz
echo "The file will be extracted to the same directory as of the .KMZ file"
inputfile=doc.kml
outputfile=queries.txt
trnm=""
read -p "Enter the TourName: " trnm
if [ -f $outputfile ]; then 
outputfile2=temp.txt 
echo $(awk -v tourname="$trnm" '/<LookAt>/,/<\/LookAt>/{if (/<LookAt>/) print tourname"@"name"@flytoview="$0""; else print} /<name>/,/<\/name>/ {gsub(/<.?name>/,"");name=$0}' $inputfile)   | sed -e 's/ //g;s/'$trnm'@/\n'$trnm'@/g' > $outputfile2
cat "$outputfile2" >> "$outputfile"
else
echo $(awk -v tourname="$trnm" '/<LookAt>/,/<\/LookAt>/{if (/<LookAt>/) print tourname"@"name"@flytoview="$0""; else print} /<name>/,/<\/name>/ {gsub(/<.?name>/,"");name=$0}' $inputfile)   | sed -e 's/ //g;s/'$trnm'@/\n'$trnm'@/g' > $outputfile
fi
echo "Output file: " $outputfile
