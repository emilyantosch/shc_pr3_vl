public class TextAnalyzer {
    private String text;
    private static int countWords;

    public TextAnalyzer(String text) {
        this.text = text;
        countWords++;
    }

    public String getText() {
        return text;
    }

    public static int getCountWords() {
        return countWords;
    }

    public void setText(String text) {
        if (text != null && !text.isEmpty()) {
            this.text = text;
        }
    }

    public int countWords(String text) {
        if (text == null || text.isEmpty) {
            System.out.println("Error nothing is in text");

        } else {
            String[] words = text.split(" ");
        }

        return 0;
    }

    public int countCharacters(String text) {

        if (text == null) {
            return 0;

        } else {
            String[] words = text.split(" ");
        }
        return 0;
    }

    public String findLongestWord(String text, String word) {
        if (text == null) {
            return 0;

        } else {
            String[] words = text.split(" ");
        }
        return null;
    }

    public void countWordOccurrences(String text, String word) {
        if (text == null) {
            return 0;

        } else {
            String[] words = text.split(" ");
        }
    }
}