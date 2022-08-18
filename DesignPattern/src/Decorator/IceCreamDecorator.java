package Decorator;

public class IceCreamDecorator implements IceCream {
    IceCream iceCream;

    public IceCreamDecorator(IceCream iceCream) {
        this.iceCream = iceCream;
    }

    @Override
    public int cost() {
        return this.iceCream.cost();
    }
}
