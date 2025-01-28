//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        ChangE C1 = new ChangE(1234);
        System.out.println(C1.nummer + " is made by");
        C1.change(C1.nummer);

    }
}

class ChangE {
    String wert;
    int nummer;
    private String NAme = "Yijie Zhang";//2223030221

    public ChangE(int nummer) {
        this.wert = wert;
        this.nummer = nummer;
    }

    public void change(int a) {
        for (int i = 1; i <= 10; i++) {
            if (a >= 1000 && a != 9999) {
                a = a - 1000;
                System.out.println("M");
            } else if (a == 9999) {
                System.out.println("WEIss NICHT");
                a =0;
            } else {
                break;
            }


            for (i = 1; i <= 10; i++) {
                if (a >= 500 && a != 999) {
                    a = a - 500;
                    System.out.println("D");
                } else if (a == 999) {
                    System.out.println("IM");
                    a =0;
                } else {
                    break;
                }
            }
            for (i = 1; i <= 10; i++) {
                if (a >= 100 && a != 499) {
                    a = a - 100;
                    System.out.println("C");
                } else if (a == 499) {
                    System.out.println("ID");
                    a =0;
                } else {
                    break;
                }
            }
            for (i = 1; i <= 10; i++) {
                if (a >= 50 && a != 99) {
                    a = a - 50;
                    System.out.println("L");
                } else if (a == 99) {
                    System.out.println("IC");
                    a =0;
                } else {
                    break;
                }
            }
            for (i = 1; i <= 10; i++) {
                if (a >= 10 && a != 49) {
                    a = a - 10;
                    System.out.println("X");
                } else if (a == 49) {
                    System.out.println("IL");
                    a =0;
                } else {
                    break;
                }
            }
            for (i = 1; i <= 10; i++) {
                if (a >= 5 && a != 9) {
                    a = a - 5;
                    System.out.println("V");
                } else if (a == 9) {
                    System.out.println("IX");
                    a =0;
                } else {
                    break;
                }
            }

            if (a == 4) {
                System.out.println("IV");
            } else if (a == 3) {
                System.out.println("III");
            }
            if (a == 2) {
                System.out.println("II");
            }
            if (a == 1) {
                System.out.println("I");
            }


        }
    }
}