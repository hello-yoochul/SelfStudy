# 팩토리 패턴

객체를 생성하는 인터페이스는 미리 정의하되, 인스턴스를 만들 클래스의 결정은 서브 클래스 쪽에서 내리는 패턴입니다.

# 코드 설명

- 나라별 버거 가게가 있다.
- 공통되는 부분은 Interface 폴더에 넣었다.
- UkHamburgerStore, UsaHamburgerStore 에서 각 나라별 버거 인스턴스 생성을 담당한다.
