#!/usr/bin/env bash


#JDK路径
#JAVA_HOME=""

#利用pwd命令获取当前工程目录，实际获取到的是该shell脚本的目录。再利用sed命令将/bin替换为空
Project_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd | sed 's/\/sbin//')

APPLICATION_MAIN=jrx.samples.springboot.RootApplication

#-------------------------------------------------------------------------------------------------------------
#getPID()-->获取Java应用的PID
#说明:通过JDK自带的JPS命令及grep命令,准确查找Java应用的PID
#其中:[jps -l]表示显示Java主程序的完整包路径
#     awk命令可以分割出PID($1部分)及Java主程序名称($2部分)
#例子:[$jps -l | grep $APPLICATION_MAIN]-->>[5775 jrx.anytxn.sms.App]
#另外:用这个命令也可以直接取到程序的PID-->>[ps aux|grep java|grep $APPLICATION_MAIN|grep -v grep|awk '{print $2}']
#-------------------------------------------------------------------------------------------------------------
#初始化全局变量tradePortalPID,用于标识交易前置系统的PID,0表示未启动
TPID=0

getPID(){
    javaps=`ps -ef | grep $APPLICATION_MAIN |awk '{print $2}'|xargs`
    if [ -n "$javaps" ]; then
        TPID=`echo $javaps | awk '{print $1}'`
    else
        TPID=0
    fi
}

TIMES=0
TIMEOUT=20
shutdown(){
    getPID

    if [ $TPID -ne 0 ]; then
        if [ $1 -ne 0 ]; then
            echo "=========================Stopping Service=============================="
            kill $TPID
            #echo $?

            if [ $? -eq 0 ]; then
                echo ""
            else
                echo "[Service Stop Failed]"
                return
            fi

            echo -n "Stopping $APPLICATION_MAIN(PID=$TPID)...";
        fi


        while [ $TPID -ne 0 ] && [ $TIMES -lt $TIMEOUT ]
        do
            getPID
            ((TIMES++))
            sleep 1
            echo -n "."
        done

    else
        echo "$APPLICATION_MAIN is not running"
        return
    fi

    sleep 1
    echo "."
    getPID
    if [ $TPID -eq 0 ]
    then
        echo "Service Stop Success."
    elif [ $TIMES -gt $TIMEOUT ] || [ $TIMES -eq $TIMEOUT ]
    then
        echo "Service Stop Time out, please kill -9 $TPID"
    fi

}

shutdown 3