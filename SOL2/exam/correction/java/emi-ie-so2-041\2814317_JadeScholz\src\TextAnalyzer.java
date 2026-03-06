public class TextAnalyzer {
    private int words;
    private int characters; //excluding spaces
    private String longestWord;
    private int countSpecific;

    public TextAnalyzer (int words, int characters, String longestWord, int countSpecific){
        this.words = words;
        this.characters = characters;
        this.longestWord = longestWord;
        this.countSpecific = countSpecific;
    } // constructor

    public int getWords(){
        return words;
    }
    public int getCharacters(){
        return characters;
    }

    public String getLongestWord() {
        return longestWord;
    }

    public int getCountSpecific() {
        return countSpecific;
    }

    public int countWords(String text) {
        String[] allWords;
        allWords = text.split(" ");

        for (int i = 0; i < allWords; i++ ){
            words++;
        }

        return words;
    }

    public int countCharacters(String text) {
        //logic, for loop through text { if char !=  "  " then characters++ } returns characters
        return characters;
    }

    public String FindLongestWord(String text) {
        // use split method for words, check through :for loop / update longest word till end - return longest word as string
        return longestWord;
    }

    public int countWordOccurences(String text, String word) {

    }
}