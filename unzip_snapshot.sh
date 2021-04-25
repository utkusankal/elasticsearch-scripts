#!/bin/bash
#var=$(curl -XGET -u admin:admin 'https://localhost:9200/_cat/indices?h=index' --insecure | grep elastiflow-4.0.1-$(date  --date="5 day ago" +%Y.%m.%d))
cd /dati/snap_zip
array=($(ls ))
#echo ${array[@]} 
#echo ${array[0]}
len=${#array[@]}
echo $len
n=0
echo "Available compressed snapshots for restore operation are : "

for i in "${array[@]}"
do
	let n=${n}+1
	echo "$n =  $i"
done

while true; 
do
	
	read -p  "Please enter a number between 1 to $len to unzip and restore the snapshot you wish or press 'q' or 'Q' to exit the program :" id
	
	if [[ $id == [Qq] ]]; then
    		echo "Exiting"
    		exit
	fi
	if [ "$id" -gt 0 ] && [ "$id" -le "$len" ]; then
        	break
    	fi
done
var= ${array[id-1]}
echo $var




cd /dati/snap_zip
unzip ${array[id-1]} -d /dati/elasticsearch/snapshots/ 


cd /dati/elasticsearch/snapshots
cp -R snapshots/* .
rm -rf snapshots/
cd ..
chown -R elasticsearch:elasticsearch snapshots/
curl -XPOST -u admin:admin  https://localhost:9200/_snapshot/$var/$var/_restore --insecure








