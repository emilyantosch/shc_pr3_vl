public class TextAnalyzer {
    private String inputText;

    public TextAnalyzer(String inputText) {
        this.inputText = inputText;
    }

    public String getInputText() {
        return inputText;
    }

    public void setInputText() {
        if (inputText != null && !inputText.isEmpty()) {
            this.inputText = inputText;
        }
    }

    public void countWords(String inputText) {
        if (inputText == null || inputText.isEmpty()) {
            System.out.println("Input text is empty");
            return;
        } else {
            String[] words = inputText.split(" ");
            System.out.println("\nNumber of words: " + words.length);
        }
    }

    public void countCharacters(String inputText) {
        if (inputText == null || inputText.isEmpty()) {
            System.out.println("Input text is empty");
            return;
        } else {
            int count = 0;
            for (int i = 0; i < (inputText.length() - 1); i++) {
                if (inputText != " ") {
                    count++;
                }
            }
            System.out.println("\nNumber of characters: " + count);
        }
    }

    public void findLongestWord(String inputText) {
        if (inputText == null || inputText.isEmpty()) {
            System.out.println("Input text is empty");
            return;
        } else {
            String[] words = inputText.split(" ");
            String longestWord = " ";
            System.out.println("\nLongest word: " + longestWord);
        }
    }

    public void countWordOccurrences(String inputText, String word) {
        if (inputText == null || inputText.isEmpty()) {
            System.out.println("Input text is empty");
            return;
        } else {
            // Convert to lower case for case-sensitivity
            String lowerCase = inputText.toLowerCase();
            String[] words = lowerCase.split(" ");
            int count = 0;
            for (String w:words) {
                if (w.equals(word)) {
                    count++;
                }
            }
            System.out.println("\nNumber of word occurrences: " + count);
        }
    }

    public static void main(String[] args) {
        System.out.println("Demo example:\n");
        TextAnalyzer text = new TextAnalyzer("this is an example");
        text.countWords("this is an example");
        text.countCharacters("this is an example");
        text.findLongestWord("this is an example");
        text.countWordOccurrences("this is an example", "example");
    }
}
