package ai_bandit.lab2;

import java.util.Random;

/** Selection strategies for multi-armed bandits (random, epsilon-greedy).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.03.16<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class MultiBanditSolver {
    static private final Random random = new Random();
    private final MultiBandit bandits;      // Multi-armed bandit to play
    private int[] counts;                   // Counts how often each one-armed bandit has been chosen
    private double[] wins;                  // Summed up wins for each one-armed bandit
    private double epsilon;                 // Epsilon in [0,1) for epsilon-greedy strategy

    /** Contructor.
     *
     * @param bandits Multi-armed bandit to play.
     */
    public MultiBanditSolver(MultiBandit bandits) {
        this.bandits = bandits;

        // Init bandits win statistics
        counts = new int[bandits.getNumberBandits()];
        wins = new double[bandits.getNumberBandits()];
    }

    /** Set the epsilon parameter for the epsilon-greedy strategy.
     *
      * @param epsilon Epsilon in [0,1)
     */
    public void setGreedyEpsilon(double epsilon) {
        this.epsilon = epsilon;
    }

    /** Add a chosen bandit and its returned win to the internal statistics.
     *
     * @param banditIndex Index of one-armed bandit within multi-armed bandit in [0, number bandits - 1]
     * @param win Win returned by the chosen one-armed bandit (e.g., in EUR)
     */
    public void addBanditResponse(int banditIndex, double win) {
        counts[banditIndex]++;
        wins[banditIndex] += win;
    }

    /** Get the average amount of money returned by a bandit so far.
     *
     * @param banditIndex Bandit index in [0, number bandits - 1]
     * @return (sum of all wins) / (number games played) or 0.0 for the bandit
     */
    public double getAverageWin(int banditIndex) {
        return (counts[banditIndex] > 0) ? wins[banditIndex] / counts[banditIndex] : 0.0;
    }

    /** Select the next bandit to play randomly.<br><br>
     *
     * The probability to be chosen is the same for each bandit.
     *
     * @return random index in [0, number bandits - 1]
     */
    public int chooseRandom() {
        return random.nextInt(bandits.getNumberBandits());
    }

    /** Select the next bandit to play by the epsilon-greedy strategy.<br><br>
     *
     * The strategy selects the bandit randomly with a probability of epsilon (i.e., "exploration" of bandits).
     * Else (i.e., with a probability 1 - epsilon) it selects the bandit which has generated the highest average win
     * so far (i.e., "exploitation" of currently assumed best bandit).
     *
     * @return chosen bandit index
     */
    public int chooseGreedy() {
        int banditIndex = 0;

        if (random.nextDouble() > epsilon) {
            // Choose the bandit with the highest average win ("exploitation")
            double maxAverageWin = -1e10;

            for (int i = 0; i < bandits.getNumberBandits(); i++) {
                double averageWin = getAverageWin(i);
                if (averageWin > maxAverageWin) {
                    maxAverageWin = averageWin;
                    banditIndex = i;
                }
            }
        } else {
            // Choose random bandit ("exploration")
            banditIndex = chooseRandom();
        }

        return banditIndex;
    }
}
