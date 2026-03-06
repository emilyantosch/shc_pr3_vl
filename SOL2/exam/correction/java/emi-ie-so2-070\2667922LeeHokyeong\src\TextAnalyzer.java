/* 2667922 HOKYEONG LEE
 * SO2 Practical Part Task F
 *
 * * Sorry, my answer is not complete as I ran out of time... :_(
 */

public class TextAnalyzer {
    // Attributes
    private String text;
    private String words;

    // Constructor
    // incl. handling of edge cases
    public TextAnalyzer(String text, String words) {
        this.text = (text == null)? "UNKNOWN" : text.trim();
        this.words = (words == null)? "UNKNOWN" : words.trim();

        if (this.text.isEmpty()) {
            this.text = "UNKNOWN";
        }
        if (this.words.isEmpty()) {
            this.words = "UNKNOWN";
        }
    }

    // Methods
    // 1. Count and return the total number of words
    public int countWords(String text) {
        return text.split(" ").length;
    }

    // 2. Count and return the total number of characters
    public String countCharacters(String text) {
        int counter = 0;
        char[] characters = text.getChars();

        // a loop to count the characters
        for (int i = 0 ; i < characters.length; i++) {
            counter++;
        }

        return counter;
    }

    // 3. Find and return the longest word
    public String findLongestWord(String text) {
        String[] words = text.trim();

        // include loop to find the longest word here

        // return the word found to be the longest

        return longestWord;
    }

    // 4. Count how many times a specific word appears
    public int countWordOccurrences(String text, String word) {
        int counter = 0;

        // include functions to count the word happenings

        return counter;
    }

    // Main Method
    public static void main(String[] args) {
        TextAnalyzer analyzer = new TextAnalyzer("Hello world from Java");

        // Test 1 for counting words
        System.out.println(analyzer.countWords());

        // Test 2 for counting characters
        System.out.println(analyzer.countCharacters());

        // Test 3 for counting occurrences of words
        System.out.println(analyzer.countWordOccurrences());

    }

}
