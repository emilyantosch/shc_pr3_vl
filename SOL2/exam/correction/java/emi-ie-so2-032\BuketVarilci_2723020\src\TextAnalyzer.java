import java.util.ArrayList;

public class TextAnalyzer {

    private ArrayList<Text> texts; //In the exam It only mentions one class but to make it less complicated I wanted to divide into 3 classes.

    public TextAnalyzer(){
        this.texts = new ArrayList<>();
    }
    public String countwords(String text){
        for (Text mytext: texts){
            String [] words = mytext.getText().split(" ");
             System.out.println("Number of words: "+words.length);
             return mytext;
        }
        return null;
    }

    public Text countCharacters(String text){
        for (Text mytext: texts){
            String [] words = mytext.getText().replace().split(" ");
            System.out.println("Number of words: "+words.length);
            return mytext;
        }
        return null;
    }

    public String findLongestWord(String text){
        for (Text mytext: texts){
            if (countwords()<countwords()){
                //since I didnt hold the array memory I cannot use it but I want to point it out that I wanted to compare each word and get the biggest
                return countwords();
            }
        }
        return null;
    }
    public String countWordOccurrences(String text, String word){
        for (Text mytext: texts){
            if(mytext.getText().equalsIgnoreCase(text)){
                return mytext;
            }
        }
        return null;
    }

}
