import java.io.*;
import java.lang.reflect.*;
import java.util.*;
import java.util.concurrent.*;

public class TestHarness {

    // Class name variants to try, in order
    private static final String[] CLASS_NAMES = {
        "TextAnalyzer", "TextAnalizer", "TextAnalyer", "TextDemo", "Text", "exam"
    };

    // Method name variants
    private static final String[][] COUNT_WORDS_NAMES = {{"countWords", "countWord"}};
    private static final String[][] COUNT_CHARS_NAMES = {{"countCharacters", "countCharacter"}};
    private static final String[][] LONGEST_WORD_NAMES = {{"findLongestWord", "longestWord", "findTheLongestWord"}};
    private static final String[][] COUNT_OCCURRENCES_NAMES = {{"countWordOccurrences", "countWordOccurences", "countWordOccurance"}};

    private static Class<?> targetClass;
    private static Object instance;
    private static String foundClassName;

    public static void main(String[] args) {
        // Discover class
        targetClass = discoverClass();
        if (targetClass == null) {
            System.out.println("CLASS=NOT_FOUND");
            return;
        }
        System.out.println("CLASS=" + foundClassName);

        // Create instance
        instance = createInstance(targetClass);

        // Test countWords
        testCountWords();

        // Test countCharacters
        testCountCharacters();

        // Test findLongestWord
        testFindLongestWord();

        // Test countWordOccurrences
        testCountWordOccurrences();

        // Check for main method
        checkMain();
    }

    private static Class<?> discoverClass() {
        for (String name : CLASS_NAMES) {
            try {
                Class<?> cls = Class.forName(name);
                if (name.equals("exam")) {
                    // Check for inner class exam$TextAnalyzer
                    try {
                        Class<?> inner = Class.forName("exam$TextAnalyzer");
                        if (hasAnyTargetMethod(inner)) {
                            foundClassName = "exam$TextAnalyzer";
                            return inner;
                        }
                    } catch (ClassNotFoundException ignored) {}
                }
                if (hasAnyTargetMethod(cls)) {
                    foundClassName = name;
                    return cls;
                }
            } catch (ClassNotFoundException ignored) {}
        }
        return null;
    }

    private static boolean hasAnyTargetMethod(Class<?> cls) {
        String[] allNames = {
            "countWords", "countWord",
            "countCharacters", "countCharacter",
            "findLongestWord", "longestWord", "findTheLongestWord",
            "countWordOccurrences", "countWordOccurences", "countWordOccurance"
        };
        for (Method m : cls.getDeclaredMethods()) {
            for (String name : allNames) {
                if (m.getName().equals(name)) return true;
            }
        }
        return false;
    }

    private static Object createInstance(Class<?> cls) {
        // Try no-arg constructor
        try {
            Constructor<?> c = cls.getDeclaredConstructor();
            c.setAccessible(true);
            return c.newInstance();
        } catch (Exception ignored) {}

        // Try (String) constructor
        try {
            Constructor<?> c = cls.getDeclaredConstructor(String.class);
            c.setAccessible(true);
            return c.newInstance("Hello world from Java");
        } catch (Exception ignored) {}

        // Try (String, String) constructor
        try {
            Constructor<?> c = cls.getDeclaredConstructor(String.class, String.class);
            c.setAccessible(true);
            return c.newInstance("Hello world from Java", "hello");
        } catch (Exception ignored) {}

        return null; // static-only class
    }

    private static Method findMethod(String[] nameVariants, Class<?>... paramTypes) {
        for (String name : nameVariants) {
            try {
                Method m = targetClass.getDeclaredMethod(name, paramTypes);
                m.setAccessible(true);
                return m;
            } catch (NoSuchMethodException ignored) {}
        }
        // Try with just String param if we were looking for no-arg
        if (paramTypes.length == 0) {
            for (String name : nameVariants) {
                try {
                    Method m = targetClass.getDeclaredMethod(name, String.class);
                    m.setAccessible(true);
                    return m;
                } catch (NoSuchMethodException ignored) {}
            }
        }
        return null;
    }

