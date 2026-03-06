public class TextAnalyzer {

    //This method count words
    public int countWords(String text){

        //check if empty
        if(text.isEmpty()){
            System.out.println("Empty String Passed");
            return 0;
        }

        //checks if only one word passed
        if(text.length() == 1 ){
            System.out.println("Only one word passed!");
            return 1;
        }

        //splits words
        String[] words = text.split(" ");
        return words.length;
    }

    public int countCharacters(String text){
        if(text.isEmpty()){
            System.out.println("Empty String Passed");
            return 0;
        }
        String characters = text.replace(" ", "");
        return characters.length();
    }

    public int countWordOccurrences(String text, String word){
        if(text.isEmpty()){
            System.out.println("Empty String Passed");
            return 0;
        }
        if(text.length() == 1 ){
            System.out.println("Only one word passed!");
            return 1;
        }
        int count = 0;
        String[] words = text .split(" ");
        for(String textword : words){
            if(textword.equalsIgnoreCase(word) ){
                count++;
            }
        }
        return count;

    }
    /*
    public String findLongestword(String text){
        String[] words = text .split(" ");
        TextAnalyzer t = new TextAnalyzer();
        I am going to explain here what i was aboutto do but could nt implement because of time contraint.

        I will parse the string into words which is then going to store at a String array.
        THen I will use funtion countcharacters to count the length of the word referecing from text analyzer.
        I will again store them one by one into arrays.
        then use the sorting of arrays.
        then get the last index array. and then return the corresponding string
        }
    }

    */

    public static void main(String[] args) {

        TextAnalyzer textAnalyze = new TextAnalyzer();

        String name = "My name is Robin robin";

        int x = textAnalyze.countWords(name);
        int y = textAnalyze.countCharacters(name);

        System.out.println("Number of Words: " + x );
        System.out.println("Number of Characters: " + y);

        String word = "Robin";
        System.out.printf("THe word %s consists: %d times", word, textAnalyze.countWordOccurrences(name, word));

    }

}
