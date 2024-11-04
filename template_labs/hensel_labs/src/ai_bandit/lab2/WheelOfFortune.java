package ai_bandit.lab2;

/** Wheel of fortune as concrete gambling class.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.03.06<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class WheelOfFortune extends Gambling {
    private int numberFields;                   // Number of fields (each with a specific category on it)
    private final double[] categoryWins;        // Amount of money won for each category
    private final double[] categoryChances;     // Chances in percent/100.0 to get each category when playing

    /** Constructor.<br><br>
     *
     * The array arguments must have the same length, where values with the same index correspond to the same category
     * printed on the wheel of fortune, e.g.: Arguments {20, 5} and {0.5, 2.0} mean that the wheel contains 20 fields
     * "You win 0.50 EUR" and 5 fields "You win 2.00 EUR".
     *
     * @param pricePerRound Amount of money to pay to play a round (e.g., in EUR)
     * @param categoryNumberFields Number of fields existing on the wheel for each category
     * @param categoryWins Corresponding money won for each category
     */
    public WheelOfFortune(double pricePerRound, int[] categoryNumberFields, double[] categoryWins) {
        super("Wheel of fortune", pricePerRound);

        // Check arguments
        if (categoryWins.length != categoryNumberFields.length)
            throw new RuntimeException("Array lengths representing number of categories are not the same.");

        // Set amount of money won for each category
        this.categoryWins = categoryWins.clone();

        // Determine chance to get a specific category when playing
        int numberCategories = categoryWins.length;

        numberFields = 0;
        for (int number : categoryNumberFields)
            numberFields += number;

        categoryChances = new double[numberCategories];
        for (int i = 0; i < numberCategories; i++)
            categoryChances[i] = (double)categoryNumberFields[i] / (double)numberFields;
    }

    /** Get overall number of fields on the wheel.
     *
     * @return number of fields
     */
    public int getNumberFields() {
        return numberFields;
    }

    /** Determine the amount of money a player wins for a concrete round.<br><br>
     *
     * The win is determined randomly, with the same chance to get any of the fields. The overall number of fields of
     * each category determine the chance to get a specific category.
     *
     * @return the amount of money won
     */
    @Override
    protected double determineWin() {
        double randomValue = random.nextDouble();
        double randomBorder = 0.0;

        for (int i = 0; i < categoryChances.length - 1; i++) {
            randomBorder += categoryChances[i];
            if (randomValue < randomBorder) {
                return categoryWins[i];
            }
        }
        return categoryWins[categoryWins.length - 1];
    }
}
