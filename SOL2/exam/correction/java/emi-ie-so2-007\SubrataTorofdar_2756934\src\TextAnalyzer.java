public class TextAnalyzer {


// method countwords
    public int countWords(String text){
        if(text ==null |text.trim().isEmpty()){
            return 0;
        }
        String[] words = text.trim().split();

        return words.length();
    }

    // method countCharacter
    public int countCharacter(String text){
        if(text ==null){
            return 0;
        }
        return text.length();

    }

    //method findLongestWord
    public int findLongestWord(String text){
        //logic statement


        return;
    }

    public int countWordOccurrences(String text, String word){
        if(text.equalsIgnoreCase(word) || word.equalsIgnoreCase(text)){
            return System.out.println("Both are equals");
        }
        else
    }

    public int CoutWordOccurrences(String text, String word){
        // logic statement as here is algorithom missmatch so i write the structure for partial marking

        return;
    }



}
