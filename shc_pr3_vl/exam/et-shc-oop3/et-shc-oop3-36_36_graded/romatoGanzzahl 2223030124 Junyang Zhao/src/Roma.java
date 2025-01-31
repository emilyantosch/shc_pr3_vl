import java.util.HashMap;

import static jdk.xml.internal.JdkXmlUtils.getValue;

public class Roma {
    public static int romaToGanzahl(String s){
        int total = 0;
        int preValue = 0;

        for (int i = s.length() - 1; i >= 0; i--){
            char currentChar = s.charAt(i);
            int currentValue = getValue(currentChar);

            if(currentValue < preValue){
                total-=currentValue;
            }else{total += currentValue;
    } preValue = currentValue;
}return total;
    }
}
public static int getValue(char romanChar) {
    switch (romanChar) {
        case 'I':
            return 1;
        case 'V':
            return 5;
        case 'X':
            return 10;
        case 'L':
            return 50;
        case 'C':
            return 100;
        case 'D':
            return 500;
        case 'M':
            return 1000;
        default:
        System.out.println("not a romanumber");

    }

}
public static void main(String[] args) {
    
}
