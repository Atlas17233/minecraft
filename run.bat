@echo off
::�رջ���
set isre=1
::�Ƿ����� 0Ϊ�� , 1Ϊ��
set retime=5
::���������ȴ�ʱ��
set restart=0
::��������������ʼֵ��Ĭ��Ϊ0�������޸�
set maxre=10
::�������ٴκ�������,���ó�-1�ر�
:start
::start�ڵ�

CLS
::�����Ļ������

set server_name=������
::���������ƣ����ڷ���˵ı��⴦��ʾ
set min_ram=2048
::��С�ڴ棬Ĭ��2048����λMB
set max_ram=8192
::����ڴ棬Ĭ��8192����λMB
set tm1=%time:~0,2%
set tm2=%time:~3,2%
set tm3=%time:~6,2%
@echo. 
echo  ����ʱ�䣺%date% %tm1%��%TM2%��
@echo. -----------------------------------------------------------------
@echo.                         %server_name%������     

@echo.           ע��:�رշ�����ǰ���ں�̨����stop�����������
@echo.                      ������ܻ���ֻص����
@echo.
@echo.                      ����������������,���Եȡ���
@echo.
@echo. -----------------------------------------------------------------
::����ʱ��һЩ��ʾ

::���棬�����ʹ��x86�ܹ���Java(��32λ)������ڴ治�ܳ���1024MB
set jar_name=Uranium-1710-dev-4-B210-server.jar
::���÷���˺������ƣ�Ĭ��·��Ϊ���������ļ����ڵĸ�Ŀ¼����Ҫд���ļ���׺
if %isre% == 0 (title %server_name%������ ����ڴ�%max_ram%M) else (title %server_name%������ ����ڴ�%max_ram%M ��������%restart%��)
::���õķ���˱��⣬���������һЩ�������������޸�

java -server -Xincgc -Xmx%max_ram%M -Xms%min_ram%M -Xss512K -XX:+AggressiveOpts -XX:+UseCompressedOops -XX:+UseCMSCompactAtFullCollection -XX:+UseFastAccessorMethods -XX:ParallelGCThreads=4 -XX:+UseConcMarkSweepGC -XX:CMSFullGCsBeforeCompaction=2 -XX:CMSInitiatingOccupancyFraction=70 -XX:-DisableExplicitGC -XX:-DisableExplicitGC -XX:TargetSurvivorRatio=90 -jar %jar_name%
::Java�����п������룬���Ƽ��޸ģ��ѽ����Ż���32λJava���п��ܻ���Щ�����⣬�����������滻Ϊ�·�����
::java -Xincgc -Xmx%max_ram%M -Xms%min_ram%M -Xss512K -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:ParallelGCThreads=4 -XX:+UseConcMarkSweepGC -XX:CMSFullGCsBeforeCompaction=2 -XX:CMSInitiatingOccupancyFraction=70 -XX:-DisableExplicitGC -XX:-DisableExplicitGC -XX:TargetSurvivorRatio=90 -jar %jar_name%

@echo. -----------===����˹رգ�����������������,��Ctrl+C��ֹ����===------------
@echo.
@echo.               %server_name% --- ������ݱ������ �ѹط�
@echo.
@echo. -----------------------------------------------------------------

set/a restart=restart+1

if %isre% == 0 (goto stop) else (goto restart)
:restart
::restart��ǩ
::�������������Լ�һ�������޸�
timeout /t %retime% /NOBREAK
if %restart% == %maxre% (goto stop) else (goto start)
:stop
if %isre% == 0 (echo δ�����Զ������������Ҫ���뵽bat�п���) else (echo �Ѿ��Զ�����%maxre%�Σ�ֹͣ�Զ���������������ر�)
pause