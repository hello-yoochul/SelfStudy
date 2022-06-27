package Factory.Model.USA;

import Factory.Model.Hamburger;

public class UsaCheeseBurger extends Hamburger {
    public UsaCheeseBurger() {
        name = "USA Style Cheese Burger";
        sauce = "USA style sauce";
        buns = "USA style buns";
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
