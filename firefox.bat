@echo off

start C:\AppContainer\AppExec\wsudo.exe --appcontainer --lpac --env "MOZ_FORCE_DISABLE_E10S=114.0.1" --appid "AppContainer.Launcher" --appx "C:\AppContainer\AppExec\capabilities.xml" "C:\AppContainer\Firefox\bin\firefox.exe" -profile "C:\AppContainer\Firefox\profile" -private