package ai_bandit.lab2;

import java.util.Scanner;

/** App demonstrating wheel of fortune.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.03.16<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class WheelApp {
    /** Application starting point.
     *
     * @param args Arguments (not used)
     */
    public static void main(String[] args) {
        int numberRounds;
        double win, overallWin = 0.0;

        // Init wheel of fortune and print information
        WheelOfFortune wheel = new WheelOfFortune(1.0, new int[]{15, 10, 4, 1}, new double[]{0.0, 1.0, 2.0, 5.0});
        System.out.printf("Gambling: %s\n", wheel.getName());
        System.out.printf("Price   : %.2f EUR\n", wheel.getPricePerRound());
        System.out.printf("Fields  : %d\n\n", wheel.getNumberFields());

        // Get user input (number of rounds to play)
        Scanner scanner = new Scanner(System.in);
        System.out.print("How many rounds would you like to play? ");
        numberRounds = scanner.nextInt();
        System.out.println();

        // Play rounds and print win
        System.out.println("Round | Win [EUR] | Net [EUR]");
        System.out.println("------+-----------+----------");
        for (int i = 1; i <= numberRounds; i++) {
            win = wheel.play();
            overallWin += (win - wheel.getPricePerRound());
            System.out.printf("%5d | %9.2f | %9.2f\n", i, win, overallWin);
        }
        System.out.println();

        // Print wheels' play statistics
        System.out.printf("%s's statistics:\n", wheel.getName());
        System.out.printf("Rounds: %d\n", wheel.getRoundsPlayed());
        System.out.printf("Profit: %.2f (%.2f EUR/round)\n\n", wheel.getOverallProfit(), wheel.getMeanProfitPerRound());
    }
}
