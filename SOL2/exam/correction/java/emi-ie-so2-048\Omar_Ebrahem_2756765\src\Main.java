import static java.awt.SystemColor.text;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        system.out.println ("add text=> "+text.addtext("Hello World"));
        system.out.println ("add invalid=> "+text.addtext(""));
        system.out.println ("all Contacts=> "+text.displayAllText ());
        system.out.println("find longest word=>" +text.findLongestWord());
        system.out.println("count word occurences=>" +text.countWordOccurrences());
    }
}