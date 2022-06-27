package Factory.Model.UK;

import Factory.Model.Hamburger;

public class UkVeggieBurger extends Hamburger {
    public UkVeggieBurger() {
        name = "UK Style Veggie Burger";
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
