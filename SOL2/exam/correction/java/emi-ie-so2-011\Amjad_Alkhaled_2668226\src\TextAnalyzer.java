import org.w3c.dom.Text;

import java.util.ArrayList;

public class TextAnalyzer {

    String text = "Hello world from jave";
    String[] words = text.split(" ");

    public TextAnalyzer() {
        this.text = text;
    }

    //private String text;

    public int countWords(String text) {
        int count = 0;
        //for each loop find count
        for (String word : words) {
            if (word.equals(text)) {
                count++;
            }
        }
        return count;
    }

    public int countCharacters(String text){
        int count = 0;
        //for each loop find count
        for (String word : words) {
            if (word.equals(text)) {
                count++;
            }
        }
        return count;
    }



}
//  private ArrayList<Text> text;

//    public TextAnalyzer(){
//        text = new ArrayList<>();
//    }