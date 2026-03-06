public class TextAnalyzer {
    private String text;
    private int totalNumberofWords;
    private int totalNumberofCharactrs;
    private String LongestWord;
    private int occurance;
    public TextAnalyzer(String text, int totalNumberofWords, int totalNumberofCharactrs, String longestWord ,int occurance) {
        this.totalNumberofWords = totalNumberofWords;
        this.totalNumberofCharactrs = totalNumberofCharactrs;
        this.LongestWord = longestWord;
        this.text =  text;
        this.occurance = occurance;
    }
        public <string> int countWords(String text){
            string[] words = text.split(" ");
            system.out.println("Number of words:" + words.length);
            words.length = totalNumberofWords ;
            return totalNumberofWords;
        }
        public <string> int countCharacters(String text){
            string[] char = text.replace();
            totalNumberofCharactrs = int (char);
            return totalNumberofCharactrs;
        }
        public <string> string findLongestWord(String text){
            for(int i =0; i<text.length();i++)
            {
                if(text[i]=text.max);
            }
        }
        public int countWordOccurrences( String text , String Word){
        int count;
            for(int i =0; i<text.length();i++)
        {
            if(text[i]==word);
            count++;
        }
        count = occurance;
        return occurance;
        }

}
