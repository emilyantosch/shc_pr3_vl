//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        String s = "Hallo";
        int n = s.charAt(0);

        for (int i = 0; i <5 ; i++) {
            //while(true)
            int a = 0;
            if (n >= 100){
                a = n / 100;
                n = n % 100;
            } else if (n >= 50) {
                a = n / 50;
                n = n % 50;
            }else if (n >= 10) {
                a = n / 10;
                n = n % 10;
            }else if (n >= 5) {
                a = n / 5;
                n = n % 5;
            }else if (n >= 1) {
                a = n / 1;
                n = n % 1;
            }
            

            switch (a){
                    case 1 :
                        System.out.println("I");
                        break;
                    case 5 :
                        System.out.println("V");
                        break;
                    case 10 :
                        System.out.println("X");
                        break;
                    case 50 :
                        System.out.println("L");
                        break;
                    case 100 :
                        System.out.println("C");
                        break;
                    case 500 :
                        System.out.println("D");
                        break;
                    case 1000 :
                        System.out.println("M");
                        break;
            }
        }


        //TIP Press <shortcut actionId="ShowIntentionActions"/> with your caret at the highlighted text
        // to see how IntelliJ IDEA suggests fixing it.

        System.out.println("Buchstabe an der ersten Stelle von " + s + " ist " +
                s.charAt(0) + ".");

    }

}