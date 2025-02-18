- install csharpier: `dotnet tool install csharpier --create-manifest-if-needed`

[fix docker perimission error](https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue) 

[dotnet publish -c Release -r win-x64 --self-contained -p:PublishSingleFile=true -p:PublishReadyToRun=true]()


## Kill Docker Containers

```bash
docker stop $(docker ps -q) && docker rm $(docker ps -a -q)
```

## dotnet test specific test:

```
dotnet test -c Release --filter "FullyQualifiedName=Namespace.Class.TestFunction"
```


## Connect to postgres db container

```sh
#connect to postgres container and then connect to external database
docker exec -it <container_id> /bin/bash
psql -h <host> -p <port> -d <database> -U <username>

# asks for password


# connect to container
docker exec -it <container_name_or_id> psql -U <username>

# list databases
\l

# connect do db
\c database_name

# list tables
select table_name from information_schema.tables where table_schema = 'public';

# list tables with postgres internal meta-command
\dt

# describe table
select column_name, data_type
from information_schema.columns
where table_name = 'table_name' and table_schema = 'public';

# describe table with postgres internal meta-command
\d table_name;

```
