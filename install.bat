@echo off
echo "陕西中光电信高科技有限公司"
mkdir "D:\mean"
mkdir "D:\mean\install_log"
mkdir "D:\mean\web"

set path=%path%;D:\mean\nodejs;C:\Users\Administrator\AppData\Roaming\npm;D:\mean\mongodb\bin

msiexec /i node-v5.6.0-x64.msi INSTALLDIR="d:\mean\nodejs" /quiet /passive /norestart /l* "D:\mean\install_log\nodejs.install.log"
msiexec /i mongodb-win32-x86_64-2008plus-ssl-3.2.1-signed.msi INSTALLLOCATION="d:\mean\mongodb" /quiet /passive /norestart /l* "D:\mean\install_log\mongodb.install.log"

mkdir "D:\mean\mongodb\data"
mkdir "D:\mean\mongodb\log"

echo  ##store data here  > D:\mean\mongodb\mongo.config
echo  dbpath=D:\mean\mongodb\data >> D:\mean\mongodb\mongo.config
echo  ##all output go here >> D:\mean\mongodb\mongo.config
echo  logpath=D:\mean\mongodb\log\mongo.log >> D:\mean\mongodb\mongo.config
echo  ##log read and write operations >> D:\mean\mongodb\mongo.config
echo  diaglog=3 >> D:\mean\mongodb\mongo.config

mongod --config=D:\mean\mongodb\mongo.config --install
echo npm install -g express-generator > chuli1.bat
call chuli1.bat
del chuli1.bat
echo express "D:\mean\web" > chuli2.bat
call chuli2.bat
del chuli2.bat
D:
cd "D:\mean\web"
echo var rf=require("fs"); > update.js 
echo var data=rf.readFileSync("package.json","utf-8");  >> update.js 
echo JSON.parse(data); >> update.js 
echo var myjs = JSON.parse(data); >> update.js 
echo myjs.dependencies.mongodb = "~1.4"; >> update.js 
echo myjs.dependencies.monk = "*"; >> update.js 
echo myjs.dependencies.multer = "*"; >> update.js 
echo myjs['dependencies']['express-handlebars'] = "*"; >> update.js 
echo delete myjs.dependencies.jade; >> update.js 
echo  var str = JSON.stringify(myjs)  >> update.js 
echo rf.writeFile("package.json",str,function (err) { >> update.js 
echo      if (err) throw err ; >> update.js 
echo      console.log("File Saved !"); //文件被保存 >> update.js 
echo }) ; >> update.js 
node update.js 
echo npm install --registry=http://registry.npm.taobao.org > chuli3.bat
call chuli3.bat
del chuli3.bat
del update.js
pause