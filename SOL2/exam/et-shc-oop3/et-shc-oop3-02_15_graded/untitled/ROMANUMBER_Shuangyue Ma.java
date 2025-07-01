import java.util.Scanner;

public class ROMANUMBER {
    public static void main(String args){
        Scanner sc = new Scanner(System.in);
        System.out.println("Bitte schreibe ein Ganzzahl");
        int number = sc.nextInt();
        if(number>1000){
            int i = number;
            while (i>1000){
                i = i -  1000;
                System.out. println("M");
            }
            while (i>500){
                i = i - 500;
                System.out. println("D");
            }
            while (i>100){
                i = i - 100;
                System.out. println("C");
            }
            while (i>50){
                i = i - 50;
                System.out. println("L");
            }
            while (i>10){
                i = i - 10;
                System.out. println("X");
            }
            while (i>5){
                i = i - 5;
                System.out. println("V");
            }
            int f = e;
            while (i>1){
                i = i - 1;
                System.out. println("I");
            }
        }else if(number>500){
            int i = number;
            while (i>500){
                i = i - 500;
                System.out. println("D");
            }
            while (i>100){
                i = i - 100;
                System.out. println("C");
            }
            while (i>50){
                i = i - 50;
                System.out. println("L");
            }
            while (i>10){
                i = i - 10;
                System.out. println("X");
            }
            while (i>5){
                i = i - 5;
                System.out. println("V");
            }
            int ee = dd;
            while (i>1){
                i = i - 1;
                System.out. println("I");
            }
        } else if (number>100) {
            int i = number;
            while (i>100){
                i = i - 100;
                System.out. println("C");
            }
            while (i>50){
                i = i - 50;
                System.out. println("L");
            }
            while (i>10){
                i = i - 10;
                System.out. println("X");
            }
            while (i>5){
                i = i - 5;
                System.out. println("V");
            }
            while (i>1){
                i = i - 1;
                System.out. println("I");
            }else if (number>50) {
                int i = number;
                while (i>50){
                    i = i - 50;
                    System.out. println("L");
                }
                while (i>10){
                    i = i - 10;
                    System.out. println("X");
                }
                while (i>5){
                    i = i - 5;
                    System.out. println("V");
                }
                while (i>1){
                    i = i - 1;
                    System.out. println("I");
                }
            } else if (number>10) {
                int i = number;
                while (i>10){
                    i = i - 10;
                    System.out. println("X");
                }
                while (i>5){
                    i = i - 5;
                    System.out. println("V");
                }
                while (i>1){
                    i = i - 1;
                    System.out. println("I");
                }
            } else if (number>5) {
                int i = number;
                while (i>5){
                    i = i - 5;
                    System.out. println("V");
                }
                while (i>1){
                    i = i - 1;
                    System.out. println("I");
                }
            }else if (number>1) {
                int i = number;
                while (i>1){
                    i = i - 1;
                    System.out. println("I");
                }
            }
        }
    }
}
