import java.util.Arrays;

public static class TextAnalyzer {
    private String text;
    private String [] words;

    public TextAnalyzer(String text, String[] words){
        this.text = text;
        this. words = words;
    }


    String countWords(String[] words){
        String text = "Hello world from Java";
        return Arrays.toString(words = text.split(""));

    }
    String countCharacters(String text){
        String text = "Hello world from Java";
        return Arrays.toString(words = text.split(""));

    }
    String findlognestword(String text){
        String text = "Hello world from Java";
        return Arrays.toString(words = text.split(""));

    }

}
public static void main(String [] args){

    System.out.println("Number of words: " + countWords(words).length);

}

