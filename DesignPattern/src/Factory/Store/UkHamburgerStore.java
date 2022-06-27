package Factory.Store;

import Factory.Interface.HamburgerStore;
import Factory.Model.Hamburger;
import Factory.Model.UK.UkCheeseBurger;
import Factory.Model.UK.UkMeatLoverBurger;
import Factory.Model.UK.UkVeggieBurger;

public class UkHamburgerStore extends HamburgerStore {
    @Override
    public Hamburger createHamburger(String type) {
        switch (type) {
            case "VeggieBurger":
                return new UkVeggieBurger();
            case "CheeseBurger":
                return new UkCheeseBurger();
            case "MeatLoverBurger":
                return new UkMeatLoverBurger();
        }

        return null;
    }
}
