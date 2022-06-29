package Command.tutorialspoint;

public class Stock {
    private String name;
    private int quantity;

    public Stock(String name, int quantity) {
        this.name = name;
        this.quantity = quantity;
    }

    public Stock() {

    }

    public void buy() {
        System.out.println("Name: " + this.name + ", Quantity: " + quantity + " bought");
    }

    public void sell() {
        System.out.println("Name: " + this.name + ", Quantity " + quantity + " sold");
    }
}
