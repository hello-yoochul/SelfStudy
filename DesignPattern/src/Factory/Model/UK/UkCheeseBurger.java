package Factory.Model.UK;

import Factory.Model.Hamburger;

public class UkCheeseBurger extends Hamburger {
    public UkCheeseBurger() {
        name = "UK Style Cheese Burger";
        sauce = "UK style sauce";
        buns = "UK style buns";
    }

    @Override
    public void prepare() {
        super.prepare();
    }

    @Override
    public void cook() {
        super.cook();
    }

    @Override
    public void box() {
        super.box();
    }
}
