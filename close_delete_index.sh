var=$(curl -XGET -u admin:admin 'https://localhost:9200/_cat/indices?h=index' --insecure | grep elastiflow-4.0.1-$(date  --date="6 day ago" +%Y.%m.%d))
curl -XPOST -u admin:admin https://localhost:9200/$var/_close --insecure
curl -XDELETE -u admin:admin https://localhost:9200/$var --insecure


