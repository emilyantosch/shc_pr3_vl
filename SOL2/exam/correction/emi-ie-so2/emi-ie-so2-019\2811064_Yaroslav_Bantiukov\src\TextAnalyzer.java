public class TextAnalyzer {
    static String text = "Hello world from Java";

    public static int countWords(String text){
        String[] words = text.split(" ");
        int amount = words.length;
        System.out.print("Amount of words is: " + amount);
        return amount;
    }

    public static int countCharacters(String text){
        String noSpace = text.replace(" ", "");
        int amount = noSpace.length();

        System.out.print("\nAmount of characters is: " + amount);
        return amount;
    }

    public static String findLongestWord(String text){
        String[] words = text.split(" ");
        for(int i = 0; i < text.length(); i++){
            for(int j = 0; j < text.length(); j++){
                if(words[i].length() > words[j].length()){
                    System.out.print(words[i]);
                }
            }
        }
        //System.out.print("The longest word is: " + longestWord);
        //return longestWord;
        return;
    }

    public static void main(String[] args){
        countWords(text);
        countCharacters(text);
        findLongestWord(text);
    }
}
