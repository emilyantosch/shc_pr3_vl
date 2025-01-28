package roemischzuganzzahl;

import java.util.Scanner;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        System.out.printf("Bitte die römische Zahl eingenben");
        Scanner input = new Scanner(System.in);
        String array = new String();

        int[] output = new int[10];
        array = input.next();
        int sum = 0;
        for(int i = 0; i<array.length();i++){
          output[i] = ganzzahl(array.charAt(i)) ;
          sum += output[i];
        }
        System.out.println(sum);

    }
    public static int ganzzahl(char r) {
        if(r == 'I' ){
            return 1;
        } else if (r == 'V') {
            return 5;
        } else if (r == 'X') {
            return 10;
        } else if (r == 'L') {
            return 50;
        } else if (r == 'C') {
            return 100;
        } else if (r == 'D') {
            return 100;
        }  else if (r == 'M') {
            return 1000;
        }
        return 0;
    }

}