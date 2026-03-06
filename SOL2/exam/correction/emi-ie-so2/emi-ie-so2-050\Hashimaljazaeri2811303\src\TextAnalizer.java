public class TextAnalizer {
    private void invalidInput(String text){
        if(text.isEmpty()){
            System.out.println("one enter one word");
        }
    }
    private void oneWordCheck(String text){
        // check if string is empty
        oneWordCheck(text);
        if(text.isEmpty()){
            System.out.println("invalie input");
        }
    }
    public int countWords(String text) {
        invalidInput(text);
        String[] words= text.split(" ");
        return words.length;
    }
    public int countCharacters(String text) {
        invalidInput(text);
        String[] words = text.split(" ");
        int numberOfCharacters= 0 ;
        for (int i = 0; i< words.length; i++) { //loops through all words
            numberOfCharacters = words[i].length() + numberOfCharacters;
        }
        return numberOfCharacters;
    }
    public String findLongestWord(String text) {
        invalidInput(text);
        String[] words = text.split(" ");
        int maxIndex=0; // index of the max word
        int max= 0;
        int temp = 0;
        for (int i = 0; i < words.length; i++) { //loops through all words
            temp = words[i].length();
            if (temp>max){
                max = temp;
                maxIndex = i;
            }
        }
        return words[maxIndex];
    }
    public int countWordOccurrences (String text, String word){
        invalidInput(text);
        String[] words = text.split(" ");
        int numberOfOccurrences= 0 ;
        for (int i = 0; i< words.length; i++) { //loops through all words
            if (word.equalsIgnoreCase(words[i])){
                numberOfOccurrences++;
            }
        }
        return numberOfOccurrences;
    }


}
