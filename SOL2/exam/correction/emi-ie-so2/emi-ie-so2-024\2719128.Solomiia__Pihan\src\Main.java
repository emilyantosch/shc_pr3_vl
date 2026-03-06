//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        TextAnalyzer text1 = new TextAnalyzer(" Hello world from Java");

        text1.CountWords(" Hello world from Java");
        text1.countCharacters(" Hello world from Java");
        text1.findTheLongestWord(" Hello world from Java", " Hello");
        text1.countWordOccurences(" Hello world from Java", " Hello");
    }
}