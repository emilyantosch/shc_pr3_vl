import java.util.Objects;

public class TextAnalyzer {

    private String textContent;

    TextAnalyzer(String textContent){
        this.textContent = textContent;
    }

    public int countWords(String text){
        String[] words = text.split(" ");
        return words.length;
    }

    public int countCharacters(String text){

        String newText;
        newText = text.replace(" ","");
        return newText.length();

    }

    public String findLongestWord(String text){

        String newText[] = text.split(" ");
        String longestWord = "";

        for (String word: newText){
            if (word.length() > longestWord.length()){
                longestWord = word;
            }
        }

        return longestWord;
    }

    public int countWordOccurrences(String text,String word){
        int wordCount = 0;
        String newWord = word.toLowerCase();
        String newText[] = text.split(" ");

        for (String words: newText){

            if (Objects.equals(words.toLowerCase(), newWord)){
                wordCount++;
            }

        }

        return wordCount;
    }

}