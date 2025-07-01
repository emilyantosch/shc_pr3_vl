package misc.lab4.prime_finder;

import java.util.ArrayList;

/** Thread calculating prime numbers in a given interval.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class PrimeFinderThread extends Thread {
	private long minNumber;
	private long maxNumber;
	private	ArrayList<Long> primeNumbers;
	
	/** Constructor initializing interval [minNumber, maxNumber] to test.
	 *
	 * @param minNumber First number of interval to test
	 * @param maxNumber Last number of interval to test
	 */
	public PrimeFinderThread(long minNumber, long maxNumber) {
		this.minNumber = minNumber;
		this.maxNumber = maxNumber;
	}
	
	/** Generate list of all prime numbers in interval [minNumber, maxNumber].
	 */
	public void run() {
		primeNumbers = PrimeFinder.getPrimeNumbersInInterval(minNumber, maxNumber);
	}
	
	/** Get list of prime numbers in interval.
	 * 
	 * @return sorted list of prime numbers in [minNumber, maxNumber]
	 */
	public ArrayList<Long> getPrimeNumbers() {
		return primeNumbers;
	}
}
