# 🔍 EFK Stack for Monitoring Nginx Logs

This project sets up an **EFK (Elasticsearch + Filebeat + Kibana)** stack using `docker-compose` to monitor Nginx access and error logs in real-time.

---

## 📚 Table of Contents

- [🧩 Project Overview](#-project-overview)
- [⚙️ How It Works](#-how-it-works)
- [🚀 Prerequisites](#-prerequisites)
- [📦 Setup Instructions](#-setup-instructions)
- [🌐 Accessing the Components](#-accessing-the-components)
- [📊 Configuring Kibana Dashboards](#-configuring-kibana-dashboards)
- [💡 Additional Features](#-additional-features)
- [🧪 Testing the Setup](#-testing-the-setup)
- [📁 Project File Structure](#-project-file-structure)
- [📸 Screenshots (Optional)](#-screenshots-optional)
- [🛠️ Troubleshooting](#-troubleshooting)

---

## 🧩 Project Overview

This project demonstrates a complete log monitoring solution using the EFK stack:
- **Nginx**: A web server that generates access and error logs.
- **Filebeat**: A lightweight shipper that collects and forwards Nginx logs to Elasticsearch.
- **Elasticsearch**: A search and analytics engine that stores and indexes logs.
- **Kibana**: A visualization tool to create dashboards and analyze log data.

The stack is orchestrated using Docker and Docker Compose for easy setup and scalability.

---

## ⚙️ How It Works

1. Nginx generates access and error logs, which are written to `/var/log/nginx` and mapped to a Docker volume for persistence.
2. Filebeat reads these logs from the volume and ships them to Elasticsearch.
3. Elasticsearch stores the logs in a `filebeat-*` index.
4. Kibana connects to Elasticsearch to visualize the logs through dashboards, charts, and tables.

---

## 🚀 Prerequisites

To run this project, ensure you have the following installed:
- **Docker**: Version 20.10 or higher
- **Docker Compose**: Version 1.29 or higher
- **Optional (for testing)**: `curl` to generate sample requests

Verify installation:
```bash
docker --version
docker-compose --version
curl --version
```

---

## 📦 Setup Instructions

Follow these steps to set up and run the EFK stack:

1. **Clone the Repository**:
   ```bash
   git clone <your-repo-url>
   cd Docker-Assignment
   ```

2. **Set Filebeat Configuration Permissions**:
   Ensure the Filebeat configuration file has the correct permissions:
   ```bash
   sudo chown root:root filebeat/filebeat.yml
   sudo chmod 600 filebeat/filebeat.yml
   ```

3. **Start the EFK Stack**:
   Launch all services using Docker Compose:
   ```bash
   docker-compose up -d
   ```

4. **Set Up Kibana Index Pattern**:
   Run the provided script to configure the Kibana index pattern:
   ```bash
   bash scripts/setup-kibana-index-pattern.sh
   ```

---

## 🌐 Accessing the Components

Once the stack is running, access the components using the following URLs and credentials:

| Component       | URL                      | Default Credentials         |
|-----------------|--------------------------|-----------------------------|
| Nginx           | http://localhost:8080    | None                        |
| Kibana          | http://localhost:5601    | `elastic` / `changeme%`     |
| Elasticsearch   | http://localhost:9200    | `elastic` / `changeme%`     |

**Note**: Replace `changeme%` with your custom password if you modified the default Elasticsearch credentials.

---

## 📊 Configuring Kibana Dashboards

To visualize logs in Kibana, follow these steps:

1. Open Kibana at http://localhost:5601.
2. Log in with:
   - **Username**: `elastic`
   - **Password**: `changeme%`
3. Navigate to **Management → Stack Management → Index Patterns**.
4. Click **Create index pattern**.
5. Enter `filebeat-*` as the index pattern name.
6. Select `@timestamp` as the time field and click **Create**.
7. Go to **Discover** to explore raw log data.
8. Create visualizations (e.g., pie charts, line charts) in **Visualize** or dashboards in **Dashboard**.

**Suggested Visualizations**:
- **Pie Chart**: Breakdown of `nginx.access.response_code` (e.g., 200, 404).
- **Line Chart**: Log events over time using `@timestamp`.
- **Table**: Top requested URLs (`nginx.access.url`).

---

## 💡 Additional Features

- **Persistent Logs**: Logs are stored in Docker volumes for persistence across container restarts.
- **Real-time Monitoring**: Filebeat ships logs in real-time to Elasticsearch.
- **Automated Setup**: The `setup-kibana-index-pattern.sh` script simplifies Kibana configuration.
- **Scalable**: Easily extend the setup by adding more services or modifying `docker-compose.yml`.

---

## 🧪 Testing the Setup

Generate sample logs to verify the pipeline:

1. **Trigger Nginx Logs**:
   Make a request to Nginx to generate an access log:
   ```bash
   curl http://localhost:8080/
   ```

2. **Check Nginx Logs**:
   View the logs directly in the Nginx container:
   ```bash
   docker exec -it nginx cat /var/log/nginx/access.log
   ```

3. **Verify Logs in Elasticsearch**:
   Confirm logs are indexed in Elasticsearch:
   ```bash
   curl -u elastic:changeme% http://localhost:9200/_cat/indices?v | grep filebeat
   ```

4. **View Logs in Kibana**:
   Go to Kibana’s **Discover** tab to see the logs in the `filebeat-*` index.

---

## 📁 Project File Structure

The project is organized as follows:

```
Docker-Assignment/
├── docker-compose.yml           # Defines services for Nginx, Filebeat, Elasticsearch, Kibana
├── elasticsearch/              # Elasticsearch configuration
│   └── Dockerfile
├── filebeat/                   # Filebeat configuration
│   ├── Dockerfile
│   └── filebeat.yml
├── kibana/                     # Kibana configuration
│   └── Dockerfile
├── nginx/                      # Nginx configuration
│   ├── Dockerfile
│   └── logs/                   # Volume for Nginx logs
├── scripts/                    # Helper scripts
│   └── setup-kibana-index-pattern.sh
└── README.md                   # Project documentation
```

---

## 📸 Screenshots (Optional)

To enhance your README, consider adding screenshots of:
- **Kibana Dashboard**: Showing visualizations like response code distribution.
- **Discover Tab**: Displaying raw Nginx logs.
- **Custom Visualizations**: E.g., pie chart of response codes or line chart of request trends.

Upload screenshots to your repository and link them here (e.g., `![Kibana Dashboard](screenshots/dashboard.png)`).

---

## 🛠️ Troubleshooting

- **Filebeat Permission Issues**:
  - Ensure `filebeat.yml` has `root:root` ownership and `600` permissions.
  - Run `sudo chmod -R 777 nginx/logs` if Filebeat cannot read logs.
- **Elasticsearch Not Starting**:
  - Check Docker logs: `docker logs elasticsearch`.
  - Ensure port `9200` is free.
- **Kibana Index Pattern Not Found**:
  - Verify the `filebeat-*` index exists using the `curl` command above.
  - Re-run the `setup-kibana-index-pattern.sh` script.
- **No Logs in Kibana**:
  - Confirm Nginx is generating logs (`curl http://localhost:8080`).
  - Check Filebeat logs: `docker logs filebeat`.

For further assistance, check the official documentation:
- [Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Filebeat](https://www.elastic.co/guide/en/beats/filebeat/current/index.html)
- [Kibana](https://www.elastic.co/guide/en/kibana/current/index.html)
