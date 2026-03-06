public class TextAnalyzer {

    public int countWords(String text){   // method for counting
        String[] words = text.split(" ");
        return words.length;
    }

    public int countCharacters(String text){    // method for count characters
        int counter=0;
        int count = 0;
        for (int i = 0; i <= text.length(); i++) {
            count = counter++;
        }
        return count+1;   // just to deduct total spacs like excluding spaces.
    }
}


