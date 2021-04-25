
var=$(curl -XGET -u admin:admin 'https://localhost:9200/_cat/indices?h=index' --insecure | grep elastiflow-4.0.1-$(date  --date="5 day ago" +%Y.%m.%d))
cd /dati/elasticsearch
zip -r /dati/snap_zip/$var.zip snapshots/

