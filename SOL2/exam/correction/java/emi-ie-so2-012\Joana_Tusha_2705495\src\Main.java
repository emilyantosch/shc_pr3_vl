import org.w3c.dom.Text;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {



    public static void main(String[] args) {

           TextAnalyzer textAnalyzer = new TextAnalyzer();

            String test = "This This is an example of a little text. I hope it works.";
            String word = "This";
            System.out.println(test);
            System.out.println("Nr of words: " + textAnalyzer.countWords(test));
            System.out.println("Nr of characters: " + textAnalyzer.countCharacters(test));
            System.out.println("Nr of word occurances: " + textAnalyzer.countWordOccurences(test,word));
         // System.out.println("Longest Word: " + textAnalyzer.findLongestWord(test));

        }

}