#!/bin/bash


## ==================  ==================

# ————————— 결과 —————————



### ================== 0~2 램덤 숫자 출력 ==================
for (( i = 0; i < 100; i++ )); do
    echo $((RANDOM%3))
done

### ================== 함수 사용: 구구단 퀴즈 만들기 ==================
#NUMBER=0
#NUMBER1=0
#NUMBER2=0
#CORRECT_ANSWER=0
#ANSWER=0
#CORRECT=0
#MAX_TRIES=3
#
#function generate_question(){
#  generate_numbers
#  determine_operation
#  QUESTION="$NUMBER1 $OPERATION $NUMBER2"
#}
#function generate_numbers(){
#  generate_number
#  NUMBER1=$NUMBER
#  generate_number
#  NUMBER2=$NUMBER
#}
#function generate_number(){
#  NUMBER=$((RANDOM%10+1))
#}
#function determine_operation(){
#  RAND=$((RANDOM%3))
#  case $RAND in
#    0) OPERATION='*';;
#    1) OPERATION='+';;
#    2) OPERATION='-';;
#  esac
#}
#
#function calculate_answer(){
#  CORRECT_ANSWER="$(echo "$QUESTION" | bc)"
#}
#
#function check_answer(){
#  if [ $ANSWER -eq $CORRECT_ANSWER 2>/dev/null ] ; then
#      echo "Correct!"
#      CORRECT=1
#    if [ $TRY -ne 1 ]; then
#      write_log
#    fi
#  else
#    if [ $TRY -eq $MAX_TRIES ]; then
#      TRY=$(($MAX_TRIES +1))
#      write_log
#      echo "The correct answer was  "
#      echo "Let's try the next one (press any key)"
#      read
#    else
#      TRY=$(($TRY+1))
#      echo "Nope sorry, please try again... (attempt $TRY)"
#    fi
#  fi
#}
#
#function init_log(){
#  echo "------------- Log for $(date +%d-%m-%Y' '%H:%M)" >> log
#}
#
#function write_log(){
#  if [ $TRY -le $MAX_TRIES ]; then
#    echo "Answer to $QUESTION ($CORRECT_ANSWER) given in $TRY tries" >> log
#  else
#    echo "Answer to $SQUESTION ($CORRECT_ANSWER) not given" >> log
#  fi
#}
#
#
#
#while true
#do
#  CORRECT=0
#  TRY=1
#  generate_question
#  calculate_answer
#  echo "How much is $QUESTION ? (attempt $TRY)"
#  echo "(Correct answer is $CORRECT_A NSWER)"
#  while [ $CORRECT -ne 1 ] && [ $TRY -le $MAX_TRIES ]
#  do
#    read "ANSWER" # 보안상 사용자 입력은 꼭 quote 하기
#    check_answer
#  done
#done
#
#exit 0


## ————————— 결과 —————————
##How much is 3 - 7 ? (attempt S1)
##-4
##Correct!
##(Correct answer is -4)
##How much is 8 + 5 ? (attempt S1)
##13
##Correct!
##(Correct answer is 13)
##How much is 2 * 9 ? (attempt S1)
##18
##Correct!


## ================== array 배열 ==================
#array=(one two three four [5]=five)
#
#echo "Array size: ${#array[*]}"
#
#echo "Array items:"
#for item in ${array[*]}
#do
#  printf "  %s\n" $item
#done
#
#echo "Array items and indexes:"
#for index in ${!array[*]}
#do
#  printf "%4d: %s\n" $index ${array[$index]}
#done

# ————————— 결과 —————————
#Array size: 5
#Array items:
#  one
#  two
#  three
#  four
#  five
#Array items and indexes:
#   0: one
#   1: two
#   2: three
#   3: four
#   5: five



## ==================  ==================
#echo "how are you?"
#read answer
#answer=`echo $answer | tr a-z A-Z` # 소문자 -> 대문자 변경
#[ -z $answer ] && exit 1 # empty 확인
#
#case $answer in
# GOOD)
#   echo "nice!";;
# BAD)
#   echo "too bad for you";;
# *)
#   echo "I don't understand your answer";;
#esac

# ————————— 결과 —————————
#how are you?
#good
#nice!

## ================== 현재 디렉토리 모두 출  ==================
for i in *; do echo $i; done

## ————————— 결과 —————————
#Bash
#DesignPattern
#...

# ================== 카운트 다운 ==================
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

### ================== Iteration Structures 사용하기 (select) ==================
#echo 'choose a directory: '
#select dir in /bin /usr /etc
#do
#  if [ -n "$dir" ] # only continue if user has selected something
#   then
#    DIR=$dir
#    echo you have selected $DIR
#    export DIR
#    break
#  else
#    echo invalid choice
#  fi
#done
### ————————— 결과 —————————
##choose a directory:
##1) /bin  2) /usr  3) /etc
##?# 4
##/Users/yoochulkim/IdeaProjects/SelfStudy/Bash/advanced.sh:14: command not found: x
##invalid choice
##?# 1
##/Users/yoochulkim/IdeaProjects/SelfStudy/Bash/advanced.sh:14: command not found: x
##you have selected /bin



### ================== declare: 특정 입력이 주어져야 할때 사용  ==================
#declare -r n=10
#echo "n=$n"
#n=20
#echo "n=$n"
#
## ————————— 결과 —————————
##n=10
##advanced.sh:8: read-only variable: n


## ================== 패턴 매칭 ==================
#BLAH=rababarabarabarara
#clear
#echo BLAH is $BLAH
#echo 'the result of ##*ba is' ${BLAH##*ba}
#echo 'the result of #*ba is' ${BLAH#*ba}
#echo 'the result of %ba* is' ${BLAH%%ba**}
#echo 'the result of %ba* is' ${BLAH%ba*}
#
## ————————— 결과 —————————
#BLAH is rababarabarabarara
#the result of ##*ba is rara
#the result of #*ba is barabarabarara
#the result of %ba* is ra
#the result of %ba* is rababarabara


# ================== CPU 사용 top 10개씩 모니터링 정보 1분마다 이메일로 받기 ==================
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
##    [ $USAGE2 -gt 80 ] && [ $PID1 = $PID2 ] && \
#    #  mail -s "CPU load of $PNAME is above 80%" hello.yoochul@gmail.com < .
#  fi
#done


# ================== 구구단 테스트기 만들기 + 결과 로깅하기 ==================
#logfile="$HOME/.fcalc-log"
#date >> $logfile
#while /bin/true; do
## 100까지 중 랜덤 숫자
# if [ "$(expr $RANDOM % 100)" -lt "70" ]; then
#  x=`expr $(expr $RANDOM % 4) + 6`
# else
#  x=`expr $RANDOM % 5`
# fi
# y=`expr $RANDOM % 10`
# rep=`expr $y \x $x`
# urep="-1"
#
#  while [ "$urep" -ne "$rep" ]; do
#   read -p "$y x $x = ?" urep
#   if [ "$urep" -ne "$rep" ]; then
#     echo "$y * $x = ?: $rep: WRONG" >> $logfile
#     beep
#   else
#     echo "$y * $x = ?: $rep: CORRECT" >> $logfile
#   fi
# done
#done

## ================== if 문 짧게 개선하기 ==================
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

## ================== 간단한 프로세스 모니터링 ==================
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
