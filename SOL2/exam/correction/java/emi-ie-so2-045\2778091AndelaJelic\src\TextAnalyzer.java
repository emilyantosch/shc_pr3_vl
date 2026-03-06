public class TextAnalyzer {
    private String text;

    public TextAnalyzer(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public int countWords() {
        String[] words = getText().split(" ");
        return words.length;
    }

    public int countCharacters() {
        String[] words = getText().split(" ");
        int counter = 0;
        for (String s : words) {
            counter = counter + s.length();
        }
        return counter;
    }

    public String findLongestWord() {
        String[] words = getText().split(" ");
        String term = "";
        //loop to check every word length
        for (String s : words) {
            if (term.length() < s.length()) {
                term = s;
            }
        }
        return term;
    }

    public int countWordOccurances(String word) {
        String[] t = getText().split(" ");
        word = word.toLowerCase();
        int numberOfOccurrances = 0;
        for (String s : t) {
            s = s.toLowerCase();
            if (s.equals(word)) {
                numberOfOccurrances = numberOfOccurrances + 1;
            }
        }
        return numberOfOccurrances;
    }
}
