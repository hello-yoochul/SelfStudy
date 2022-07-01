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
- **nesting commands**
  - $(명령어)
    - echo “”today is $(date)”
  - backpack 이용 -> \`명령어\`
    - echo “”today is \`date\`”
  - touch report-date +%Y%m%d -> report-20220701 파일 만듬
