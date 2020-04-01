@echo off
::关闭回显
set isre=1
::是否重启 0为关 , 1为开
set retime=5
::设置重启等待时间
set restart=0
::设置重启次数初始值，默认为0，请勿修改
set maxre=10
::重启多少次后不再重启,设置成-1关闭
:start
::start节点

CLS
::清除屏幕上内容

set server_name=龙珠梦
::服务器名称，会在服务端的标题处显示
set min_ram=2048
::最小内存，默认2048，单位MB
set max_ram=8192
::最大内存，默认8192，单位MB
set tm1=%time:~0,2%
set tm2=%time:~3,2%
set tm3=%time:~6,2%
@echo. 
echo  现在时间：%date% %tm1%点%TM2%分
@echo. -----------------------------------------------------------------
@echo.                         %server_name%服务器     

@echo.           注意:关闭服务器前请在后台输入stop保存玩家数据
@echo.                      否则可能会出现回档情况
@echo.
@echo.                      服务器正在启动中,请稍等……
@echo.
@echo. -----------------------------------------------------------------
::启动时的一些显示

::警告，如果你使用x86架构的Java(即32位)，最大内存不能超过1024MB
set jar_name=Uranium-1710-dev-4-B210-server.jar
::设置服务端核心名称，默认路径为该批处理文件所在的根目录，需要写入文件后缀
if %isre% == 0 (title %server_name%服务器 最大内存%max_ram%M) else (title %server_name%服务器 最大内存%max_ram%M 重启次数%restart%次)
::设置的服务端标题，调用上面的一些变量，可酌情修改

java -server -Xincgc -Xmx%max_ram%M -Xms%min_ram%M -Xss512K -XX:+AggressiveOpts -XX:+UseCompressedOops -XX:+UseCMSCompactAtFullCollection -XX:+UseFastAccessorMethods -XX:ParallelGCThreads=4 -XX:+UseConcMarkSweepGC -XX:CMSFullGCsBeforeCompaction=2 -XX:CMSInitiatingOccupancyFraction=70 -XX:-DisableExplicitGC -XX:-DisableExplicitGC -XX:TargetSurvivorRatio=90 -jar %jar_name%
::Java命令行开服代码，不推荐修改，已进行优化，32位Java运行可能会有些许问题，如有问题请替换为下方代码
::java -Xincgc -Xmx%max_ram%M -Xms%min_ram%M -Xss512K -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:ParallelGCThreads=4 -XX:+UseConcMarkSweepGC -XX:CMSFullGCsBeforeCompaction=2 -XX:CMSInitiatingOccupancyFraction=70 -XX:-DisableExplicitGC -XX:-DisableExplicitGC -XX:TargetSurvivorRatio=90 -jar %jar_name%

@echo. -----------===服务端关闭，即将在五秒内重启,按Ctrl+C终止重启===------------
@echo.
@echo.               %server_name% --- 玩家数据保存完毕 已关服
@echo.
@echo. -----------------------------------------------------------------

set/a restart=restart+1

if %isre% == 0 (goto stop) else (goto restart)
:restart
::restart标签
::设置重启次数自加一，请勿修改
timeout /t %retime% /NOBREAK
if %restart% == %maxre% (goto stop) else (goto start)
:stop
if %isre% == 0 (echo 未开启自动重启，如果需要，请到bat中开启) else (echo 已经自动重启%maxre%次，停止自动重启，按任意键关闭)
pause