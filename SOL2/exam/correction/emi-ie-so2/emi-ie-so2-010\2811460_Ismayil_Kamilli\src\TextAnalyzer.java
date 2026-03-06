public class TextAnalyzer {

    public int countWords(String text){
        //checks if text is empty
        if (text.isEmpty()){
            return 0;
        }
        String[] words = text.split(" ");
        return words.length;
    }

    public int countCharacter(String text){
        //checks if text is empty
        if (text.isEmpty()){
            return 0;
        }

        String[] words = text.split("");
        int counter = 0;

        for (String i: words){
            if (i.equals(" ")){
                continue;
            }
            counter++;
        }

        return counter;
    }

    public void findLongestWord(String text){
        String[] words = text.split(" ");
        int lenght = 0;

        //checks if text is empty
        if (text.isEmpty()){
            System.out.println("there is not any word inside text");
            return;
        }

        //checks for longest words lenght and remmebers the lgnt
        for (String i: words){
            if(i.length() >= lenght){
                lenght = i.length();
            }
        }

        //then find the same lenght and print it out
        for (String i: words){
            if(i.length() == lenght){
                System.out.println("longest word " + i);
            }
        }
    }

    public void countWordOccurences(String text, String word){
        String[] words = text.split(" ");
        int counter = 0;
        for (String i: words){
            if (i.toLowerCase().equals(word)){
                counter++;
            }
        }
        System.out.println(word + " occured in text " + counter + " times.");
    }

    public static void main(String[] args) {

        TextAnalyzer a = new TextAnalyzer(); //create object to us

        System.out.println("there are " + a.countWords("") + " words");                                   // 0 words
        System.out.println("there are " + a.countWords("Hello My Name is Ismayil") + " words");           // 5 words
        System.out.println("there are " + a.countCharacter("") + " chars");                               // 0 chars
        System.out.println("there are " + a.countCharacter("Hello My Name      is Ismayil") + " chars");  // 20 chars
        a.countWordOccurences(" ", "hello");                                                        // 0 times hello
        a.countWordOccurences("Helloooo Hello Hell hello Ismayil ", "hello");
        a.findLongestWord("Helloooo Hello Hell hello Ismayil ");
        a.findLongestWord("");
    }

}


