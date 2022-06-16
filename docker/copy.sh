#!/bin/sh

# 复制项目的文件到对应docker路径，便于一键生成镜像。
usage() {
	echo "Usage: sh copy.sh"
	exit 1
}

echo "begin package "
#打包开始
cd ..
mvn clean install -Dmaven.test.skip=true
#前端
cd ./vctgo-ui
npm install --registry=https://registry.npmmirror.com
npm run build:prod
cd ../docker
# copy sql
echo "begin copy sql "
cp ../sql/vctgo_platform.sql ./mysql/db
cp ../sql/vctgo_config.sql ./mysql/db

# copy html
echo "begin copy html "
cp -r ../vctgo-ui/dist/** ./nginx/html/dist


# copy jar
echo "begin copy vctgo-gateway "
cp ../vctgo-gateway/target/vctgo-gateway.jar ./vctgo/gateway/jar

echo "begin copy vctgo-auth "
cp ../vctgo-auth/target/vctgo-auth.jar ./vctgo/auth/jar

echo "begin copy vctgo-monitor "
cp ../vctgo-visual/vctgo-monitor/target/vctgo-monitor.jar  ./vctgo/visual/monitor/jar

echo "begin copy vctgo-system "
cp ../vctgo-modules/vctgo-system/target/vctgo-system.jar ./vctgo/modules/system/jar

echo "begin copy vctgo-file "
cp ../vctgo-modules/vctgo-file/target/vctgo-file.jar ./vctgo/modules/file/jar

echo "begin copy vctgo-gen "
cp ../vctgo-modules/vctgo-gen/target/vctgo-gen.jar ./vctgo/modules/gen/jar

