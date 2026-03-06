public class TextAnalyzer {

    public static void main(String[] args) {
        TextAnalyzer t = new TextAnalyzer();
        String text = "Hello hello HEllo world from Java";
        System.out.println("Number of words: " + t.countWords(text));
        System.out.println("Number of characters: " + t.countCharacters(text));
        System.out.println("Longest word in the text: " + t.findLongestWord(text));
        System.out.println("How many times 'hello' appears in the text: " + t.countWordOccurrences(text, "hello"));
    }

    public int countWords (String text) {
        String[] words = text.split(" ");
        if (words.length == 0) {
            System.out.println("Text is empty!");
            return text.length();
        }
        return words.length;
    }

    public int countCharacters(String text) {
        int count = 0;
        String[] words = text.split(" ");
        for (int i = 0; i < words.length; i++) {
            char[] chars = words[i].toCharArray();
            for (int j = 0; j < chars.length; j++) {
                char c = chars[j];
                count++;
            }
        }
        return count;
    }

    public String findLongestWord(String text) {
        String[] words = text.split(" ");
        for (int i = 0; i < words.length; i++) {
            if (words.length == 1) {
                return words[i]; // single word case
            }
            for (int j = i + 1; j < words.length; j++) {
                if (words[i].length() == words[j].length()) {
                    return words[i];
                }
                if (words[i].length() < words[j].length()) {
                    return words[j];
                } else {
                    return words[i];
                }
            }
        }
        return null; // return null if text is empty
    }

    public int countWordOccurrences(String text, String word) {
        int count = 0;
        String[] words = text.toLowerCase().split(" ");
        String lowerWord = word.toLowerCase();
        for (int i = 0; i < words.length; i++) {
            if (words[i] == lowerWord) {
                count++;
            }
        }
        return count;
    }

}
