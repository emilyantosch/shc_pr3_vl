public class TextAnalyzer {
    public static void main(String[] args) {

        String text = "Hello World from Java";

//        TextAnalyzer(String text) {
//        this.text = text;
//        }

        System.out.println("The string that we use: " + text);

        System.out.println();
        System.out.println("Number of words: " + countWords(text));

        System.out.println();
        System.out.println("The number of characters(excluding spaces): " + countCharacters(text));

        System.out.println();
        System.out.println("This is the longest word: ");




    }

    // this method is to count with words
    static int countWords(String text){
        String[] words = text.split(" ");

        return words.length;

    }

    // this method is to count the characters with no spaces
    static int countCharacters(String text){

        String newText = text.replace(" ", "");
        int newTextLength = newText.length();
        return newTextLength;

    }

    // this method is to find the longest word
    static String findLongest(String text){

        String[] words = text.split("");

        int count = 0;

        String longest;

        for (int i = 0; i < words.length; i++){
            System.out.print(words[i]);

            if (words[i] != " "){
                count++;

            }
            else {
                break;            }
        }

        System.out.println(count);

        return longest;
    }

    static int countWordOccurences(String text, String word){

        return;
    }


}
