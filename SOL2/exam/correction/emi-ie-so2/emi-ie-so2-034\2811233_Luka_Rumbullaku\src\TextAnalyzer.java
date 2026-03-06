public class TextAnalyzer {

    private String text = "hello form Luka" ;
    private String[] word = text.split(" ");


    public TextAnalyzer(String text, String[] word) {
        this.text = text;
        this.word = word;
    }

    public String getText() {
        return text;
    }

    public String[] getWord() {
        return word;
    }

    public int countWords (String text){
        int count = 0;
        if (text == null || text.isEmpty()){
            System.out.println("Field is empty");
        } else {
            for (int i = 0; i > text.length() ; i++){
                count++;
            }
        }
        return count;
    }

    public int countCharacters(String text){

        int count = 0;


        return count;
    }

    public String findLongestWord(String text){


        return text;
    }

    public int countWordOccurrences(String text , String word){

        return 0;
    }
}
