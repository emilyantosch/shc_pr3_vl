Public Class TextAnalyzer {
    Private String[] words;
    Private String[] chars;

    Public int countWords(String text){
        words = text.split(" ");
        Private count = words.length;
        return count;
        }
    }
    Public int countCharacters(String text){
        String[] words = text.split(" ");
        String[] chars = words.replace(" ");
        Private charCount = chars.length;

        return charCount;
    }
    Public String findLongestWord(String text){
        String[] words = text.split(" ");
        Private String worrrd;
        for(int i=1; i<words.length;i++)
        {
            if(String[i] words.length>String[i-1] words.length){
            worrrd = String[i] words;
        }

return worrrd;
    }
    Public int countWordOccurrences(String text, String word){
        words = words.toLowerCase;
        words = text.split(" ");
        Private int sum = 0;
        for(int i=0; i<words.length;i++)
        {
            if(String[i] words = word)
            {
                sum++;
            }
        }
        return sum;
    }

    Puclic static void main(String[]args){

    TextAnalyzer a = new TextAnalyzer();
    countWords("Hello world from Java");
    countCharacters("Hello world from Java");
    findLongestWord("Hello world from Java");
    countWordOccurrences("Hello world from Java");
}
}