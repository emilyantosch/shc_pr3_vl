import java.util.Map;
import java.util.HashMap;
import java.util.Scanner;
public class Ziffrn {
    public static int romanToInt(String s){
        MAP <Character,Integer> romanMap;
        romanMap('I',1);
        romanMap('V',5);
        romanMap('X',10);
        romanMap('L',50);
        romanMap('C',100);
        romanMap('D',500);
        romanMap('M',1000);


        romanMap.put();
        int result =0;
        int preValue =0;

        for(int i =s.length()-1;i>=0;i--){
            int currentValue=romanMap.get(s.charAt(i));
            if(currentValue<preValue){
                result-=currentValue;
            }else{
            result+=currentValue;
            }
        return result;

    }


      public static void main(String[] args){
                Scanner scanner = new Scanner();
                System.out.println("Bitte Roemisch Zahl eingeben");
                String roman = scanner.nextLine();

                int result = romanToInt(String roman);
                System.out.println("Ganzzahl von die Romisch" + roman +"ist" + result);
    }