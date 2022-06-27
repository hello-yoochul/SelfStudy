package Factory.Interface;

import Factory.Model.Hamburger;
import Factory.Model.WORLDWIDE.CheeseBurger;
import Factory.Model.WORLDWIDE.MeatLoverBurger;
import Factory.Model.WORLDWIDE.VeggieBurger;

public class SimpleHamburgerFactory {

    public Hamburger createHamburger(String type) {
        Hamburger hamburger = null;
        
        switch (type) {
            case "VeggieBurger":
                hamburger = new VeggieBurger();
            case "CheeseBurger":
                hamburger = new CheeseBurger();
            case "MeatLoverBurger":
                hamburger = new MeatLoverBurger();
        }

        return hamburger;
    }
}
