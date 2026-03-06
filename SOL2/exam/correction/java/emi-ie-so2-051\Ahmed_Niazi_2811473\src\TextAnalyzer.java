public class TextAnalyzer {

    // Method that counts and returns the total number of words in the given text
    public void countWords(String text) {
        String[] words = text.split(" ");

        if (words.length == 0) {System.out.println("There is no words in this text"); return;}

        System.out.println("Number of word: " + words.length);
    }

    // Method that counts and returns the total number of characters, excluding spaces.
    public void countCharacters(String text) {
        String[] words = text.split(" ");

        if (words.length == 0) {System.out.println("There is no words in this text"); return;}

        int count = 0;
        for (int i = 0; i < words.length; i++) {
            count = count + words[i].length();
        }
        System.out.println("Number of character: " + count);
    }

    // Method that finds and returns the longest word in the text, if two words are equally
    // the longest, then return any one of them.
    public void findLongestWord(String text) {
        String[] words = text.split(" ");

        if (words.length == 0) {System.out.println("There is no words in this text"); return;}

        String longest = words[0];
        for (int i = 0; i < words.length; i++) {
            if (longest.length() < words[i].length()) {longest = words[i];}
        }
        System.out.println("Longest word is: " + longest);
    }

    // Method that counts how many times a specific word appears in the text.
    public void countWordOccurrences(String text, String word) {
        String[] words = text.split(" ");

        if (words.length == 0) {System.out.println("There is no words in this text"); return;}

        int count = 0;
        for (int i = 0; i < words.length; i++) {
            if (words[i] == word) {count++;}
        }

        System.out.println("Word  "+ word + " appeared: " + count + "times.");
    }
}
