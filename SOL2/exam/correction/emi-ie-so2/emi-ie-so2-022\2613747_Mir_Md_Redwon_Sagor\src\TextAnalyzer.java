public class TextAnalyzer {


    public int countWrods(String text){

        String[] words = text.split(" ");
        return words.length;

    }

    public int countCharacters(String text){
        String[] words = text.split(" ");
        int charNum = 0;


        for(int i = 0; i<words.length; i++) {
            charNum = words[i].length();
        }

        return  charNum;
    }



    public String findLongestWord(String text){
        String[] words = text.split(" ");
        String max="";
        for(int i = 0; i<words.length; i++) {
             if (words[i].length() > words[i+1].length()){
                 max = words[i];
             }
        }

        return max;

    }
    public int countWordOccurrences(String text, String word){
        String[] words = text.split(" ");
        int count= 0;
        for(int i = 0; i<words.length; i++) {
            if(words[i] == word){
                count ++;
            }
        }

        return count;
    }



}
