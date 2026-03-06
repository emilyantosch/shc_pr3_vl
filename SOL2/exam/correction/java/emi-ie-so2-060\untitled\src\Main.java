public class Main {
    private String text = "Hello world from Java" ;
    private String[] words = text.split(" ");

    public Main(String text, String[] words){
        this.text = text;
        this.words = words;
    }
    public String getText() {
        return text;
    }
    public String[] getWords() {
        return words;
    }
    public int countWords(String text){
        return text.length();
    }
    public String countCharacters(String text){
        return text;
    }
    public int findLongestWord(String text, String words){
    }

    public static void main(String[] args){


    }
}