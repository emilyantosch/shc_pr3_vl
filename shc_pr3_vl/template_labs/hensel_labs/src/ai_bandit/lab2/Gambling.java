package ai_bandit.lab2;

import java.util.Random;

/** Base class for gambling (such as one-armed bandits).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.03.06<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public abstract class Gambling {
    static protected Random random = new Random();  // Random number generator (which can be used by concrete subclasses)
    private final String name;
    private final double pricePerRound;             // Money to pay to play one round
    private double overallProfit = 0.0;             // Overall money earned or lost in all rounds
    private int roundsPlayed = 0;                   // Number of rounds played

    /** Constructor.
     *
     * @param name Game's name
     * @param pricePerRound Amount of money to pay to play a round (e.g., in EUR)
     */
    public Gambling(String name, double pricePerRound) {
        this.name = name;
        this.pricePerRound = pricePerRound;
    }

    /** Get the game's name.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /** Get money to pay to play a game.
     *
     * @return price to play a game (e.g., in EUR)
     */
    public double getPricePerRound() {
        return pricePerRound;
    }

    /** Get overall money earned or lost by the Gambling in all rounds played.
     *
     * @return summed up win or loss (e.g., in EUR)
     */
    public double getOverallProfit() {
        return overallProfit;
    }

    /** Get average money earned or lost by the Gambling per round.
     *
     * @return average profit (or 0.0 if no round has been played so far)
     */
    public double getMeanProfitPerRound() {
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
        return roundsPlayed;
    }

    /** Play a round of the game.<br><br>
     *
     * The method determines the amount of money the player wins in this round by calling determineWin(),
     * which has to be implemented by concrete subclasses.
     *
     * @return the amount of money the player gets back in this round
     */
     public double play() {
         // Determine the amount of money won by the play
         double win = determineWin();

         // Adapt statistics on the game's overall performance
         overallProfit += (pricePerRound - win);
         roundsPlayed++;

         return win;
     }

    /** Determine the amount of money a player wins for a concrete round.
     *
     * @return the amount of money won
     */
    abstract protected double determineWin();
}
