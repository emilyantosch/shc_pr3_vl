public class TextAnalyzer {
    public static int countWords(String text) {
        if (text == null) // return on null string
            return 0;

        if (text.isEmpty()) // the method is not supposed to return 1 when the string is empty
            return 0;

        String[] words = text.split(" "); // Split on spaces
        int count = 0;
        for (int i = 0; i < words.length; i++) {
            count++;
        }
        return count;
    }

    public static int countCharacters(String text) {
        if (text == null) // return on null string
            return 0;

        String charsNoSpace = text.replaceAll(" ", ""); // replace all spaces with nothing
        int count = 0;
        for (int i = 0; i < charsNoSpace.length(); i++) {
            count++;
        }
        return count;

    }

    public static String findLongestWord(String text) {
        if (text == null) // return on null string
            return null;

        String noPunctuation = text.replaceAll("[.,;:!?]", " "); // replace all punctuation with spaces
        String[] words = noPunctuation.split(" "); // Split on spaces
        int longest = 0; // keep track of the length of the longest word
        String longestWord = "";
        for (String word : words) {
            int wordLength = word.length();
            if (wordLength > longest) {
                longest = wordLength;
                longestWord = word;
            }
        }
        return longestWord;

    }

    public static int countWordOccurrences(String text, String word) {
        if (text == null || word == null) // return on null string
            return 0;

        String[] words = text.split(" ");
        String searchTerm = word.toLowerCase(); // search term to lower
        int counter = 0; // keep track of occurrences
        for (String iterWord: words) {
            String lookup = iterWord.toLowerCase(); // inspected word to lower
            if (lookup.matches(searchTerm)) {
                counter++;
            }
        }
        return counter;
    }

    public static void main(String[] args) {
        // Create sample test cases
        String sampleText = "The quick brown fox? jumps over the lazy dog; longest-word, duplicate duplicate.";
        String sampleText2 = "Lorem ipsum dolor sit amet.";
        String sampleTextSingleWord = "Hi";
        String sampleTextNull = null;
        String sampleTextEmpty = "";
        String[] tests = {sampleText, sampleTextSingleWord, sampleTextNull, sampleTextEmpty, sampleText2};

        System.out.println("Testing");
        for (String test: tests) { // Test empty, null, single word and normal strings
            int wordCount = countWords(test);
            int charCount = countCharacters(test);
            String longestWord = findLongestWord(test);
            int wordOccurrences = countWordOccurrences(test, "Duplicate"); // look for specific word in wrong case
            System.out.printf("""
                    Test results:
                    Original string: %s
                    Word count: %d
                    Character count: %d
                    Longest word: %s
                    Word occurrences: %d
                    
                    """
            , test, wordCount, charCount, longestWord, wordOccurrences);
        }
    }

}
