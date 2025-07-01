package ai_bandit.lab3;

public class App {
    /** Application starting point.
     *
     * @param args Arguments (not used)
     */
    public static void main(String[] args) throws InterruptedException {
        int numberBandits = 7;
        double epsilon = 0.15;

        Model model = new Model(numberBandits);
        GraphicalUI gui = new GraphicalUI(model);
        model.getSolver().setGreedyEpsilon(epsilon);
    }
}
