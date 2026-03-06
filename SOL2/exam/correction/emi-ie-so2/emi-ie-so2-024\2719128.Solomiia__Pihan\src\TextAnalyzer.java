public class TextAnalyzer {
    private String text;
    private int count = 0;
    public TextAnalyzer(String text){
        this.text = text;
    }

    // method to count the number of character in the text
    public int countCharacters(String text){
        if(text == null || text.isEmpty()) {
            return 0;
        }

        text.replace(" ", "");
        int num = text.length();
        System.out.println(" The number of characters is :");
        return num;
    }

    // method to count the number of words in the text
    public int CountWords(String text){
        if(text == null || text.isEmpty()){
            return 0;
        }

        System.out.println(" The number of words is :");
        String[] word = text.split(" ");
        for(int i = 0; i < text.length()-1; i++){
            return word.length;
        }
        return 0;
    }

    // method to find the longest word in the text
    public String findTheLongestWord(String text, String word){
        if(text == null || text.isEmpty() || word == null || word.isEmpty()){
            return null;
        }

        System.out.println(" The longest word is :");
        String[] words = text.split(" ");
        int max = 0;
        for(int i = 0; i < text.length()-1; i++){
            if(word.length() > max) {
                max = word.length();
                return words[i];
            }
        }
        return null;
    }

    // method to count how ofter the word appear in the text
    public int countWordOccurences(String text, String word){
        if(text == null || text.isEmpty() || word == null || word.isEmpty()){
            return 0;
        }
        int max = 0;
        for(int i = 0; i < text.length()-1; i++){
            if(word.toLowerCase().length() < max){

                count++;
            }
            if(word.toLowerCase().length() == text.toLowerCase().length()){
                count++;
            }
        }
        return 0;
    }
}



















