package ai_bandit.lab1;

import java.util.Random;
import java.util.Scanner;

/** App demonstrating multi-armed bandit.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.03.06<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class MultiBanditApp {
    /** Application starting point.
     *
     * @param args Arguments (not used)
     */
    public static void main(String[] args) {
        int numberRounds;
        int numberBandits = 7;
        double win, overallWin = 0.0;
        Random random = new Random();

        // Init bandits and print information
        MultiBandit bandits = new MultiBandit(numberBandits);
        System.out.printf("Gambling: Multi-armed bandit (%d bandits)\n", bandits.getNumberBandits());
        System.out.printf("Price   : %.2f EUR\n\n", bandits.getPricePerRound());

        // Get user input (number of rounds to play)
        Scanner scanner = new Scanner(System.in);
        System.out.print("How many rounds would you like to play? ");
        numberRounds = scanner.nextInt();
        System.out.println();

        // Play rounds selecting random bandits and print win
        System.out.println("Round | Bandit | Win [EUR] | Net [EUR]");
        System.out.println("------+--------+-----------+----------");
        for (int i = 1; i <= numberRounds; i++) {
            int banditIndex = random.nextInt(bandits.getNumberBandits());
            win = bandits.play(banditIndex);
            overallWin += (win - bandits.getPricePerRound());
            System.out.printf("%5d | %6d | %9.2f | %9.2f\n", i, banditIndex + 1, win, overallWin);
        }
        System.out.println();

        // Print bandit's play statistics
        System.out.println("Multi-armed bandit's statistics:");
        System.out.printf("Rounds: %d\n", bandits.getRoundsPlayed());
        System.out.printf("Profit: %.2f (%.2f EUR/round)\n\n", bandits.getOverallProfit(), bandits.getMeanProfitPerRound());
    }
}
