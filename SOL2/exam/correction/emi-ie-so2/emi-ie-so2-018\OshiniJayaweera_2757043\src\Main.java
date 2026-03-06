public class Main{
    public static void main(String[] args){
        String text = "Hello hi hi speaking from world of Java";
        TextAnalyzer texts = new TextAnalyzer(text);

        System.out.println("WordCount = " + texts.countWords(text) );

        System.out.println("CharacterCount = " + texts.countCharacters(text));

        System.out.println("LongestWord = " + texts.findLongestWord(text));

        int specificWordCount = texts.countWordOccurrences(text, "Hi");
        System.out.println("This word is printed " + specificWordCount + " times");
    }
}