import java.util.Objects;

public class TextAnalyzer {
    private static String text;

    public TextAnalyzer(String text){
        this.text= text;
    }

    public int countWords(String text){
        String[] words = text.split(text);
       // System.out.println("Number of words: " + words.length);
        return words.length;
    }
    public int countCharacters(String text){
        int ch= text.length();
        //System.out.println("Number of Characters: " + ch);
        return ch;
    }


   /* public String findLongestWord(String text){
        String[] words = text.split(text);
        for (int i=0; i<words.length; i++){
            if (words[i] < words[i - 1]) {
                words[i-1]=words[i];}
                else{
                    return words[i];
            }

        }
    return ("failed");
    }

    */

    public String CountwordOccurrence (String text, String word){
        String lowerCase = text.toLowerCase();
        String[] words = text.split(lowerCase); //text.split(String.toLowerCase(text)); String.toLowerCase doesn't seem to be included in the library.
        int counter = 0;
        for (int i=1; i<words.length; i++){
            if (words [i]==words[i-1]){
                word= words[i];
                counter++;
            }

        }
        return("This is the most counted word: " + word + " It was counted " + counter + " times");
    }


    public static void main(String[] args){
        TextAnalyzer TA = new TextAnalyzer(text);
        TA.text="This is the testing text, but is it though? Is this true";
        System.out.println("Counting Words");
        System.out.println(TA.countWords(text));

        System.out.println("Counting Characters");
        System.out.println(TA.countCharacters(text));

        System.out.println("Counting Word Occurance");
        System.out.println(TA.CountwordOccurrence(text,"is"));


    }
}
