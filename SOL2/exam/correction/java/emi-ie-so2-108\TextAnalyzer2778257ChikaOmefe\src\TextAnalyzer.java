public class TextAnalyzer {

    public static void main(String[] args) {
        String text = "Hello world from Java !";

        countWords(text);
        System.out.println(countCharacter(text));
        System.out.println(findLongestWord(text));
    }

    static public void countWords(String text) {
        String[] word = text.split(" "); // split words at each new space
        System.out.println("Number of words: " + word.length);
    }

    static public String countCharacter(String text) {
        String[] word = text.split(" "); // remove all spaces
        int character = 1;
        for (int ii = 0; ii <= word[ii].length(); ii++){
            character += word[ii].length();

        }

        return "Number of characters (excluding spaces): " + character;
    }

    static public String findLongestWord(String text){
        String[] word = text.split(" "); // remove all spaces
        int[] length = new int[word.length];

        for(int ii = 0 ; ii <= word[ii].length(); ii++){
            length[ii] = word[ii].length();
        }

        for (int ii = 0; ii < word.length; )

        return "Longest Word: " + word[maxlength] ;
    }

}
