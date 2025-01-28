
public class Main{
    public static int main(String[] args) {

    String s;
        public static int getValue (char c){
                switch (c){
            case'I': return 1;
            case'V': return 5;
            case'X': return 10;
            case'L': return 50;
            case'C': return 100;
            case'D': return 500;
            case'M': return 1000;
        }
        public static int umrechnen (String s){
                int result = 0;
                int current;
                int i;
                for (i = 0; i < s.length(); i++) {
                    int current <getValue(s.charAt(i));
                }

                if (i < s.length() - 1 && current < getValue(s.charAt(i)) {
                    result = current;
                }
                    else{
                    result += current;
                }
                return result;
            }
            scanner s;
                s.getValue();
            System.out.println(result);
    }
