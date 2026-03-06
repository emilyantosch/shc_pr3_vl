public class TextAnalyzer {

    public String text;

    public int countWords(String text) {
        String[] words = text.split(" ");
        int sum = 0;
        for (String word : words) {
            sum++;
        }

        return sum;
    }

    public int countCharacters(String text){
        return text.length() - countWords(text) + 1;
    }

    public String findLongestWord(String text){
        String[] words = text.split(" ");

        for (int i = 0 ; i < text.length(); i++ ){
            if ( words[i] > words [i+1]){
                return words [i];
            }else return words[i+1];
        }

        return ;
    }

    public int countWordsOccurrences (String text, String word){

        int sum =0;
        String[] words = text.split(" ");
        for (String w : words) {
            if ( w.equalsIgnoreCase(word))
                sum++;
        }
        return sum;
    }

    public static void main(String[] args) {

        TextAnalyzer text = new TextAnalyzer();

        text.text = "Hello My Dear";

        System.out.println("Counting Words");
        System.out.println(text.countWords(text.text));

        System.out.println("Counting Characters without spaces");
        System.out.println(text.countCharacters(text.text));

        System.out.println("Count Words Occurrences");
        System.out.println(text.countWordsOccurrences(text.text , "dear"));

        System.out.println("find Longest Word");
        System.out.println(text.findLongestWord(text.text));



    }
}
