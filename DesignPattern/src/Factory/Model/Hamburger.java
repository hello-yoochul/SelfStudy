package Factory.Model;

public abstract class Hamburger {
    public String name;
    public String sauce;
    public String buns;

    public void prepare() {
        System.out.println("Preparing " + name);
        System.out.println("Preparing " + sauce);
        System.out.println("Preparing " + buns);
    }

    public void cook() {
        System.out.printf("Cooking " + name);
        System.out.println("Adding " + sauce);
        System.out.println("Adding " + buns);
    }

    public void box() {
        System.out.printf("Boxing " + name);
        System.out.println("\n--------------------------------------------------------------");
    }

    public String getName() {
        return name;
    }
}
