#!/bin/bash
# Wait for Kibana to be ready
echo "Waiting for Kibana..."
until curl -s http://localhost:5601/api/status | grep -q ""state":"green""; do
  sleep 5
done

# Create index pattern
curl -X POST "http://localhost:5601/api/saved_objects/index-pattern" \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d '{
    "attributes": {
      "title": "filebeat-*",
      "timeFieldName": "@timestamp"
    }
  }'

echo "Index pattern created."