    private static Object invokeWithTimeout(Method method, Object[] invokeArgs) {
        ExecutorService executor = Executors.newSingleThreadExecutor();
        try {
            Future<Object> future = executor.submit(() -> {
                // Capture stdout
                PrintStream originalOut = System.out;
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                PrintStream capture = new PrintStream(baos);
                System.setOut(capture);
                try {
                    Object target = Modifier.isStatic(method.getModifiers()) ? null : instance;
                    Object result = method.invoke(target, invokeArgs);
                    System.out.flush();
                    System.setOut(originalOut);

                    if (result != null) {
                        return result;
                    }
                    // If void, check captured stdout
                    String output = baos.toString().trim();
                    if (!output.isEmpty()) {
                        return output;
                    }
                    return null;
                } catch (InvocationTargetException e) {
                    System.setOut(originalOut);
                    throw new RuntimeException(e.getCause());
                } finally {
                    System.setOut(originalOut);
                }
            });
            return future.get(5, TimeUnit.SECONDS);
        } catch (TimeoutException e) {
            return "TIMEOUT";
        } catch (Exception e) {
            return "ERROR:" + e.getMessage();
        } finally {
            executor.shutdownNow();
        }
    }

    private static String checkResult(Object result, Object expected) {
        if (result == null) return "FAIL(null)";
        if (result instanceof String && ((String) result).startsWith("TIMEOUT")) return "TIMEOUT";
        if (result instanceof String && ((String) result).startsWith("ERROR:")) return result.toString();

        String resultStr = result.toString().trim();

        if (expected instanceof Integer) {
            // Try parsing result as integer
            try {
                int actual = Integer.parseInt(resultStr);
                if (actual == (Integer) expected) return "PASS(" + actual + ")";
                return "FAIL(" + actual + ")";
            } catch (NumberFormatException e) {
                // Maybe it's embedded in output
                if (resultStr.contains(expected.toString())) return "PASS(" + expected + ")";
                return "FAIL(" + resultStr + ")";
            }
        } else if (expected instanceof String) {
            String exp = (String) expected;
            if (resultStr.equalsIgnoreCase(exp)) return "PASS(" + resultStr + ")";
            // For findLongestWord, check length match
            return "FAIL(" + resultStr + ")";
        }
        return "FAIL(" + resultStr + ")";
    }

    private static String checkLongestWord(Object result, String input) {
        if (result == null) return "FAIL(null)";
        if (result instanceof String && ((String) result).startsWith("TIMEOUT")) return "TIMEOUT";
        if (result instanceof String && ((String) result).startsWith("ERROR:")) return result.toString();

        String resultStr = result.toString().trim();
        // Find max word length in input
        String[] words = input.split("\\s+");
        int maxLen = 0;
        for (String w : words) {
            if (w.length() > maxLen) maxLen = w.length();
        }
        // Accept any word from input that has max length
        if (resultStr.length() == maxLen) {
            // Verify it's actually a word from the input
            for (String w : words) {
                if (w.equals(resultStr)) return "PASS(" + resultStr + ")";
            }
        }
        // Also accept case-insensitive match
        for (String w : words) {
            if (w.length() == maxLen && w.equalsIgnoreCase(resultStr)) return "PASS(" + resultStr + ")";
        }
        return "FAIL(" + resultStr + ")";
    }

    // === Test methods ===

    private static void testCountWords() {
        String[] names = {"countWords", "countWord"};
        Method m = findMethod(names, String.class);
        if (m == null) {
            // Try no-arg (might use instance field)
            m = findMethod(names);
        }
        if (m == null) {
            System.out.println("countWords: NOT_FOUND");
            return;
        }

        StringBuilder sb = new StringBuilder("countWords: FOUND | ");
        boolean takesString = false;
        for (Class<?> p : m.getParameterTypes()) {
            if (p == String.class) { takesString = true; break; }
        }

        if (takesString) {
            Object r1 = invokeWithTimeout(m, new Object[]{"Hello world from Java"});
            sb.append("test1=").append(checkResult(r1, 4));

            Object r2 = invokeWithTimeout(m, new Object[]{""});
            sb.append(" test2=").append(checkResult(r2, 0));

            Object r3 = invokeWithTimeout(m, new Object[]{"single"});
            sb.append(" test3=").append(checkResult(r3, 1));
        } else {
            // No-arg: need to reconstruct instance with the test string
            sb.append("test1=SKIP(no-string-param)");
            sb.append(" test2=SKIP(no-string-param)");
            sb.append(" test3=SKIP(no-string-param)");
        }
        System.out.println(sb.toString());
    }

