package complex_numbers.lab1;

/** Calculate voltage in electrical resonant circuit using class Complex.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class ResonantCircuit {
	// Values of electrical components and input voltage
	private static final double R_IN_OHM = 10.0;
	private static final double L_IN_HENRY = 10.0E-3;
	private static final double C_IN_FARAD = 10.0E-9;
	private static final double U0_IN_OHM = 1.0;

	/**
	 * Calculate voltage at resistor for given frequency.
	 * 
	 * @param omega Frequency w = 2 * pi * f [1/s]
	 * @return exercises_wip.imaging_dft.Complex voltage at resistor
	 */
	static Complex voltageOverResistor (double omega) {
		// Calculate overall impedance of series
		Complex impedanceR = new Complex(R_IN_OHM, 0.0);
		Complex impedanceL = new Complex(0.0, omega * L_IN_HENRY);
		Complex impedanceC = new Complex(0.0, - 1.0 / (omega * C_IN_FARAD));
		Complex z = Complex.add(impedanceR, impedanceL).add(impedanceC);
		
		// Calculate and return voltage over resistor
		Complex inputVoltage = new Complex(U0_IN_OHM, 0.0);
		Complex current = Complex.divide(inputVoltage, z);
		return Complex.multiply(impedanceR, current);
	}

	/**
	 * Application entry point
	 * 
	 * @param args Command-line parameters (not used)
	 */
	public static void main(String[] args) {
		int minFrequency_kHz = 10;
		int maxFrequency_kHz = 100;
		int deltaFrequency_kHz = 10;
		int numberFrequencies = (maxFrequency_kHz - minFrequency_kHz) / deltaFrequency_kHz + 1;
		
		double[] frequencies = new double[numberFrequencies];
		Complex[] voltagesR = new Complex[numberFrequencies];
		
		// Create frequency and voltage arrays
		for (int i = 0; i < numberFrequencies; i++) {
			frequencies[i] = 1000 * (minFrequency_kHz + i * deltaFrequency_kHz);
			voltagesR[i] = voltageOverResistor(2 * Math.PI * frequencies[i]);
		}
		
		// Print to console
		for (int i = 0; i < numberFrequencies; i++) {
			System.out.printf("f = %3.0f kHz: |U_R| = %5.1f mV\n",
				frequencies[i]/1000, 1000 * voltagesR[i].getAbsolute());
		}
	}
}
