# 자료

- https://learning.oreilly.com/videos/bash-scripting-fundamentals/9780134541730/
- https://learning.oreilly.com/videos/advanced-bash-scripting/9780134586229/
- https://www.tutorialspoint.com/unix/

# Bash shell rules (기본 기능)

- **quoting rule**

  - metacharacters
    - ? () $ … * % {} []
      - echo ???? -> 현재 디렉토리에서 4글자 해당 파일/디렉토리 찾기
      - touch fileName{1...4} -> fileName1 fileName2 ... 만들기
  - 메타문자의 의미를 제거하고 단순 문자로 변경
    - Backslash 
      - my\*name 파일 만들어 주려면 -> touch my\*name
    - Single quote
    - Double quote
      - touch "This is a file" -> 띄어쓰기
  - [Difference between single and double quotes in Bash](https://stackoverflow.com/questions/6697753/difference-between-single-and-double-quotes-in-bash)

- **nesting commands** (명령어 안에 명령어 쓸때)

  - $(명령어)
    - echo “”today is $(date)”
  - backtick 이용 -> \`명령어\`
    - echo “”today is \`date\`”
  - touch report-date +%Y%m%d -> report-20220701 파일 만듬

- **Redirection**

  - 3가지  (0, 1 은 생략가능)
    - 0< (stdin)
    - 1> (stdout)
    - 2> (에러)
  - 입출력 리다이렉션  
    - ls file1 2> errorMsg.txt (없다면 텍스트파일로 출력)
    - ls file1 2> /dev/null (파일 만들지 말고 그냥 소각장으로 보내기)

- **Positional Parameter**

  - /usr/bin/cp file1 file2 
    - $0 = cp
    - $1 = file1
    - $2 = file2
  - %# - arg 개수
  - %* 또는 %@ - 모든 arg  

- **Input / Output**

  - eche -e "hello\nworld" (이스케이프 문자 해석)
  - read -t10 -n8 -s password (10초 동안 8글자 비밀번호를 입력받는다)
  - read 변수1 변수2 (두개의 변수값을 받는다)
  - echo -n "continue(y/n)?" ; read answer (사용자 대답 받기. 이후 스크립트에 if 문으로 처리.)
  - printf "name: %s, score: %d\n" yoochul 100
  - printf "|%-10s|%-10s|%10.2f\n" yoochu kim 100 (- 왼쪽정렬)

- **Branching**

  - exit

    - 0~255 (0이 성공 나머진 에러 코드)

  - test

    - -e 존재하냐
      - test -e /etc/passwd; $? 

    - -f 파일 이냐
    - -x 실행가능
    - -d 디렉토리냐
    - 이외, eq, gt, nt 등등
      - test 1101 -gt 281 ; $? (0이 true)
      - test 1101 -gt 23241 ; $?  (1이 false)
      - test 1101 -ne 281 ; $? 
      - 

  - if-then

  - case

    - ```
      echo "continue (yes/no)?"
      read answer
      case $answer in
       yes) echo "yes";;
       no) echo "no";;
       *) echo "choose one, yes or no";;
      esac
      ```

    - ```
      #!/bin/bash
      
      cat << END
      ============================
      Select number
      ----------------------------
      1: Disk 용량  
      2: 로그인된 유저 이름 
      3: IP 주소
      ----------------------------
      END
      echo -n "number: "
      read number
      case $number in
       1) df - h ;;
       2) who ;;
       3) ifconfig | grep -w "[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*";;
       *) echo "wrong input";;
      esac
      
      printf "chosen number: %d" $number
      ```

- **산술 연산**

  - expr
    - expr 10 + 5
    - x=10; expr $x + 5 

  - let 
    - x=20; y=10; let z=x+y; echo $z (let은 달러 사인 필요 x)

- **반복문**

  - while
  - until 
  - for


# 리눅스 명령어

## FIND

현재 디렉토리에 있는 txt 파일 찾기

```
find . -name 파일명.txt
find . -iname 파일명.txt // case insensitive
```

디렉토리 찾기

```
find / -type d -name 디렉토리명
```

모든 java 파일 찾기

```
find . -type f -name "*.java"
```

777 권한 파일 찾기

```
find . -type f -perm 0777 -print
find / -type f ! -perm 777 // 777가 아닌 경우 출력시
```

실행가능 파일 찾기

```
find / -perm /a=x
```

권한 777 -> 755 변경

```
find / -type d -perm 777 -print -exec chmod 755 {} \;
```

파일 찾아 삭제

```
find . -type f -name "파일명.txt" -exec rm -f {} \;
```

50 일 안에 수정된 파일 찾기

```
find / -mtime 50
find / -mtime +50 –mtime -100 // 50~100 일
```

50일 안에 access 된 파일

```
find / -atime 50
```

5분 안에 

```
find / -cmin -5 // 5분 안에 바뀐 파일
find / -mmin // 5분 안에 수정된 파일
find / -amin // 5분 안에 수정된 파일
```

