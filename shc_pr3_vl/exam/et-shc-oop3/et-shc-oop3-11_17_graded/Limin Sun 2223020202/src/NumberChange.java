import java.util.Scanner;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class NumberChange {
    public static void main(String[] args) {
        public int neuZahl;
        Scanner scanner = new Scanner(System.in);

        System.out.println("Geben Sie ein Zahl: ");
        String Zahl= scanner.next();
        scanner.close();



        if (Zahl < 4 && Zahl >0) {
            neuZahl=Zahl*"I";
            System.out.println(neuZahl);
        } else if (Zahl == 4 ) {
            System.out.println("IV");
        } else if (Zahl == 5 ) {
            System.out.println("V");
        } else if (Zahl == 10 ) {
            System.out.println("X");
        } else if (Zahl == 50 ) {
            System.out.println("L");
        } else if (Zahl == 100 ) {
            System.out.println("C");
        } else if (Zahl == 500 ) {
            System.out.println("D");
        }
        System.out.println("Das Römische Zahl ist: "+neuzahl);
    }
}