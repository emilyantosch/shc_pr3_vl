public class TextAnalyzer {

    public String text;
    public String word;
    public char character;

    public TextAnalyzer(String text, String word, char character) {
        this.text = text;
        this.word = word;
        this.character = character;
    }

    public String getText() {
        return text;
    }

    public String getWord() {
        return word;
    }
    public int countWords(String text){
        int amount = 0;
        if(getText() == null){
            System.out.println("Cannot be null.");
        }else {
            for (int i = 0; i < 0; i++) {
                text = "Hello world from Java";
                String[] word = text.split(" ");
                System.out.println("Number of words: " + word.length);

            }
        }
        return amount;
    }

    public int countCharacters(String text){
    ;

    return charCount;
    }

    public int countWordOccurences(String text, String word){

        return occuredWord;
    }

}
