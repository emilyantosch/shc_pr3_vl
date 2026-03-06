import java.sql.SQLOutput;

public class TextAnalyzer {
    private String text;
    private String word;
    private String character;

    public TextAnalyzer(String text,String word, String character) {
        this.text = text;
        this.character = character;
        this.word = word;
    }


    public String countWords(String text) {
        return word;
    }
    public String countCharacters(String text) {
        return character;
    }
    /*   public TextAnalyzer findLongestWord(String text) {
        return word;
    }
    public int countWordOccurrences(String text, String word) {
        return word;*/


    //Main
    public static void main (String[] args)  {
        String text= "Hello word from Java";
        String[] words = text.split(" ");
        System.out.println("Number of words: " + words.length);
    }
}
