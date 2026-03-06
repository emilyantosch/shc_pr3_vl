// Name: Gabriel Tanase
// Matriculation number: 2793542

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in); // scanner for user input

        TextAnalyzer analyzer = new TextAnalyzer(); // creating the object
        String happyText = "I hope I will pass this exam. Magnificently " +
                "I need to check if it counts pass pass pass";
        String sadText = "";
        String word = "pass";

        // Testing when everything works as planned
        System.out.println("= = = For valid input = = =");
        printResults(analyzer, happyText, word);

        // Testing when everything goes wrong
        System.out.println("\n= = = For invalid input = = =");
        printResults(analyzer, sadText, word);

        // Testing with user input
        System.out.println("\n= = = User text statistics generator = = =");
        System.out.println("Input your text: ");
        String userText = scan.nextLine();
        System.out.println("Input the word to find: ");
        String userWord = scan.nextLine();
        printResults(analyzer, userText, userWord);

        scan.close();
    }

    // helper method that takes a TextAnalyzer object, a text, and a word and performs testing
    public static void printResults(TextAnalyzer analyzer, String text, String word) {
        System.out.println("Counted words: " + analyzer.countWords(text));
        System.out.println("Counted characters: " + analyzer.countCharacters(text));
        System.out.println("The longest text in your text is: " + analyzer.findLongestWord(text));
        System.out.println("Occurrences of the word: " + word + " : " + analyzer.countWordOccurrences(text, word));
    }
}