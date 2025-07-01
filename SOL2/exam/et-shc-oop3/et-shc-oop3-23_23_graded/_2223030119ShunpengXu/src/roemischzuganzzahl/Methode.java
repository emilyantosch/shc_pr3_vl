package roemischzuganzzahl;

public class Methode {
    String input;
    private int sum;
    public Methode() {
    }

    public void setInput(String input) {
        this.input = input;
    }
    public int ganzzahl(char r) {
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
    public void sum(String array, int[] output){
        for(int i = 0; i<array.length();i++){
            output[i] = ganzzahl(array.charAt(i)) ;
            sum += output[i];
        }
        System.out.println(sum);
    }
    public String getInput() {
        return input;
    }
}
