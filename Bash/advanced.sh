
# ————————— CPU 사용 top 10개씩 모니터링 정보 1분마다 이메일로 받기 —————————
# 실행해보기 -> ps -eo pcpu,pid -o comm= | sort -k1 -n -r  | head -10
#while true
#do
#  sleep 1
#  USAGE1=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -10 | awk '{ print $1 } '`
#  USAGE1=${USAGE1%.*}
#  PID1=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -10 | awk '{print $2 }'`
#  PNAME1=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -10 | awk '{print $3 }'`
#  if [ $USAGE1 -gt 80 ]
#  then
#     sleep 1
#    USAGE2=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{ print $1 }'`
#    USAGE2=${USAGE2%.*}
#    PID2=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{print $2 }'`
#    PNAME2=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{print $3 }'`
#    [ $USAGE2 -gt 80 ] && [ $PID1 = $PID2 ] && \
#    #  mail -s "CPU load of $PNAME is above 80%" hello.yoochul@gmail.com < .
#  fi
#done


# ————————— 구구단 테스트기 만들기 + 결과 로깅하기 —————————

logfile="$HOME/.fcalc-log"
date >> $logfile
while /bin/true; do
# 100까지 중 랜덤 숫자
 if [ "$(expr $RANDOM % 100)" -lt "70" ]; then
  x=`expr $(expr $RANDOM % 4) + 6`
 else
  x=`expr $RANDOM % 5`
 fi
 y=`expr $RANDOM % 10`
 rep=`expr $y \x $x`
 urep="-1"

  while [ "$urep" -ne "$rep" 1; do
   read -p "$y x $x = ?" urep
   if [ "$urep" -ne "$rep" 1; then
     echo "$y * $x = ?: $rep: WRONG" >> $logfile
     beep
   else
     echo "$y * $x = ?: $rep: CORRECT" >> $logfile
   fi
 done
done


# ————————— 카운트 다운 —————————
#COUNTER=$1
#COUNTER=$(( COUNTER * 60 ))
#mineen(){
#  COUNTER=$(( COUNTER - 1))
#  sleep 1
#}
#
#while [ $COUNTER -gt 0 ]
#do
#  echo you still have $COUNTER seconds
#  mineen
#done
#
#[ $COUNTER = 0 ] && echo out of time && mineen
#[ $COUNTER = "-1" ] && echo you are one second late && mineen
#
#while true
#do
#  echo you are ${COUNTER#*-} seconds late
#  mineen
#done

## ————————— if 문 짧게 개선하기 —————————
## BEFORE
#if [ -z $1 1]
#then
#  echo no argument provided
#exit 1
#elif [ ! -e $1]
#then
#  echo $1 does not exist
#exit 2
#elif [ -d $1 ]
#then
#  echo $1 is a directory
#elif [ ! -f $1 ]
#then
#  echo $1 is a not a directory and not a file
#elif [ -x $1]
#then
#  echo $1 is an executable file
#elif grep '#!/bin/bash' $1
#then
#  echo $1 is a non-executable bash script
#chmod +x $1
#else
#  echo I don\'t know what this is
#fi
#
## AFTER
#[ -z $1 ] && echo no argument provided && exit 1
#[ ! -e $1 ] && echo $1 does not exist && exit 2
#[ -d $1 ] && echo $1 is a directory && exit
#[ ! -f $1 ] && echo $1 is not a directory or file && exit
#[ -x $1 ] && echo $1 is executable && exit
#grep '#!/bin/bash' $1 && echo $1 is a non-executable shell script && chmod +x $1 && exit
#echo I don\'t know what this is

## ————————— 간단한 프로세스 모니터링 —————————
# 웹서버가 작동하고 있다면 계속 while 문 돌게
#PROCESS=httpd
#COUNTER=0
#while ps aux | grep $PROCESS | grep -v grep > /dev/null
#do
#  COUNTER=$((COUNTER+1))
#  sleep 1
#  echo COUNTER is $COUNTER
#done
#
#logger PROCESSMONITOR: $PROCESS stopped at `date`
#/etc/init.d/apache2 start
#mail -s "Apache server just stopped" mail@example.com < .
