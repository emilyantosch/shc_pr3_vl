public class TextAnalyzer {
    private String text;
    private String word;

    public TextAnalyzer(String text, String word) {
        this.text = text;
        this.word = word;
    }

    public String getText() {
        return text;
    }

    public String getWord() {
        return word;
    }

    public int countWords(String text){
        String[] words = text.split(" ");
        return  words.length;
    }

    public int CountCharacters(String text){
        String[] words = text.replace(" ","");
        return words.length;
    }

    public String findLongestWord(String text){
        String[] words = text.split(" ");

        for(int i=0; i< words.length; i++){
            words[i].length()

        }
    }

    public int countWordOccurrences(String text, String word){
        String[] words = text.split(" ");
        for(int i=0; i< words.length; i++){
            if(word == word_comp)
        }

    }
}
