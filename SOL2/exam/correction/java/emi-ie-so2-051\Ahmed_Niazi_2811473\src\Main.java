public class Main {
    public static void main(String[] args) {
        TextAnalyzer ta = new TextAnalyzer();
        String text = " ";
        String text1 = "Hello world from Java";
        String word = "Java";

        // Method 1: countWords() with no text
        ta.countWords(text);

        // Method 1: countWords()
        ta.countWords(text1);

        // Method 2: countCharacters() with no text
        ta.countCharacters(text);

        // Method 2: countCharacters()
        ta.countCharacters(text1);

        // Method 3: findLongestWord() with no text
        ta.findLongestWord(text);

        // Method 3: findLongestWord()
        ta.findLongestWord(text1);

        // Method 4: countWordOccurrences() with no text
        ta.countWordOccurrences(text, word);

        // Method 4: countWordOccurrences()
        ta.countWordOccurrences(text1, word);
    }
}