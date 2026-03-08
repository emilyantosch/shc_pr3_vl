public class TextAnalyzer {

  public int countWords(String text) {
    if (text == null) {
      return 0;
    }
    text = text.trim();
    if (text.isEmpty()) {
      return 0;
    }
    String[] words = text.split("\\s+ ");
    return words.length;
  }

  public int countCharacters(String text) {
    if (text == null) {
      return 0;
    }
    String noSpaces = text.replace(" ", "");
    return noSpaces.length();
  }

  public int findLongestWord(String text) {
    if (text == null) {
      return 0;
    }
    text = text.trim();
    if (text.isEmpty()) {
      return 0;
    }
    String[] words = text.split("\\s+ ");
    String longest = words[0];
    for (int i = 1; i < words.length; i++) {
      if (words[i].length() > longest.length()) {
        longest = words[i];
      }
    }
    return longest;

  }

  public int countWordsOccurences(String text, String word) {
    if (text == null || word == null) {
      return 0;
    }
    text = text.trim();
    word = word.trim();
    if (text.isEmpty() || word.isEmpty()) {
      return 0;
    }
    String lowerText = text.toLowerCase();
    String lowerWord = word.toLowerCase();
    String[] words = lowerText.split("\\s+ ");
    int count = 0;
    for (String w : words) {
      if (w.equals(lowerword)) {
        count++;
      }
    }
    return count;
  }

}
