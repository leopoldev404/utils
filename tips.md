[fix docker perimission error](https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket) 

[dotnet publish -c Release -r win-x64 --self-contained -p:PublishSingleFile=true -p:PublishReadyToRun=true]()


dotnet test specific test:

```
dotnet test -c Release --filter "FullyQualifiedName=Namespace.Class.TestFunction"
```


Connect to postgres db container

```sh
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
