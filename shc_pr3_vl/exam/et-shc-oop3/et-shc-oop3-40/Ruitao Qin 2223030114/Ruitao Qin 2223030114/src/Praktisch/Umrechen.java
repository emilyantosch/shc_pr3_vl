package Praktisch;

public class Umrechen extends RömischZiffern{
    private int b;

    public  Umrechen(int b) {
        this.b = b;

    }

    public int getB() {
        return b;
    }

    public void setB(int b) {
        this.b = b;
    }

    public String romanzahl(int zahl){
        if(zahl>5)


    }

    public String unbrechen(int b){
        this.b=b;
        int a = b % 10;
        int c = b / 10;
        String romischzahl1;

        while(a !=0 ||b!=0){
            switch (a){
                case 1:
                    romischzahl1=I;
                     break;
                case 5:
                    romischzahl1=V;
                    break;

                default:

            }

        }
    }
}
