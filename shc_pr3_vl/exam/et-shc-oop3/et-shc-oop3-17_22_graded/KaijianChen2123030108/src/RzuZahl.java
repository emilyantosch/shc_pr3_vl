import java.util.Scanner;

class Roemischzahl {
    public String roemisch;

    int umwandlung(String roemisch){
        int endzahl=0;
        int zahl1=0;
        char[] roemisch1={0};
        for(int i=0; i<10;i++){
            if(roemisch.charAt(i).equals(null)){//endschleife wenn keine weitere Roemischwort
                break;
                zahl1=i;
            }
            roemisch1[i] = roemisch.charAt(i);
        }
        for(int i=0;i<zahl1;i++){
            switch(roemisch1[i]){
                case'I':
                    break;
                case'X'
            }
        }
        return endzahl;
    }
}

public class RzuZahl {
    public static void main(String[] args) {
        System.out.println("Bitte eingaben ein Roemischwert");
        String input=scanner.nextString();
        scanner.nextLine();
        System.out.println("Ganzzahl beim Umwandlung ist:"+ Roemischzahl.umwandlung(input));
    }
    scanner.close();
}
