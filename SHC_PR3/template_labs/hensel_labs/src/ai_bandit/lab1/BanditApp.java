package ai_bandit.lab1;

import java.util.Scanner;

/** App demonstrating one-armed bandit.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.03.06<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class BanditApp {
    /** Application starting point.
     *
     * @param args Arguments (not used)
     */
    public static void main(String[] args) {
        int numberRounds;
        double win, overallWin = 0.0;

        // Init bandit and print information
        Bandit bandit = new Bandit(1.0, 0.75, 1.0);
        System.out.printf("Gambling: %s\n", bandit.getName());
        System.out.printf("Price   : %.2f EUR\n\n", bandit.getPricePerRound());

        // Get user input (number of rounds to play)
        Scanner scanner = new Scanner(System.in);
        System.out.print("How many rounds would you like to play? ");
        numberRounds = scanner.nextInt();
        System.out.println();

        // Play rounds and print win
        System.out.println("Round | Win [EUR] | Net [EUR]");
        System.out.println("------+-----------+----------");
        for (int i = 1; i <= numberRounds; i++) {
            win = bandit.play();
            overallWin += (win - bandit.getPricePerRound());
            System.out.printf("%5d | %9.2f | %9.2f\n", i, win, overallWin);
        }
        System.out.println();

        // Print bandit's play statistics
        System.out.printf("%s's statistics:\n", bandit.getName());
        System.out.printf("Rounds: %d\n", bandit.getRoundsPlayed());
        System.out.printf("Profit: %.2f (%.2f EUR/round)\n\n", bandit.getOverallProfit(), bandit.getMeanProfitPerRound());
    }
}
