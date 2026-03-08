
public class TextAnalyzer {
  public String text = "hello aew";

  public void setText(String text) {
    this.text = text;
  }

  int countWords(String text) {
    String[] words = text.split(" ");
    System.out.println("number of words: " + words.length);
    return words.length;
  }

  int countCharacters(String text) {
    String newtext = text.replace(" ", "");

    System.out.println("number of chars: " + newtext.length());
    return newtext.length();
  }

  String findLongestWord(String text) {
    String[] words = text.split(" ");
    String longestWord = "";
    for (int i = 0; i < words.length; i++) {

      if (words[i].length() > words[i++].length())
        longestWord = words[i];
      else {
        longestWord = words[i + 1];
      }

    }
    return longestWord;
  }

  int countWordOccurences(String text, String word) {

  }

}
