import java.sql.SQLOutput;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        TextAnalyzer textAnalyzer = new TextAnalyzer();

        String text = "The weather today is really good and I hope I have the PVL";

        System.out.println("The sentence is \""+text+"\"");

        if(textAnalyzer.isNotEmpty(text)){
            //demo: count words
            System.out.println("There are "+textAnalyzer.countWords(text)+" words.");

            //demo: count characters:
            System.out.println("There are "+textAnalyzer.countCharacters(text)+" characters.");

            //demo find longest word:
            System.out.println("The longest word is \""+textAnalyzer.findLongestWord(text)+"\"");

            //demo count word occurence
            String word = "Weather";

            System.out.println("The word \""+word+"\" appears "+textAnalyzer.CountWordOccurences(text,word)+" time(s) in this sentence");
        }
    }
}