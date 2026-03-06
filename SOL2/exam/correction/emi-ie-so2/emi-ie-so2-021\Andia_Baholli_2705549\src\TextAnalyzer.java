public class TextAnalyzer {

    public int countWords(String text) {
        String[] words = text.split(" ");
        if (words.length == 0)
            System.out.println("Error! Enter a longer String.");
        return words.length;
    }

    public int countCharacters(String text) {
        int size = text.length();
        char a = ' ';
        int count = 0;


        for (int i = 0; i < size; i++) {
            if (text.charAt(i) != a) {
                count++;
            }
        }

         return count;
    }

    public String findLongestWord(String text) {
        String temp = "";
        int longest = 0;
        String[] words = text.split(" "); //Check
        int totalWords = words.length;
        int i = 0;
        int j = 0;

        while (i < totalWords) {
            while (j < words[i].length()) {
                j++;
            }
            if (longest < j) {
                longest = j;
                temp = words[i];
            }
            i++;
        }
        return temp;
    }

    public int countWordOccurences(String text, String word) {
        int count = 0;
        String[] words = text.split(" "); //Check

        for (int i = 0; i < words.length; i++) {
            if (words[i].equalsIgnoreCase(word)) {
                count++;
            }
        }
        return count;
    }
}
