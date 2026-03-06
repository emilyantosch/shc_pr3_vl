public class TextAnalyzer{

    private String text="Hello world from Java";
    private String[] words= text.split("");

    public TextAnalyzer(String text,String words){
        this.text= text;

    }

    public String getcountWords(){
        return countWords;

    }

    public String getcountCharacters(String text){
        return countCharacters;
    }
    public String getfindLongestWord(String text){
        return longestWord;
    }

    public String getcountWordOccurences(String text,String word ){
        return getcountWordOccurences;

    }




}