package misc.lab4.prime_finder;

import java.util.GregorianCalendar;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class ThreadExperiment {

	/**
	 * 
	 * @param startTimeMs
	 * @param stopTimeMs
	 */
	private static void printTimeTaken(long startTimeMs, long stopTimeMs) {
		long timeTakenMs = stopTimeMs - startTimeMs;
		long millisecs = timeTakenMs % 1000;
		long seconds = timeTakenMs / 1000;
		System.out.printf("Time taken: %d.%d s\n", seconds, millisecs);
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		final long maxNumber = 100000L;
		final int numberThreads = 4;
		final int numberLoops = 3;
		long startTimeMs;

		// TODO Aufgabe: Geschwindigkeit steigt nicht im selben Maße wie # Threads,
		//               weil Intervalle mit größeren Zahlen sehr rechenintensiv sind.

		// Single-threaded
		System.out.println("Single-threaded:");
		startTimeMs = new GregorianCalendar().getTimeInMillis();
		PrimeFinder.getPrimeNumbers(maxNumber, 1);
		printTimeTaken(startTimeMs, new GregorianCalendar().getTimeInMillis());

		// Multithreaded
		System.out.println("\nMulti-threaded (" + numberThreads + " threads):");
		for (int i = 0; i < numberLoops; i++) {
			startTimeMs = new GregorianCalendar().getTimeInMillis();
			PrimeFinder.getPrimeNumbers(maxNumber, numberThreads);
			printTimeTaken(startTimeMs, new GregorianCalendar().getTimeInMillis());
		}
		System.out.println("\nCompleted");
	}
}
