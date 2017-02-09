set-location 'C:\users\administrator\Ubiquiti Unifi'

java -jar lib\ace.jar uninstallsvc
C:\users\administrator\Desktop\UniFi-installer.exe
pause
java -jar lib\ace.jar installsvc
start-service unifi