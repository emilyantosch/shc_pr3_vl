public class TextAnalyzer {

    private String text;

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int countWords(String text) {
        String[] words = null;
        for(int i = 0; i < text.length(); i++) {
            String[i] words = text.split(" ");
            return words.length;
        }
    }

    public int countCharacters(String text) {
        int countChar = 0;
        for(int i = 0; i < text.length(); i++) countChar++;
        return countChar;
    }


}
