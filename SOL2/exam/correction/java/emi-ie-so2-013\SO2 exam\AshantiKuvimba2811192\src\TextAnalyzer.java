public class TextAnalyzer {

    public int countWord(String text){
        int numberOfWords = 0;

        if(text == null || text.isEmpty()){
            System.out.println("String is empty, type in a few words.");
            return 0;
        }
        String[] words = text.split(" ");
        numberOfWords = words.length;

        return numberOfWords;
    }

    public int countCharacters(String text){
        if(text.isEmpty()){
            System.out.println("String is empty, cannot count characters.");
            return 0;
        }

        String characters = text.replace(" ", "");
        int characterLength = countCharacters(characters);

        return characterLength;
    }

    public String findLongestWord(String text){
        if(text == null || text.isEmpty()){
            System.out.println("String is empty, cannot find longest word");
            return null;
        }
        String longWord = findLongestWord(text);
        return longWord;
    }

    public int countWordOccurrences(String text, String word){
        if(text == null || text.isEmpty()){
            System.out.println("String is empty, cannot count number of word occurrences");
            return 0;
        }
        String sentence = text.toLowerCase();
        String oneWord = word.toLowerCase();

        int numberOfOccurrences = countWordOccurrences(sentence, oneWord);

        return  numberOfOccurrences;
    }
}
