
public static class TextAnalyzer {
    private String text;
    private String word;

    public TextAnalyzer(String text, String word) {
        this.text = text;
        this.word = word;
    }
    // I blanked out D: and ran out of time

    public void setText(String text) {
        this.text = text;
    }

    public String getWord() {
        return word;
    }

    public String getText() {
        return text;
    }

    public int countWords(String text) {
        if (text == null) {
            return 0;
        } else {
            String[] words = text.split("//s");
            return words.length;
        }
    }

    public int countCharacters(String text) {
        if (text == null) {
            return 0;
        } else {
            String[] characters = text.split("//s");
            return characters.length;

        }
    }

    public findLongestWord(String text, String word) {
        if (word == null) {
            return 0;
        } else {
            for (int i = 0; i < word.length; i++) {
                return word.length;
            }
        }
    }
    public countWordOccurrences(String text, String word) {
    }
}

    public static void main(String[] args) {
        TextAnalyzer textAnalyzer = new TextAnalyzer(text,word);

        //Word counting
        textAnalyzer.countWords("hello how are you");
        System.out.println(textAnalyzer.countWords("hello how are you"));

        //Character counting
        textAnalyzer.countCharacters("counting");
        System.out.println(textAnalyzer.countCharacters("counting"));

        //Finding LongestWord
        textAnalyzer.word.length;
        System.out.println(textAnalyzer.word.length);

        //count Word occurrences
        textAnalyzer.word.equalsIgnoreCase(text));

        }
}