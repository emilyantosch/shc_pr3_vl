public class TextAnalyzer {
    private String text; //instance variable text

    //constructor to initiate the instance attributes
    public TextAnalyzer(String text){
        this.text = text;
    }

    //method to return the number of words contained in the text
    public int countWords(String text){

        String[] words = text.split(" "); //split passed text into words by spaces

        //handles text being empty case and having single word case
        if(words.length == 1 || words == null){
            System.out.println("Empty text or please try again with a text with " +
                                "more than single word");
            return 0;
        }

        return words.length;
    }

    //methods that returns te number of characters in the text
    public int countCharacters(String text){

        if(text.equals("")){
            System.out.println("Empty text");   //handles text being empty case
        }

        return text.replace(" ", "").length();
    }


    //method to return the longest word in the text
    public String findLongestWord(String text){

        String[] words = text.split(" ");
        int longest = 0;
        String longestWord = " ";

        if(text.equals("")){
            System.out.println("Empty Text!");//handles text being empty case
            longestWord = "No words";
        }else{
            for(String s : words){
                if(s.length() > longest){
                    longest = s.length();
                    longestWord = s;
                }
            }
        }

        return longestWord;
    }

    //method to count the occurrences of a specific word in the text
    public int countWordOccurrences(String text, String word){

        String[] words = text.split(" ");
        int occurrences = 0;

        if(text.equals("")){
            System.out.println("Empty Text!");  //handles text being empty case
        }else{
            for(String s : words){
                if(word.equalsIgnoreCase(s)){
                    occurrences++;
                }
            }
        }

        return occurrences;
    }
}
