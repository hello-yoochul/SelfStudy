package Decorator;

public class BasicIceCream implements IceCream {
    public BasicIceCream() {
    }

    @Override
    public int cost() {
        return 1000;
    }
}
