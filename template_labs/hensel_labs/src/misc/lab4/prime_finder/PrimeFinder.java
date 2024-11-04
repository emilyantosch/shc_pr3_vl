package misc.lab4.prime_finder;

import java.util.ArrayList;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class PrimeFinder {
	
	/** Test if a number is a prime number.
	 * 
	 * @param number Number to be tested
	 * @return true if the number is a prime number
	 */
	public static boolean isPrimeNumber(long number) {
		// Number too small (i.e. <= 1) => No prime number
		if (number <= 1) {
			return false;
		}
		
		// Even number (except for 2) => No prime number
		if ((number/2)*2 == number) {
            return number == 2;
		}

		// Odd numbers: Found odd divisor => No prime number
		for (long index = 3; index < number/2; index += 2) {
			if( (number%index) == 0) {
				return false;
			}
		}
		return true;
	}	

	/**
	 * 
	 * @param minNumber
	 * @param maxNumber
	 * @return
	 */
	public static ArrayList<Long> getPrimeNumbersInInterval(long minNumber, long maxNumber) {
		ArrayList<Long> primeNumbers = new ArrayList<>();
		
		for (long i = minNumber; i <= maxNumber; i++) {
			if (isPrimeNumber(i)) {
				primeNumbers.add(i);
			}
		}
		return primeNumbers;
	}
	
	/**
	 * 
	 * @param maxNumber
	 * @param numberThreads
	 * @return
	 */
	public static ArrayList<Long> getPrimeNumbers(long maxNumber, int numberThreads) {
		ArrayList<Long> primeNumbers = new ArrayList<>();
		PrimeFinderThread[] threads = new PrimeFinderThread[numberThreads];
		int intervalSize = (int)(maxNumber / numberThreads);

		// Create thread objects (interval of last thread might have different size)
		for (int i = 0; i < numberThreads - 1; i++) {
			long start = (long) i * intervalSize;
			long end = (long) (i + 1) * intervalSize - 1;
			threads[i] = new PrimeFinderThread(start, end);
		}
		threads[numberThreads - 1] = new PrimeFinderThread((long) (numberThreads - 1) * intervalSize, maxNumber);
		
		// Start all threads
		for (int i = 0; i < numberThreads; i++) {
			threads[i].start();
		}
		
		// Wait for threads to terminate and add results to prime list
		for (int i = 0; i < numberThreads; i++) {
			try {
				threads[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			primeNumbers.addAll(threads[i].getPrimeNumbers());
		}
		
		return primeNumbers;
	}
}
