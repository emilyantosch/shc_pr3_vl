import java.util.HashMap;
import java.util.Map;

public class RomanToInteger{
    public static int RomanToInt(String s){
        Map<Character, Integer> romanMap = new HashMap<>();
        romanMap.put('I',1);
        romanMap.put('V',5);
        romanMap.put('X',10);
        romanMap.put('L',50);
        romanMap.put('C',100);
        romanMap.put('D',500);
        romanMap.put('M',1000);

        int result = 0;
        int prevValue = 0;

        for (int i = s.length()-1; i >= 0; i--) {
            char currentChar = s.charAt(i);
            int curentValue = romanMap.get(currentChar);

            if (curentValue < prevValue) {
                result -= curentValue;
            } else {
                result += curentValue;
            }

            prevValue = curentValue;
        }

        return result;
    }

    public static void main(String[] args){
        System.out.println("IV" + RomanToInt("IV"));
        System.out.println("XII" + RomanToInt("XII"));
        System.out.println("XXVII" + RomanToInt("XXVII"));
        System.out.println("MCMXCIV" + RomanToInt("MCMXCIV"));
    }
}