import java.util.*;

public class TextAnalyzer {
    public int countWords(String text){
        if (text.isBlank()){
            System.out.println("Error: String cant be empty, blank or null");
            return 0;
        }else{
            String[] words = text.split(" ");
            if(words.length == 1){
                System.out.println("Error: enter multiple words");
                return 0;
            }
            else {
                return words.length;
            }

        }
    }
    public int countCharacters(String text){
        int chars = 0;
        if (text.isBlank()){
            System.out.println("Error: String cant be empty, blank or null");
            return 0;
        }else {
            String[] words = text.split(" ");
            if(words.length == 1) {
                System.out.println("Error: enter multiple words");
                return 0;
            }
            else {
                for (int i = 0; i < words.length; i++) {
                    chars += words[i].length();
                }
                return chars;
            }
        }
    }
    public String findLongestWord(String text){
        String longest;
        if (text.isBlank()) {
            System.out.println("Error: String cant be empty, blank or null");
            return null;
        }
        else {
            String[] words = text.split(" ");
            if(words.length == 1) {
                System.out.println("Error: enter multiple words");
                return null;
            }
            else {
                longest = words[0];
                for (int i = 1; i < words.length - 1; i++) {
                    if (longest.length() <= words[i].length()) {
                        longest = words[i];
                    }
                }
                return longest;
            }
        }
    }
    public int countWordOccurrences(String text, String word){
        int occurrences = 0;
        if (text.isBlank() || word.isBlank()) {
            System.out.println("Error: String cant be empty, blank or null");
            return 0;
        }
        else {
            String[] words = text.split(" ");
            for (int i = 0; i < words.length; i++) {
                if (words.length == 1) {
                    System.out.println("Error: enter multiple words");
                    return 0;
                } else {
                    if (word.toLowerCase().equals(words[i].toLowerCase())) {
                        occurrences++;
                    }
                }
            }
            return occurrences;
        }
    }
}
