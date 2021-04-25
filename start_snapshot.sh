var=$(curl -XGET -u admin:admin 'https://localhost:9200/_cat/indices?h=index' --insecure | grep elastiflow-4.0.1-$(date  --date="4 day ago" +%Y.%m.%d))
#echo $var
#[! -d "/dati/elasticsearch/snapshots/$var/" ] && echo "Directory $var does not exist."
if [ ! -d "/dati/elasticsearch/snapshots/$var" ] 
then
    
    echo " Directory $var  does not exists in snapshot repo creating directory $var"
    cd /dati/elasticsearch/snapshots/
    mkdir ${var}
    chown -R elasticsearch:elasticsearch ${var}			
fi

curl -XPUT -u admin:admin "https://localhost:9200/_snapshot/$var" --insecure  -H 'Content-Type: application/json' -d'{  "type": "fs",  "settings": {    "location": "/dati/elasticsearch/snapshots/$var",    "compress": true  }}'
curl -XPUT -u admin:admin "https://localhost:9200/_snapshot/$var/$var" --insecure  -H  'Content-Type: application/json' -d'{  "indices": "'$var'", "ignore_unavailable": true,  "include_global_state": false,  "metadata": {  "taken_by": "utku",  "taken_because": "test snapshot"}}'
echo "Snapshot process is started..."
