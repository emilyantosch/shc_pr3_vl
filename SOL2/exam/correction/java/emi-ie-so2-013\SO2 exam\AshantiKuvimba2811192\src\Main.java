public class Main {
    public static void main(String[] args) {
        TextAnalyzer text = new TextAnalyzer();

        //counting words
        int countingWords = text.countWord("Hello hello , my name is Ashanti");
        System.out.println("Number  of words: " + countingWords + " words");

        //counting characters
        int countingCharacter = text.countCharacters("Hello hello , my name is Ashanti");
        System.out.println("Number of characters: " + countingCharacter + " characters");

        //finding longest word
        String longestWord = text.findLongestWord("Hello hello , my name is Ashanti");
        System.out.println("the longest word is: " + longestWord);

        //word occurrences
        int occurrences = text.countWordOccurrences("Hello hello , my name is Ashanti", "hello");
        System.out.println("the word occurred: " + occurrences + " number of times");
    }
}