    private static void testCountCharacters() {
        String[] names = {"countCharacters", "countCharacter"};
        Method m = findMethod(names, String.class);
        if (m == null) m = findMethod(names);
        if (m == null) {
            System.out.println("countCharacters: NOT_FOUND");
            return;
        }

        StringBuilder sb = new StringBuilder("countCharacters: FOUND | ");
        boolean takesString = false;
        for (Class<?> p : m.getParameterTypes()) {
            if (p == String.class) { takesString = true; break; }
        }

        if (takesString) {
            Object r1 = invokeWithTimeout(m, new Object[]{"Hello world"});
            sb.append("test1=").append(checkResult(r1, 10));

            Object r2 = invokeWithTimeout(m, new Object[]{""});
            sb.append(" test2=").append(checkResult(r2, 0));
        } else {
            sb.append("test1=SKIP(no-string-param)");
            sb.append(" test2=SKIP(no-string-param)");
        }
        System.out.println(sb.toString());
    }

    private static void testFindLongestWord() {
        String[] names = {"findLongestWord", "longestWord", "findTheLongestWord"};
        Method m = findMethod(names, String.class);
        if (m == null) m = findMethod(names);
        if (m == null) {
            System.out.println("findLongestWord: NOT_FOUND");
            return;
        }

        StringBuilder sb = new StringBuilder("findLongestWord: FOUND | ");
        boolean takesString = false;
        for (Class<?> p : m.getParameterTypes()) {
            if (p == String.class) { takesString = true; break; }
        }

        if (takesString) {
            Object r1 = invokeWithTimeout(m, new Object[]{"I am a student"});
            sb.append("test1=").append(checkLongestWord(r1, "I am a student"));

            Object r2 = invokeWithTimeout(m, new Object[]{"a bb ccc"});
            sb.append(" test2=").append(checkLongestWord(r2, "a bb ccc"));
        } else {
            sb.append("test1=SKIP(no-string-param)");
            sb.append(" test2=SKIP(no-string-param)");
        }
        System.out.println(sb.toString());
    }

    private static void testCountWordOccurrences() {
        String[] names = {"countWordOccurrences", "countWordOccurences", "countWordOccurance"};
        Method m = findMethod(names, String.class, String.class);
        if (m == null) {
            // Try single string param (might use instance field for text)
            m = findMethod(names, String.class);
        }
        if (m == null) m = findMethod(names);
        if (m == null) {
            System.out.println("countWordOccurrences: NOT_FOUND");
            return;
        }

        StringBuilder sb = new StringBuilder("countWordOccurrences: FOUND | ");
        int paramCount = m.getParameterCount();

        if (paramCount == 2) {
            Object r1 = invokeWithTimeout(m, new Object[]{"Hello hello HELLO world", "hello"});
            sb.append("test1=").append(checkResult(r1, 3));

            Object r2 = invokeWithTimeout(m, new Object[]{"Hello world", "missing"});
            sb.append(" test2=").append(checkResult(r2, 0));
        } else if (paramCount == 1) {
            // Single param - probably just the word to search, text is in instance
            sb.append("test1=SKIP(single-param)");
            sb.append(" test2=SKIP(single-param)");
        } else {
            sb.append("test1=SKIP(no-params)");
            sb.append(" test2=SKIP(no-params)");
        }
        System.out.println(sb.toString());
    }

    private static void checkMain() {
        try {
            Method m = targetClass.getDeclaredMethod("main", String[].class);
            System.out.println("main: FOUND");
        } catch (NoSuchMethodException e) {
            System.out.println("main: NOT_FOUND");
        }
    }
}
