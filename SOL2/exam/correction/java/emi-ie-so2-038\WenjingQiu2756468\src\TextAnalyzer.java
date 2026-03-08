import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class TextAnalyzer {

  public int countWords(String text) {
    String[] words = text.split(" ");

    return words.length;
  }

  public int countCharacters(String text) {
    return text.length();
  }

  public String findLongestWord(String text) {
    String longestWord = "";

    String[] words = text.split(" ");

    for (String item : words) {
      if (item.length() >= longestWord.length()) {
        longestWord = item;
      }
    }

    return longestWord;
  }

  public int CountWordOccurences(String text, String word) {
    int count = 0;

    String[] words = text.split(" ");

    for (String item : words) {
      if (item.equalsIgnoreCase(word))
        count++;
    }

    return count;
  }

  public boolean isNotEmpty(String text) {
    int count = text.length();

    if (count > 0) {
      return true;
    } else {
      System.out.println("There is no text to analyze");
      return false;
    }
  }

}
