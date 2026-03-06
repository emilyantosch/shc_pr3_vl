public class TextAnalyzer {

    public String text;


    public TextAnalyzer(String text) {
        if (text == null | text.isBlank()) {
            throw new IllegalArgumentException("text must be non-null and non-blank");
        }
        this.text = text;
    }

    public void countWords (String text) {

        String[] words = text.split(" ");
        System.out.println("Number of words: " + words.length);
    }

    public void countCharacters(String text, String words) {
        int count = 0;
        for (elements : words) {

            String[] Characters = words.split("");
            count++;


        }
        System.out.println("Number of chars: " + count);
    }


    public void findLongestWord(String text) {

        


    }


    public void countWordOccurences(String text, String word) {


    }
}
