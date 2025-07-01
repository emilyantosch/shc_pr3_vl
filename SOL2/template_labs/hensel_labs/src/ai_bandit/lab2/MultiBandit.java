package ai_bandit.lab2;

import java.util.Random;

/** Multi-armed bandit consisting of N one-armed bandit (slot machines).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.03.06<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class MultiBandit {
    final private Bandit[] bandits;

    /** Constructor initializing one bandit to win, the others to lose money in the long run.
     *
     * @param numberBandits Number of slot machines in the set
     */
    public MultiBandit(int numberBandits) {
        bandits = new Bandit[numberBandits];

        // Init randomly one slot machine to win, the others to lose money in the long run
        Random random = new Random();
        int winBanditIndex = random.nextInt(numberBandits);

        for (int i = 0; i < numberBandits; i++) {
            String name = String.format("Bandit %d", i + 1);
            double averageWin;

            if (i == winBanditIndex)
                averageWin = random.nextDouble(1.1, 1.3);
            else
                averageWin = random.nextDouble(0.5, 0.8);
            bandits[i] = new Bandit(name, 1.0, averageWin, 1.0);
        }
    }

    /** Get number of bandits.
     *
     * @return number of bandits
     */
    public int getNumberBandits() {
        return bandits.length;
    }

    /** Get money to pay to play a game.
     *
     * @return price to play a game (e.g., in EUR)
     */
    public double getPricePerRound() {
        return bandits[0].getPricePerRound();
    }

    /** Get overall money earned or lost in all rounds played by all bandits.
     *
     * @return summed up win or loss (e.g., in EUR)
     */
    public double getOverallProfit() {
        double overallProfit = 0.0;

        for (Bandit bandit : bandits) {
            overallProfit += bandit.getOverallProfit();
        }

        return overallProfit;
    }

    /** Get average money earned or lost by the bandits per round.
     *
     * @return average profit (or 0.0 if no round has been played so far)
     */
    public double getMeanProfitPerRound() {
        double overallProfit = getOverallProfit();
        int roundsPlayed = getRoundsPlayed();

        if (roundsPlayed > 0)
            return overallProfit / roundsPlayed;
        else
            return 0.0;
    }

    /** Get the overall number of rounds played.
     *
     * @return number of rounds played since instantiation
     */
    public int getRoundsPlayed() {
        int roundsPlayed = 0;

        for (Bandit bandit : bandits) {
            roundsPlayed += bandit.getRoundsPlayed();
        }

        return roundsPlayed;
    }

    /** Play a round with a specific bandit of the set.<br><br>
     *
     * @param banditIndex Bandit to play with in [0, numberBandits - 1]
     * @return the amount of money the player gets back in this round
     */
    public double play(int banditIndex) {
        return bandits[banditIndex].play();
    }
}
