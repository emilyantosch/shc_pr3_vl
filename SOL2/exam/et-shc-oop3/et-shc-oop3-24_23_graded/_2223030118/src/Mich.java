public class Mich {
    private String name;
    private long matrikelnummer;

    public Mich(){

    }
    public Mich(String name, long matrikelnummer) {
        this.name = name;
        this.matrikelnummer = matrikelnummer;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getMatrikelnummer() {
        return matrikelnummer;
    }

    public void setMatrikelnummer(long matrikelnummer) {
        this.matrikelnummer = matrikelnummer;
    }
}
