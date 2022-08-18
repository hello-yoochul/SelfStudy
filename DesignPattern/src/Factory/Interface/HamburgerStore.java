package Factory.Interface;

import Factory.Model.Hamburger;

public abstract class HamburgerStore {

    public Hamburger orderHamburger(String type) {
        Hamburger burger = createHamburger(type);
        return burger;
    }

    abstract public Hamburger createHamburger(String type);
}
