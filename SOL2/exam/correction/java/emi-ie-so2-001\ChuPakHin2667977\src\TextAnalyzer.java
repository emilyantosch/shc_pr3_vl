public class TextAnalyzer {

    private String text;

    public TextAnalyzer(String text){
        this.text = text;
    }

    public int countWords(String text){
        String[] words = text.split(" ");
        return words.length;
    }

    public int countCharacters(String text){
        return text.length();
    }


    public String longestWord(String text){
        String[] words = text.split(" ");
        int charCount = 0;
        String targetWord = null;
        for(int i = 0; i < words.length; i++){
            countCharacters(words[i]) = charCount; // need to access the string at array index
            if (countCharacters(words[i]) > charCount){
                targetWord = countCharacters(words[i]);
            }
        }
        return targetWord;
    }

    public int countWordOccurences(String text, String word){
        int count = 0;
        for (String s: words){
            if (word.equalsIgnoreCase(text)){
                count++;
            }

            else return 0;
        }
    }

    public static void main(String[] args) {
        TextAnalyzer t = new TextAnalyzer("Hello world from Java");
        System.out.println(t.countWords(t.text));
        // not completed System.out.println(t.countCharacters(t.text));
        // not completed System.out.println(t.longestWord(t.text));


    }
}
