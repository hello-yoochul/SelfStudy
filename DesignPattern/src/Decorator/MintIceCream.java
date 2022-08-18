package Decorator;

public class MintIceCream extends IceCreamDecorator {

    public MintIceCream(IceCream iceCream) {
        super(iceCream);
    }

    @Override
    public int cost() {
        return 1000 + super.cost();
    }
}
