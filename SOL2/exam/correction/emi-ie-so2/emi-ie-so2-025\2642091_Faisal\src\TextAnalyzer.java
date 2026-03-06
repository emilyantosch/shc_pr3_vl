public class TextAnalyzer {
    private String text;

    public TextAnalyzer(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }
    public String[] words{
        return getText().split(" ");
    }
    public int countWords(){
       return "Number of words"+ words.length ;

    }


}
