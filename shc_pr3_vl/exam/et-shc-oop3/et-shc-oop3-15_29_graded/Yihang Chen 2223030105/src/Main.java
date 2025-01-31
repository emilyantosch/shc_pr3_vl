public class Symbolen{
    public staticint romanzahl(String s){
        Hashmap <Character,Integer> romanMap= new Hashmap<>();
        romanMap.put('I',1);
        romanMap.put('V',5);
        romanMap.put('X',10);
        romanMap.put('L',50);
        romanMap.put('C',100);
        romanMap.put('D',500);
        romanMap.put('M',1000);
        int total=0;
        int prevalue=0;
    }
    for (int i =s.length;i >=0;i++){
        char currentchar=s.charAt(s);
        int currentvalue= romanMap.get(currentchar);

        if(currentvalue<prevalue){
            total -=currentvalue;
        }
        else{
            total+=currentvalue;
        }
       prevalue= currentvalue;

    }

    return total;
}




public class Main {
    public static void main(String[] args) {
    Symbolen s = new Symbolen("IV");
            System.out.println("IV" + s);
        }
    }
