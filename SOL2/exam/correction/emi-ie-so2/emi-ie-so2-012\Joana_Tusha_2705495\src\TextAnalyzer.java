import java.util.Objects;

public class TextAnalyzer {

    public int countWords(String text){
        if(text == null || text.isEmpty())
        {
            return 0;
        }
        String[] words = text.split(" ");   //as example on exam
        return words.length;
    }

    public int countCharacters(String text){
        if(text == null || text.isEmpty())
        {
            return 0;
        }
        return text.length();       //literally all of the characters, spaces included-
    }

   /* public String findLongestWord(String text){   //i would do this by running through all characters before
                                                    //a space " ". Store the number of characters and overwrite it
        for(int i = 0; i< text.length(); i++){      //everytime a longer one (more characters) appear
           if ()
        }


    }*/

   public int countWordOccurences(String text, String word){
       int count = 0; // theoretically, starting from 0, everytime text equals the word while we run through the whole text
       for(int i = 0; i < text.length(); i++){      //it should add to a counter and finally return the counter number
           if(Objects.equals(text, word)){
               int i1 = count++;
               return i1;
           }
       }
        return 0;
    }



}
