//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        //writing different test cases for the methods implemented
        String text = "hi my name is Mukesh and how are you hi again hahaha please like comment ";
        String[] words = text.split(" ");

        //Printing given string
        System.out.println("the given text = " + text);

        TextAnalyzer test = new TextAnalyzer();//creating object of the class to access different methods

        //counting number of words in the given text
        int countWord= test.countWords(text);
        System.out.println("the number of words in the given text  =  " + countWord );

        //counting character of the given string
        int countChar = test.countCharacters(text);
        System.out.println("the number of characters in the given text  =  " + countChar );

        //returning longest word from given text
        String longWord = test.findLongestWord(text);
        System.out.println("the longest words in the given text  =  " + longWord);

        //returning no of wordoccurence in the text
        int count =test.countWordOccurences(text,"hi");
        System.out.println("the number of hi in the given text  =  " + count );
    }
}