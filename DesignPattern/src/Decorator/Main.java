package Decorator;

/**
 * 데코레이터 패턴이란? (Structural Pattern)
 * 기본 기능에 추가할 수 있는 기능의 종류가 많은 경우에 각 추가 기능을 Decorator 클래스로 정의 한 후
 * 필요한 Decorator 객체를 조합함으로써 추가 기능의 조합을 설계 하는 방식이다.
 */
public class Main {
    public static void main(String[] args) {
        // Basic 가격: 1000
        // Choco 추가금: 500
        // Mint 추가금: 1000

        IceCream basic = new BasicIceCream(); // 1000
        IceCream choco = new ChocoIceCream(basic); // 1500
        IceCream mintChoco = new MintIceCream(choco); // 2500
        IceCream doubleChocoMint = new ChocoIceCream(mintChoco); // 3000 = basic.cost + choco.cost + mint.cost + choco.cost

        System.out.println("basic price: " + basic.cost());
        System.out.println("choco price: " + choco.cost());
        System.out.println("mint choco price: " + mintChoco.cost());
        System.out.println("double choco mint price: " + doubleChocoMint.cost());
    }
}
