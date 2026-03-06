import java.util.*;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        TextAnalyzer analyzer = new TextAnalyzer();
        System.out.println(analyzer.countWords("Hello World from Java"));
        System.out.println(analyzer.countCharacters("Hello World from Java"));
        System.out.println(analyzer.findLongestWord("word longestWord word longerWord"));
        System.out.println(analyzer.countWordOccurrences("Hello hello World from hello Java", "hello"));
    }
}