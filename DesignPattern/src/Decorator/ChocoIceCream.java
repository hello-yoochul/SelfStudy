package Decorator;

public class ChocoIceCream extends IceCreamDecorator {

    public ChocoIceCream(IceCream iceCream) {
        super(iceCream);
    }

    @Override
    public int cost() {
        return 500 + super.cost();
    }
}
