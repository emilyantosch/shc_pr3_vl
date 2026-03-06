//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        TextAnalyzer text= new TextAnalyzer();

        System.out.println(text.countWords("My name is Dulathmee"));
        System.out.println(text.countCharacter("I am happy today"));
        System.out.println(text.findLongestWord("I am writing a difficult exam"));
        System.out.println(text.countWordOccurrences("I love meatballs because meatballs are tasty","Meatballs"));

    }
}