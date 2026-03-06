package textanalyzer;

public class TextAnalyzer {
    String text=null;
    String[] words=text.split("Hello world from java");
    //method to count words
    public int countWords(String text){
        int i=0;
        for (String word : words) {
         i++;
        }
        return i;
    }

    //method to count characters
    public void countCharacters(String text){
        int helloWorldFromJava = String.length(text);
        System.out.println("Length of the Text´"+text+"´ is "+helloWorldFromJava);
    }

    //method to find the ongest word
    public String findLongestWord(String text){
        String longestWord = null;
        for (String word : words) {
            int max = 0;
            if (toString(word).length(word)>max){
                max=String.length(word);
                longestWord=word;
            }
        }
        return longestWord;
    }

    //counts how many times a specific word appears
    public void  countWordOccurrences(String text, String currentWord ){
        int appearenceCount=0;
        for (String word : words) {
          if (word.equalsIgnoreCase(currentWord)){
              ++appearenceCount;
              System.out.println("Word"+word+"appeared "+appearenceCount+"times");
          }
        }

    }

    public static void main(String[] args){
        //private attribute
        String text=null;
        String[] words=text.split("Hello world from java");


        TextAnalyzer myAnalyzer=new TextAnalyzer();
        myAnalyzer.countWords("Hello world from java");
        myAnalyzer.countCharacters("Hello world from java");
        myAnalyzer.findLongestWord("Hello world from java");

        for (String word : words) {
            myAnalyzer.countWordOccurrences("Hello world from java",word);
        }
}
}