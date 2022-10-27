@echo off
echo.
echo [信息] 复制文件到Docker目录
echo.

%~d0
cd %~dp0

cd ..
echo 编译后端
start /wait cmd /c "mvn clean package -P prod -Dmaven.test.skip=true"
echo 编译前端
cd vctgo-ui
start /wait cmd /c "npm install"
start /wait cmd /c "npm run build:prod"
cd ..\docker

echo 复制 sql
xcopy ..\sql\vctgo_platform.sql .\mysql\db  /y
xcopy ..\sql\vctgo_config.sql .\mysql\db  /y

echo 复制 html
xcopy ..\vctgo-ui\dist .\nginx\html\dist  /s /e /y

echo 复制 vctgo-gateway
xcopy ..\vctgo-gateway\target\vctgo-gateway.jar .\vctgo\gateway\jar  /y

echo 复制 vctgo-auth
xcopy ..\vctgo-auth\target\vctgo-auth.jar .\vctgo\auth\jar  /y

echo 复制 vctgo-monitor
xcopy ..\vctgo-visual\vctgo-monitor\target\vctgo-monitor.jar  .\vctgo\visual\monitor\jar  /y

echo 复制 vctgo-system
xcopy ..\vctgo-modules\vctgo-system\target\vctgo-system.jar .\vctgo\modules\system\jar  /y

echo 复制 vctgo-file
xcopy ..\vctgo-modules\vctgo-file\target\vctgo-file.jar .\vctgo\modules\file\jar  /y

echo 复制 vctgo-gen
xcopy ..\vctgo-modules\vctgo-gen\target\vctgo-gen.jar .\vctgo\modules\gen\jar  /y

pause
