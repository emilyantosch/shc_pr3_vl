public class TextAnalyzer {

    public static int countWords(String text){
        if (text == null || text.trim.isEmpty() ){
            return 0;
        }
        String [] words = text.trim().split("\\s");
        return words.length;
    }



     public static int countCharacters(String text){
         if (text == null){
             return 0;
         }
         String nospace = text.replace("","");
         return nospace.length();
     }

     public  String (String text) {
        if (text == null || text.isEmpty()){
            return "";

        }
        String [] words = text.trim().split("\\s");
        String longest = words[0];
        for (string word : words){
            if (word.length() > longest.length()){
                longest = words;
            }
        }
         return longest;
     }

}
