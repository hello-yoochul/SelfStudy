package Factory;

import Factory.Interface.HamburgerStore;
import Factory.Model.Hamburger;
import Factory.Store.UkHamburgerStore;
import Factory.Store.UsaHamburgerStore;

/**
 * 팩토리 패턴이란?
 * 객체를 생성하는 인터페이스는 미리 정의하되, 인스턴스를 만들 클래스의 결정은 서브 클래스 쪽에서 내리는 패턴입니다.
 */
public class Main {
    public static void main(String[] args) {
        HamburgerStore usaStore = new UsaHamburgerStore();
        HamburgerStore ukStore = new UkHamburgerStore();

        Hamburger usaCheeseBurger = usaStore.orderHamburger("CheeseBurger");
        Hamburger usaVeggieBurger = usaStore.orderHamburger("VeggieBurger");
        Hamburger usaMeatLoverBurger = usaStore.orderHamburger("MeatLoverBurger");

        Hamburger ukCheeseBurger = ukStore.orderHamburger("CheeseBurger");
        Hamburger ukVeggieBurger = ukStore.orderHamburger("VeggieBurger");
        Hamburger ukMeatLoverBurger = ukStore.orderHamburger("MeatLoverBurger");


        System.out.println("-------------------- 준비된 버거 --------------------");
        System.out.println(usaCheeseBurger.getName());
        System.out.println(usaVeggieBurger.getName());
        System.out.println(usaMeatLoverBurger.getName());
        System.out.println();

        System.out.println(ukCheeseBurger.getName());
        System.out.println(ukVeggieBurger.getName());
        System.out.println(ukMeatLoverBurger.getName());
    }
}
