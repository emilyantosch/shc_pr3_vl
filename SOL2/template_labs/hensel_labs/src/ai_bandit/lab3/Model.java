package ai_bandit.lab3;

import ai_bandit.lab2.MultiBandit;
import ai_bandit.lab2.MultiBanditSolver;

import java.util.ArrayList;
import java.util.Arrays;

public class Model {
    private final MultiBandit multiBandit;
    private final MultiBanditSolver solver;
    private final ArrayList<Double> moneyHistory = new ArrayList<>();
    private int[] banditSelectedCounts;

    public Model(int numberBandits) {
        // Init multi-armed bandit and selection strategy
        multiBandit = new MultiBandit(numberBandits);
        solver = new MultiBanditSolver(multiBandit);

        // Init data history
        banditSelectedCounts = new int[multiBandit.getNumberBandits()];
        resetHistory();
    }

    public MultiBanditSolver getSolver() {
        return solver;
    }

    public ArrayList<Double> getMoneyHistory() {
        return moneyHistory;
    }

    public int[] getBanditSelectedCounts() {
        return banditSelectedCounts;
    }

    public void resetHistory() {
        Arrays.fill(banditSelectedCounts, 0);
        moneyHistory.clear();
        moneyHistory.add(10.0);
    }

    public void play(boolean isGreedy) {
        // Select bandit and play
        int banditIndex = (isGreedy) ? solver.chooseGreedy() : solver.chooseRandom();
        double win = multiBandit.play(banditIndex);

        // Update statistics
        double availableMoney = moneyHistory.get(moneyHistory.size() - 1);
        moneyHistory.add(availableMoney - multiBandit.getPricePerRound() + win);
        banditSelectedCounts[banditIndex]++;
        solver.addBanditResponse(banditIndex, win);
    }
}
