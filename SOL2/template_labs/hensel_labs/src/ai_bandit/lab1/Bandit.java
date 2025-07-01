package ai_bandit.lab1;

import java.util.Random;

/** One-armed bandit (slot machine).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.05.24<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class Bandit {
    static final private Random random = new Random();  // Random number generator
    private final String name;              // Bandit's name
    private final double pricePerRound;     // Money to pay to play one round
    private final double averageWin;        // Statistical average when determining the amount of money won
    private final double stdDevWin;         // Statistical standard deviation when determining the amount of money won
    private double overallProfit = 0.0;     // Overall money earned or lost in all rounds
    private int roundsPlayed = 0;           // Number of rounds played

    /** Constructor accepting a custom name.
     *
     * @param name Slot machine's name
     * @param pricePerRound Amount of money to pay to play a round (e.g., in EUR)
     * @param averageWin Statistical average when determining the amount of money won
     * @param stdDevWin Statistical standard deviation when determining the amount of money won
     */
    public Bandit(String name, double pricePerRound, double averageWin, double stdDevWin) {
        this.name = name;
        this.pricePerRound = pricePerRound;
        this.averageWin = averageWin;
        this.stdDevWin = stdDevWin;
    }

    /** Constructor setting a default name ("One-armed bandit").
     *
     * @param pricePerRound Amount of money to pay to play a round (e.g., in EUR)
     * @param averageWin Statistical average when determining the amount of money won
     * @param stdDevWin Statistical standard deviation when determining the amount of money won
     */
    public Bandit(double pricePerRound, double averageWin, double stdDevWin) {
        this("One-armed bandit", pricePerRound, averageWin, stdDevWin);
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

    /** Get overall money earned or lost by the bandit in all rounds played.
     *
     * @return summed up win or loss (e.g., in EUR)
     */
    public double getOverallProfit() {
        return overallProfit;
    }

    /** Get average money earned or lost by the bandit per round.
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
     * The method determines the amount of money the player wins in this round by calling determineWin().
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

    /** Determine the amount of money a player wins for a concrete round.<br><br>
     *
     * The win is determined randomly by the Gaussian distribution with mean and standard deviation
     * according to the object's attributes averageWin and stdDevWin. The random win returned is forced to be
     * non-negative (>= 0.0) and rounded to multiples of 10 Cents (e.g., 0.70 EUR instead of 0.71 EUR).
     *
     * @return the amount of money won
     */
    private double determineWin() {
        // Determine random win by Gaussian distribution
        double randomWin = random.nextGaussian() * stdDevWin + averageWin;

        // Force win to be non-negative and round to multiple of 10 Cents
        randomWin = Math.max(randomWin, 0.0);
        return Math.round(10.0 * randomWin) / 10.0;
    }
}
