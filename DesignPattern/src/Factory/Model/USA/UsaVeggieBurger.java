package Factory.Model.USA;

import Factory.Model.Hamburger;

public class UsaVeggieBurger extends Hamburger {
    public UsaVeggieBurger() {
        name = "USA Style Veggie Burger";
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
