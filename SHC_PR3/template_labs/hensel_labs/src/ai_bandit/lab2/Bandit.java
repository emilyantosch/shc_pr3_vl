package ai_bandit.lab2;

/** One-armed bandit (slot machine) as concrete gambling class.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.05.24<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class Bandit extends Gambling {
    // Wining chances
    private final double averageWin;    // Statistical average when determining the amount of money won
    private final double stdDevWin;     // Statistical standard deviation when determining the amount of money won

    /** Constructor accepting a custom name.
     *
     * @param name Slot machine's name
     * @param pricePerRound Amount of money to pay to play a round (e.g., in EUR)
     * @param averageWin Statistical average when determining the amount of money won
     * @param stdDevWin Statistical standard deviation when determining the amount of money won
     */
    public Bandit(String name, double pricePerRound, double averageWin, double stdDevWin) {
        super(name, pricePerRound);
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
    
    /** Determine the amount of money a player wins for a concrete round.<br><br>
     *
     * The win is determined randomly by the Gaussian distribution with mean and standard deviation
     * according to the object's attributes averageWin and stdDevWin. The random win returned is forced to be
     * non-negative (>= 0.0) and rounded to multiples of 10 Cents (e.g., 0.70 EUR instead of 0.71 EUR).
     *
     * @return the amount of money won
     */
    @Override
    protected double determineWin() {
        // Determine random win by Gaussian distribution
        double randomWin = random.nextGaussian() * stdDevWin + averageWin;

        // Force win to be non-negative and round to multiple of 10 Cents
        randomWin = Math.max(randomWin, 0.0);
        return Math.round(10.0 * randomWin) / 10.0;
    }
}
