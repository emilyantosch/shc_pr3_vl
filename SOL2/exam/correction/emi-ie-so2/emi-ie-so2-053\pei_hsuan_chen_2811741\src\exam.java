//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public  class exam {
    public static class TextAnalyzer{
        public int countwords(String text){
            //check if there's word in the text
            if(text.isEmpty()||text.isBlank()){return 0;}
            String[] words = text.split(" ");
            //split the string into array of string called words
            return words.length;
        }

        public int countCharacters(String text){
            //count all characters in the text
            int length = text.length();
            return length;
        }

        public String findLongestWord(String text){
            //check if there's word in the text
            if(text.isEmpty()||text.isBlank()){return "no words found";}
            //split the string into an array of word string
            String[] words = text.split(" ");
            // get the total numbers of words
            int totalWords = words.length;
            //set the current longest wordlength to 0
            int wordLength = 0;
            //set the first word as the longest
            int longestWord = 0;
            for(int i = 0;i < totalWords; i++){
                String replace = words[i].replace(" ", "");
                //replace the longest word if the word length is longer than the current longest
                if(replace.length() > wordLength){
                    wordLength=replace.length();
                    longestWord = i;
                }
            }
            return words[longestWord];
        }

        public int countWordOccurrences(String text, String word){
            int times = 0;
            //split the string into an array of word string
            String[] words = text.split(" ");
            int totalWords = words.length;
            for(int i = 0;i < totalWords; i++){
                //compare the target word with thw words in the text
                if(word.toLowerCase().equals(words[i].toLowerCase())){
                    //add 1 to times when found the word
                    times+=1;
                }
            }
            return times;
        }
    }
    public static void main(String[] args) {
        TextAnalyzer textAnalyzer = new TextAnalyzer() ;
        String text1 = "Hello world from java";
        String text2 = "today";
        String text3 = "I'm taking a exam now";
        String text4 = "";
        String word1 = "hello";
        System.out.println("There is "+textAnalyzer.countwords(text1)+" words "+textAnalyzer.countCharacters(text1)+" characters"+" in text1");
        System.out.println("The longest word in text1 is "+textAnalyzer.findLongestWord(text1));
        System.out.println("Found "+word1+" "+textAnalyzer.countWordOccurrences(text1,word1)+" time(s) in text1");




    }
}