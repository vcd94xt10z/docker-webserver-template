docker rm sqlserver
docker run --name sqlserver --network=docker-webserver_default -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=yourStrong(!)Password" -e "MSSQL_PID=Express" -p 1433:1433 -d microsoft/mssql-server-linux:latest
pause