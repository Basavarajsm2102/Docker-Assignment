# EFK Stack to Monitor Nginx Logs

This project sets up an Elasticsearch-Filebeat-Kibana (EFK) stack using Docker Compose to monitor Nginx access and error logs.

## Features

- Real-time log ingestion from Nginx using Filebeat
- Visualize logs in Kibana with custom dashboards
- Auto-create index pattern `filebeat-*` for quick setup
- Logs stored in Elasticsearch for querying

## Access

- Nginx: http://localhost
- Kibana: http://localhost:5601

## Usage

```bash
docker-compose up -d
```

## Optional Enhancements

- Customize Kibana dashboard for log analysis
- Alerting with ElastAlert or Watcher (advanced)
- Enable basic security on Elasticsearch stack (paid feature)

## Author

Generated via AI assistant to demonstrate EFK stack setup.