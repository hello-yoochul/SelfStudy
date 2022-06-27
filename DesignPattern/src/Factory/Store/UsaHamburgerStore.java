package Factory.Store;

import Factory.Interface.HamburgerStore;
import Factory.Model.Hamburger;
import Factory.Model.USA.UsaCheeseBurger;
import Factory.Model.USA.UsaMeatLoverBurger;
import Factory.Model.USA.UsaVeggieBurger;

public class UsaHamburgerStore extends HamburgerStore {
    @Override
    public Hamburger createHamburger(String type) {
        switch (type) {
            case "VeggieBurger":
                return new UsaVeggieBurger();
            case "CheeseBurger":
                return new UsaCheeseBurger();
            case "MeatLoverBurger":
                return new UsaMeatLoverBurger();
        }

        return null;
    }
}
