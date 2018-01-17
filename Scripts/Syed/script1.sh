#!/bin/bash
sum=0.0
sum1=0.0
sed -n '/gx:duration/{s/.*<gx:duration>//;s/<\/gx:duration.*//;p;}' doc.kml > durationtemp.txt
sed 1d durationtemp.txt > duration.txt
rm durationtemp.txt
while read line; do
answer=$(bc <<<"$sum1+$line")
sum=$(echo $sum+$answer | bc)
done < "$1"
echo "Exact time :"
echo $sum
echo "In the desired SS.mmm format"
printf "%.3f\n" "$sum"
rm duration.txt
