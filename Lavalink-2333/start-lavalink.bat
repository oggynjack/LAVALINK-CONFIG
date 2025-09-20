@echo off
:: === Lavalink Startup Script ===
:: Enable native access (fix Unsafe warnings) + run Lavalink

set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17   :: <- change if your Java is elsewhere
set PATH=%JAVA_HOME%\bin;%PATH%

java --enable-native-access=ALL-UNNAMED -jar Lavalink.jar
