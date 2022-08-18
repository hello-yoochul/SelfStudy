package Command.tutorialspoint;

/**
 * 커맨드 패턴이란? (Behavioral Pattern)
 * 데이터 주도 디자인이며, 요청이 객체(여기선 Order)로 포장되며 발생시키는 객체 (여기선 Broker)로 넘긴다.
 * 그리고 받은 커맨드를 발생시킨다.
 */
public class Main {
    public static void main(String[] args) {
        Stock appleStock = new Stock("apple", 10);

        Order buyStock = new BuyStock(appleStock);
        Order sellStock = new SellStock(appleStock);

        Broker broker = new Broker();
        broker.takeOrder(buyStock);
        broker.takeOrder(sellStock);

        broker.placeOrder();
    }
}
