public class TextAnalyzer {

    public int countWords(String text) {
        if (text != null && !text.isEmpty()) { // input validation
            String[] words = text.split(" "); // split text at empty spaces

            return words.length; // words count is array length of strings
        }

        System.out.println("Text is empty!");
        return -1;
    }

    public int countCharacters(String text) {
        if (text != null && !text.isEmpty()) { // input validation

            return text.replace(" ", "").length(); // replace empty spaces with no spaces
        }

        System.out.println("Text is empty!");
        return -1;
    }

    public String findLongestWord(String text) {
        if (text != null && !text.isEmpty()) { // input validation
            String[] words = text.split(" ");
            String longest = words[0]; // initialize helper variable to store longest

            for (String word : words) {
                if (word.length() >= longest.length()) { // check if current word is longer than current longest
                    longest = word;
                }
            }

            return longest;
        }

        System.out.println("Text is empty!");
        return null;
    }

    public int countWordOccurrences(String text, String word) {
        if (text != null && !text.isEmpty() && word != null && !word.isEmpty()) { // input validation
            String[] words = text.split(" "); // split text at empty spaces
            int count = 0; // counter

            for (String wordToCompare : words) {
                if (wordToCompare.equalsIgnoreCase(word)) { // check if word in array equals given word, ignoring case
                    count++;
                }
            }

            return count;
        }

        System.out.println("Text or/and word are empty!");
        return -1;
    }
}
