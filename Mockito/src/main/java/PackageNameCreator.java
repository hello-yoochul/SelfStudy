public class PackageNameCreator {
    public static void main(String[] args) {
        PackageNameCreator replacer = new PackageNameCreator();
        replacer.makePackageName("Getting Started with Mockito");
    }

    private void makePackageName(String s) {
        System.out.println(s.replace(" ", "_"));
    }
}
