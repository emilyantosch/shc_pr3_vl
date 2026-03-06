package Text_Analyzer_;

public class TextAnalyzer {


    public int countWords(String text){

        String[] words = text.split(" ");
        System.out.println("Number of words: " + words.length);
        return words.length;
    }

    public int countCharacters(String text){
       int count = 0;
        text.replace(" ", "");
        for(int i=0; i< text.length();i++){
           count++;
       }
        return count;
    }
    public String findLongestWord(String text){
        String[] words = text.split(" ");
        for(int i=0; i< words.length;i++){
            countCharacters(words[i]);
        if (countCharacters(words[i]) >= countCharacters(words[i+1])){
            System.out.print("The longest word is:");
            return words[i];
            }
        }
        System.out.println("Text is empty");
        return null;
    }
    public int countWordOccurences(String text, String word){
        int count=0;
        String[] words = text.split(" ");
        System.out.println("Number of words: " + words.length);
        for (int i= 0; i< text.length();i++){
            if(words[i].toLowerCase().equals((word))){
                count++;
            }
        }
        return count;
    }

}

