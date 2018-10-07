## Zabbix Dockerfiles

This repository contains **Dockerfile** of [Zabbix](https://zabbix.com/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/zabbix/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Base Docker Image

* [alpine](https://hub.docker.com/_/alpine/)
* [centos](https://hub.docker.com/_/centos/)
* [ubuntu](https://hub.docker.com/_/ubuntu/)

### Usage

Please follow usage instructions of each Zabbix component image:

* [zabbix-appliance](https://hub.docker.com/r/zabbix/zabbix-appliance/) - Zabbix appliance with built-in MySQL server, Zabbix server, Zabbix Java Gateway and Zabbix frontend based on Nginx web-server

* [zabbix-agent](https://hub.docker.com/r/zabbix/zabbix-agent/) - Zabbix agent
* [zabbix-server-mysql](https://hub.docker.com/r/zabbix/zabbix-server-mysql/) - Zabbix server with MySQL database support
* [zabbix-server-pgsql](https://hub.docker.com/r/zabbix/zabbix-server-pgsql/) - Zabbix server with PostgreSQL database support
* [zabbix-web-apache-mysql](https://hub.docker.com/r/zabbix/zabbix-web-apache-mysql/) - Zabbix web interface on Apache2 web server with MySQL database support
* [zabbix-web-apache-pgsql](https://hub.docker.com/r/zabbix/zabbix-web-apache-pgsql/) - Zabbix web interface on Apache2 web server with PostgreSQL database support
* [zabbix-web-nginx-mysql](https://hub.docker.com/r/zabbix/zabbix-web-nginx-mysql/) - Zabbix web interface on Nginx web server with MySQL database support
* [zabbix-web-nginx-pgsql](https://hub.docker.com/r/zabbix/zabbix-server-pgsql/) - Zabbix web interface on Nginx web server with PostgreSQL database support
* [zabbix-proxy-sqlite3](https://hub.docker.com/r/zabbix/zabbix-proxy-sqlite3/) - Zabbix proxy with SQLite3 database support
* [zabbix-proxy-mysql](https://hub.docker.com/r/zabbix/zabbix-proxy-mysql/) - Zabbix proxy with MySQL database support
* [zabbix-java-gateway](https://hub.docker.com/r/zabbix/zabbix-java-gateway/) - Zabbix Java Gateway
* [zabbix-snmptraps](https://hub.docker.com/r/zabbix/zabbix-snmptraps/) - Additional container image for Zabbix server and Zabbix proxy to support SNMP traps
