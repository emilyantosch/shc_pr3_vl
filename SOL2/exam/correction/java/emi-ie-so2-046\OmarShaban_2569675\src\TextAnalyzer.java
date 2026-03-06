public class TextAnalyzer {
    private int numOfWords;
    private int numOfChars;
    private String longestWord;
    private String word,
    private String text;

    public TextAnalyzer(int numOfWords, int numOfChars, String longestWords, String word, String text) {
        this.numOfWords = numOfWords;
        this.numOfChars = numOfChars;
        this.longestWord = longestWords;
        this.word = word;
        this.text = text;
    }

    public int getNumOfWords() {
        return numOfWords;
    }

    public int getNumOfChars() {
        return numOfChars;
    }

    public String getLongestWords() {
        return longestWord;
    }

    public void countWords(String text){
        for (TextAnalyzer textAnalyzer : text) {
            if (textAnalyzer.getNumOfWords())
                return numOfWords;
        }
        system.out.println("no words found");
        return null;

    }

    }

    public void countCharacters(String text){
        for (TextAnalyzer textAnalyzer : text) {
            if (textAnalyzer.getNumOfChars())
                return numOfChars;
        }
        system.out.println("no letter found");
        return null;
    }

    public void findLongestWord(String text){

        for (TextAnalyzer textAnalyzer : text) {
            if (textAnalyzer.getLongestWords())
                return longestWord;
        }
        system.out.println("no words found");
        return null;
    }

    public void countWord0ccurrences(String text, String word){
        for (TextAnalyzer textAnalyzer : text, word) {
            if (textAnalyzer.getLongestWords() || getnumOfChars)
                return longestWord;
        }
        system.out.println("no words found");
        return null;

    }

    public String getWord() {
        return word;
    }

    public String getText() {
        return text;
    }
}
