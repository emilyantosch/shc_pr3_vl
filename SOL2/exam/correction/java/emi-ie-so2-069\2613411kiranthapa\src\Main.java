public class Main {
    public static void main(String[] args){
        TextAnalyzer mytextAnalyzer = new TextAnalyzer("Hello");

        String text = "Hellow world from Java";
        System.out.println("Here is your total words");
        TextAnalyzer countchar = mytextAnalyzer.countWords("hello");

        System.out.println("Here is your total characters");
        TextAnalyzer countchar = mytextAnalyzer.countCharacters("hello");

        System.out.println("Here is your logest word ");
        TextAnalyzer findLongWord = mytextAnalyzer.findLongestWord("hello");

        System.out.println("Here is your repeating character occuring");
        TextAnalyzer countchar = mytextAnalyzer.countWordOccurrences("Hello","l");
}