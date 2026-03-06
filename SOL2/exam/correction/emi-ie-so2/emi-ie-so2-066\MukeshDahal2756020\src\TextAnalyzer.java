/**
 * this is the class TestAnalyzer
 * It implements different analysis on text
 */
public class TextAnalyzer {
    private int wordsNo;
    private int charNo;
    private String longWord;
    private int count;
    private String[] words;

    //creating countWords method with parameter text
    public int countWords(String text){
        //validate the string
        if(text==null||text.isEmpty()){
            System.out.println("invalid text is given " );
            return 0 ;
        }else {
            words=text.split("");
            return words.length;
        }


    }

    //creating method to count character in the given text
    public int countCharacters(String text){

        return charNo;
    }

    //creating method of finding longest word (string text that finds and return lomgest word
    public String findLongestWord(String text){

        return longWord;

    }

    //this method countswordoccurence like how many times a specific word appears in the text

    public int countWordOccurences(String text, String word){

        return count;
    }
}

