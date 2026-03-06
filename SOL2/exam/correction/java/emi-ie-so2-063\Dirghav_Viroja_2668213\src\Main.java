//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
             String text = "Hello world from java";          // Sample text for testing
             TextAnalyzer analyzer = new TextAnalyzer();     // instanciaing for object to use methods

             System.out.println("Number of words :- "+  analyzer.countWords(text) );                                     // word counting
             System.out.println("Number of character :- "+(analyzer.countCharacters(text)-analyzer.countWords(text)));  // character count

    }
}