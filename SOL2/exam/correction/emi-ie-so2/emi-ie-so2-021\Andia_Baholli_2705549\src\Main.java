public class Main {
    public static void main(String[] args) {
        String text = "Hello world from Java, hello hello";

        TextAnalyzer test = new TextAnalyzer();


        System.out.println(text);
        System.out.println("Number of words: " + test.countWords(text));
        System.out.println("Number of characters: " + test.countCharacters(text));
        System.out.println("Longest word: " + test.findLongestWord(text));
        System.out.println("Number of occurances for word: Hello -> " + test.countWordOccurences(text, "hello"));

    }
}
