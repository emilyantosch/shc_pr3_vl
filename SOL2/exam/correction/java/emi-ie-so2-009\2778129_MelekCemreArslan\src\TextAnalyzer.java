public class TextAnalyzer {
    //the initialization
    public String text = "Hello world from Java";
    public String[] words = text.split(" ");
    System.out.println("Number of words: " + words.length);

    //This method counts and returns the total numver of words in the given text
    public int countWords(String text) {
        int wordNumber = 0;

        for(i = 0; i < text.length(); i++) {
            wordNumber++;
        }
        return wordNumber;
    }
    System.out.println("Number of words: " + words.length());

    //This method counts and returns the total number of characters
    public int countCharacters(String text) {
        int charNumber = 0;
        if( text != null || !text.isEmpty()) {
            for(i = 0; i < text.length(); i++) {
                charNumber++;
            }
            return charNumber;
        }
    }

    System.out.println("Number of characters: " + charNumber);

    //This method finds and returns the longest word in the text.
    public String findLongestWord(String text) {

    }

    //This method counts how many times a specific word appears in the text.
    public int countWordOccurences(String text, String word) {
        int wordOccurences = 0;


    }


    System.out.println("Number of occurences: " + );
}
