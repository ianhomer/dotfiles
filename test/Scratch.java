public class Scratch {
  public String foo(String bar) {
    return bar;
  }

  public String hello(String bar) {
    return "Hello, " + bar + "!";
  }

  public static void main(String[] args) {
    System.out.println(new Scratch().hello("world"));
  }
}
