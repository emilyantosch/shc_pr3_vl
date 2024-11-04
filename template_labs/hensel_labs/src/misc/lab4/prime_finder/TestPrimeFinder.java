package misc.lab4.prime_finder;

import org.junit.Test;

import static org.junit.Assert.*;

/** Test classes for lab 4 ("Prime Finder").<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class TestPrimeFinder {
	
	/** Test method isPrimeNumber() of class PrimeFinder.
	 */
	@Test
	public void test_R01_PrimeFinder_isPrimeNumber() {
		long[] primeNumbers = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271};
		int primesID = 0;		// Index in array primeNumbers

		for (long number = -10; number <= primeNumbers[primeNumbers.length - 1]; number++) {
			// Is a prime number
			if (number == primeNumbers[primesID]) {
				assertTrue("False negative: " + number, PrimeFinder.isPrimeNumber(number));
				primesID++;
			// Is not a prime number
			} else {
				assertFalse("False positive: " + number, PrimeFinder.isPrimeNumber(number));
			}
		}
	}

	/** Test method getPrimeNumbersInIntervall() of class PrimeFinder.
	 */
	@Test
	public void test_R02_PrimeFinder_getPrimeNumbersInIntervall() {
		Long[] expected = new Long[]{2L, 3L, 5L, 7L, 11L, 13L, 17L, 19L};
		Long[] actual = PrimeFinder.getPrimeNumbersInInterval(0, 20).toArray(new Long[0]);
		assertArrayEquals(expected, actual);

		expected = new Long[]{3L, 5L, 7L, 11L, 13L, 17L, 19L};
		actual = PrimeFinder.getPrimeNumbersInInterval(3, 19).toArray(new Long[0]);
		assertArrayEquals(expected, actual);

		expected = new Long[]{11L, 13L};
		actual = PrimeFinder.getPrimeNumbersInInterval(10, 15).toArray(new Long[0]);
		assertArrayEquals(expected, actual);

		expected = new Long[]{};
		actual = PrimeFinder.getPrimeNumbersInInterval(14, 16).toArray(new Long[0]);
		assertArrayEquals(expected, actual);

		expected = new Long[]{7L};
		actual = PrimeFinder.getPrimeNumbersInInterval(7, 7).toArray(new Long[0]);
		assertArrayEquals(expected, actual);
	}

	/** Test if class PrimeFinderThread has super class Thread.
	 */
	@Test
	public void test_R03_PrimeFinderThread_superClass() {
		assertEquals(Thread.class, PrimeFinderThread.class.getSuperclass());
	}

	/** Test class PrimeFinderThread for several intervals.
	 */
	@Test
	public void test_R06_to_R08_PrimeFinderThread() {
		PrimeFinderThread primeThread;
		Long[] expected, actual;

		primeThread = new PrimeFinderThread(0, 20);
		primeThread.run();		
		expected = new Long[]{2L, 3L, 5L, 7L, 11L, 13L, 17L, 19L};
		actual = primeThread.getPrimeNumbers().toArray(new Long[0]);
		assertArrayEquals(expected, actual);

		primeThread = new PrimeFinderThread(7, 17);
		primeThread.run();		
		expected = new Long[]{7L, 11L, 13L, 17L};
		actual = primeThread.getPrimeNumbers().toArray(new Long[0]);
		assertArrayEquals(expected, actual);		

		primeThread = new PrimeFinderThread(11, 11);
		primeThread.run();		
		expected = new Long[]{11L};
		actual = primeThread.getPrimeNumbers().toArray(new Long[0]);
		assertArrayEquals(expected, actual);		

		primeThread = new PrimeFinderThread(8, 10);
		primeThread.run();		
		expected = new Long[]{};
		actual = primeThread.getPrimeNumbers().toArray(new Long[0]);
		assertArrayEquals(expected, actual);		
	}
	
	/** Test class method getPrimeNumbers() of class PrimeFinder.
	 */
	@Test
	public void test_R09_to_R10_PrimeFinder_getPrimeNumbers() {
		Long[] expected = new Long[]{2L, 3L, 5L, 7L, 11L, 13L, 17L, 19L};
		Long[] actual;
		
		// Number threads: 1 to "greater maximum number"
		for (int numberThreads = 1; numberThreads < 50; numberThreads++) {
			actual = PrimeFinder.getPrimeNumbers(20, numberThreads).toArray(new Long[0]);
			assertArrayEquals(expected, actual);
		}
		
		// Test, if intervals do not overlap (=> double entries)
		int numberThreads = 2;		
		expected = new Long[]{2L, 3L, 5L, 7L};
		actual = PrimeFinder.getPrimeNumbers(9, numberThreads).toArray(new Long[0]);
		assertArrayEquals(expected, actual);

		actual = PrimeFinder.getPrimeNumbers(10, numberThreads).toArray(new Long[0]);
		assertArrayEquals(expected, actual);
	}
}
