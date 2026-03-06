//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        TextAnalyzer text = new TextAnalyzer("Hello world from Java");
        System.out.println("Total number of words = " + text.countWords());
        System.out.println("Total number of characters = " + text.countCharacters());
        System.out.println("The longest word is  = " + text.findLongestWord());
        String word = "hello";
        System.out.println("Specific word: "+ word + ", number of occurrences: " + text.countWordOccurances(word));
    }
}