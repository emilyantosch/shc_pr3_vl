public class TextAnalyzer {
    public static int countWords(String text){
        if (text.isEmpty()){
            return 0;
        }

        String[] seperatedString = text.split(" ");
        return seperatedString.length;
    }

    public static int countCharacters(String text){
        return text.replace(" ","").length();
    }

    public static String findLongestWord(String text){
        String longestWord = "";

        String[] seperatedString = text.split(" ");

        for (String word : seperatedString){
            longestWord = word.length() > longestWord.length() ? word : longestWord;
        }

        if (longestWord.isEmpty()){
            return "The string contains no words!";
        }

        return longestWord;
    }

    public static int countWordOccurrences(String text, String word){
        int occurrenceCount = 0;

        String[] seperatedString = text.split(" ");

        for (String textWord : seperatedString){
            if (textWord.equalsIgnoreCase(word)){
                occurrenceCount++;
            }
        }

        return occurrenceCount;
    }

    public static void main(String[] args){
        String exampleText = "Hello! hello... Can you say hello back?";
        String exampleEmpty = "";

        System.out.println("==Example Text==");
        System.out.println(countWords(exampleText));
        System.out.println(countCharacters(exampleText));
        System.out.println(findLongestWord(exampleText));
        System.out.println(countWordOccurrences(exampleText, "Hello"));

        System.out.println("==Example Empty String==");
        System.out.println(countWords(exampleEmpty));
        System.out.println(countCharacters(exampleEmpty));
        System.out.println(findLongestWord(exampleEmpty));
        System.out.println(countWordOccurrences(exampleEmpty, "Hello"));
    }
}

