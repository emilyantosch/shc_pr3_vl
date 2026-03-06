public class TextAnalyzer {
    public static int countWords(String test) {
        if (text == null || text.trim().isEmpty()) {
            return 0;
        }


        String[] words = text.trim().split("\\s+");
        return words.length;
    }

    public static int countCharacters(String text){
        if (text == null){
            return 0;
        }
        int count = 0;
        for (int i = 0; i < text.length(); i++){
            if (text.charAt(i) != ''){
                count++;
            }
        }
        return count;
    }
    public static String findLongestWord(String text){
        if (text == null || text.trim().isEmpty()) {
            return "";
        }
        String[] words = text.trim().split("\\s+");
        String longest = words[0];

        for (String word : words){
            if ( word.length() > longest.length()){
                longest = word;
            }
        }
        return longest;
    }
    public static String countWordOccurrences(String text, String word){
        if (text == null || text == null {
            return 0;
        }
        String[] words = text.toLowerCase().split("\\s+");
        String target = word.toLowerCase();
        int count = 0;

        for (String w : words){
            if (w.equals(target)){
                count++;
            }
        return count;
    }

        public static void main(String [] args){

            System.out.println("Number of words: " + words.length);
            System.out.println("Number of characters: " + Characters.length);
            System.out.println("Number of words: " + words.length);
        }



}


