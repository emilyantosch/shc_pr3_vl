public class TextAnalyzer {
    public TextAnalyzer(){// constructor

    }
    public boolean isValid(String s){
        if(s==null|| s.trim().isEmpty()){
            return false;
        }else{
            return true;
        }
    }
    public int countWords(String text){
        if(isValid(text)){
            String[] words = text.split(" ");
            int count = words.length;
            System.out.println("The word count is " + count);
            return count;

        }else return 0;
    }

    public int countCharacter(String text){
        if(isValid(text)){
            String newString= text.replace(" ", "");
            int count= newString.length();
            System.out.println("The character count is " + count);
            return count;
        }else return 0;

    }

    public String findLongestWord(String text){
        if(isValid(text)){
            int longest = 0;
            int initial=0;
            String[] words = text.split(" ");
            for (int i=0; i< words.length; i++){
                int length = words[i].length();
                if (length>longest){
                    longest= length;
                    initial = i;
                }
            }
            return words[initial];
        }else return null;
    }

    public int countWordOccurrences(String text, String word){
        if(isValid(text)&& isValid(word)){
            int num= 0;
            String[] words = text.split(" ");
            for (String s: words){
                if (s.equalsIgnoreCase(word)){
                    num = num+1;

                }
            }
            System.out.println("The WordOccurrences count is " + num);
            return num;
        }else return 0;
    }
}
