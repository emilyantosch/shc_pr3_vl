//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        //sample code
        String text = "there was a blue cat and a yellow cat with a her small green cat in a house full of cats";
        TextAnalizer textAnalizer= new TextAnalizer();
        System.out.println(textAnalizer.countWords(text));
        System.out.println(textAnalizer.countCharacters(text));
        System.out.println(textAnalizer.countWordOccurrences(text, "cat"));
        System.out.println(textAnalizer.findLongestWord(text));


        }
    }
