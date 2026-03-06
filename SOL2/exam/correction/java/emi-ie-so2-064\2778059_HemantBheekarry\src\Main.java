//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        String text = "Well hello HEllO hello brother,";
        TextAnalyzer analyzer = new TextAnalyzer("");

        System.out.println("Number of words: " + analyzer.countWords(text));
        System.out.println("Number of characters: " + analyzer.countCharacters(text));
        System.out.println("Longest word: " + analyzer.findLongestWord(text));
        System.out.println("number of occurrences of a particular word: " + analyzer.countWordOccurrences(text,"hello"));
    }
}