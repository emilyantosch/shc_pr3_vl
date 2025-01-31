//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.


import java.util.Scanner;

class Praktischer {
    String S;
    public int getZahl(char A){
        switch(A){
            case 'I':return 1;
            break;
            case 'V':return 5;
            break;
            case 'X':return 10;
            break;
            case 'L':return 50;
            break;
            case 'C':return 100;
            break;
            case 'D':return 500;
            break;
            case 'M':return 1000;
            break;
        }

        public int getTOTALZahl(String A){
            int size = A.length();
            for(int i=0;i<size;i ++){
                int totalZahl;
                int Zahl = getZahl(A.char(i));
                totalZahl +=Zahl;
                return totalZahl;





            }

        }
    }
    }
    public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);


    while(true){

         System.out.
        String A = scanner.nextLine();

    }
        //TIP Press <shortcut actionId="ShowIntentionActions"/> with your caret at the highlighted text
        // to see how IntelliJ IDEA suggests fixing it.



    }
