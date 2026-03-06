//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
    System.out.println("------ Word/Text Analyzer ------\n");
    TextAnalyzer myText = new TextAnalyzer();

    //count words test
    System.out.println("Counting words...");
    myText.countWords("Hello world from jave");

    //count characters
    System.out.println("Counting text...");
    //myText.countCharacters("Hello world from jave");




    }
}