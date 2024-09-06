[fix docker perimission error](https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket) 

[dotnet publish -c Release -r win-x64 --self-contained -p:PublishSingleFile=true -p:PublishReadyToRun=true]()


dotnet test specific test:

```
dotnet test -c Release --filter "FullyQualifiedName=Namespace.Class.TestFunction"
```
