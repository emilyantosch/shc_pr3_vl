//Practical Part Task F - Omar Abdeldayem_2757212
//Coding styles including naming conventions, indentations, comments have been followed as much as I could
public class TextAnalyzer {
    private String text;
    public int letterCount;
    public String biggestWord;
    public int wordOccurrences;
    public TextAnalyzer(String text){ //Creating our default constructor for initializations
        //Initializing our attributes
        this.text = text; //Using this. operator for initializations
    }
    public int countWords(String text){
        String[] words = text.split(" ");//Splitting our text to words and removing spacings
        return words.length;
    }

    public int countCharacters(String text){
        String[] words = text.split(" ");
        letterCount=0;
        for(String x: words){
            letterCount += x.length(); //incrementing count by the length of every word
            }
        return letterCount;
    }

    public String findLongestWord(String text){
        String[] words = text.split(" ");
        letterCount=0;
        biggestWord = words[0];// I initialized a variable named biggestWord to keep track of the biggest Word
        //First setting it to the first word in our string array, and modifying throughout the loop
        for(String x: words){
            if(x.length() > biggestWord.length()){
                biggestWord = x; //If a  bigger length found, replace our biggest word
            }
        }
        return biggestWord; //After exiting our loop we return the biggest word found
    }
    public int intcountWordOccurrences(String text, String word){
        String[] words = text.split(" ");
        wordOccurrences = 0; /* I initialized a variable named wordOccurrences to keep track how many times
        a specific word was found, firstly setting to 0
        */
        word=word.toLowerCase(); //Setting our word to lower case
        for(String x: words){
            if(x.toLowerCase()==word){ //Setting each word in our loop to lower case (Case insensitive)
                wordOccurrences++;
            }
        }
        return wordOccurrences; //Returning word occurrences found
    }
    //The code should handle edge cases appropriatly with the use of proper if statements
    public static void main (String[] args){

        //Main method Initiated
        //Couldn´t finish on time

    }
}