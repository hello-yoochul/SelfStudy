#!/bin/sh

# ————————— 변수 —————————

#echo "What is your name?"
#read PERSON
#echo "Hello, $PERSON"

#today=`date`
#echo $today

# valid variable names
#_ALI
#TOKEN_A
#VAR_1
#VAR_2

# invalid variable names
#2_VAR
#-VARIABLE
#VAR1-VAR2
#VAR_A!

# 바꿀 수 없음
#NAME="Zara Ali"
#readonly NAME
#unset NAME

# ————————— 특수 변수 —————————

# 실행해보기 -> ./basic.sh a b c d e
#echo "파일 이름:" $0
#echo "호출된 인수 번호: " $1
#echo "호출된 인수 번호: " $2
#echo "호출된 인수 개수: " $#
#echo "통합된 모든 인수: " $*
#echo "따옴표로 나눠진 모든 인수: " $@
#echo "마지막으로 실행된 명령의 종료 상태: " $?
#echo "현재 쉘의 PID: " $$
#echo "마지막 백그라운드 명령의 프로세스 번호: " $!

# ./basic.sh a b c d e
#for TOKEN in $*
#do
#   echo $TOKEN
#done

# ————————— 배열 —————————

#declare -a nameArr=("yoochul01" "yoochul02" "yoochul03")

## now loop through the above nameArray
#for i in "${nameArr[@]}"
#do
#   echo "$i"
#   # or do whatever with individual element of the nameArray
#done

#echo ${nameArr[0]}
#echo ${nameArr[1]}
#echo ${nameArr[*]}
#echo ${nameArr[@]}

#NAME[0]="Zara"
#NAME[1]="Qadir"
#NAME[2]="Mahnaz"
#NAME[3]="Ayan"
#NAME[4]="Daisy"
#echo "First Method: ${NAME[*]}"
#echo "Second Method: ${NAME[@]}"

# ————————— 연산자 —————————
#val=`expr 2 + 2`
#echo "Total value : $val"

#a=10
#b=20
#echo `expr $a + $b`
#echo `expr $a \* $b` # 곱하기
#echo `expr $b / $a`
#echo `expr $b % $a`

#if [ $a -eq $b ]; then
#  echo "true"
#else
#  echo "false"
#fi
#
## a < 20 || b > 100
#if [ $a -lt 20 -o $b -gt 100 ]; then
#  echo "true"
#else
#  echo "false"
#fi
#
## a < 20 && b > 100
#if [ $a -lt 20 -a $b -gt 100 ]; then
#  echo "true"
#else
#  echo "false"
#fi
#
## 스트링 연산자
#if [ -z "string" ]; then
#  echo "null 아님"
#else
#  echo "null"
#fi


# ————————— Shell Loop Types —————————


#a=0
#while [ "$a" -lt 10 ]    # this is loop1
#do
#   b="$a"
#   while [ "$b" -ge 0 ]  # this is loop2
#   do
#      echo -n "$b"
#      b=`expr $b - 1`
#   done
#   echo
#   a=`expr $a + 1`
#done

#  ————————— Shell Loop Control —————————
#a=10
#until [ $a -lt 0 ]
#do
#   echo $a
#   a=`expr $a - 1`
#done

#a=0
#while [ $a -lt 10 ]
#do
#   echo $a
#   if [ $a -eq 5 ]
#   then
#      break
#   fi
#   a=`expr $a + 1`
#done

#for var1 in 1 2 3
#do
#   for var2 in 0 5
#   do
#      if [ $var1 -eq 2 -a $var2 -eq 0 ]
#      then
#        # Outer 까지 나가게 설정
#         break 2
#      else
#         echo "$var1 $var2"
#      fi
#   done
#done

#NUMS="1 2 3 4 5 6 7"
#
#for NUM in $NUMS
#do
#   Q=`expr $NUM % 2`
#   if [ $Q -eq 0 ]
#   then
#      echo "$NUM is an even number!!"
#      continue
#   fi
#done

# ————————— Shell Substitution —————————
#USERS=`who | wc -l`
#echo "Logged in user are $USERS"
#
#UP=`uptime`
#echo "Uptime is $UP"

#echo ${var:-"1111"}
#echo "1 - Value of var is ${var}"
#
#echo ${var:="2222"}
#echo "2 - Value of var is ${var}"
#
#unset var
#echo ${var:+"3333"}
#echo "3 - Value of var is $var"
#
#var="Prefix"
#echo ${var:+"4444"}
#echo "4 - Value of var is $var"
#
#echo ${var:?"5555"}
#echo "5 - Value of var is ${var}"

# ————————— IO Redirections —————————
# 라인 개수
#wc -l << EOF
#   This is a simple lookup program
#	for good (and bad) restaurants
#	in Cape Town.
#EOF

# ————————— Shell Functions —————————
# Define your function here
#Hello () {
#   echo "Hello World $1 $2"
#}
#
## Invoke your function
#Hello Zara Ali


#number_one () {
#   echo "11 function..."
#   number_two
#}
#
#number_two () {
#   echo "22 function..."
#}
#number_one
## 함수도 unset 가능
#unset -f number_two
#number_one




















































