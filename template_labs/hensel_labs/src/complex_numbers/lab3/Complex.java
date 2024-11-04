package complex_numbers.lab3;

/** Class representing a complex number.<br><br>
 *
 * Represents a complex number z = x + j*y with real part Re(z) = x and imaginary part Im(z) = y.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class Complex {
	private double real;
	private double imag;
	
	/** Standard constructor (initializes z = 0 + 0*i).
	 */
	public Complex() {
		real = 0.0;
		imag = 0.0;
	}
	
	/** Constructor (initializes z = real + imag * i)
	 * 
	 * @param real Real part of complex number
	 * @param imag Imaginary part of complex number
	 */
	public Complex(double real, double imag) {
		this.real = real;
		this.imag = imag;
	}
	
	/** Get real part.
	 * 
	 * @return Real part of number
	 */
	public double getReal() { return real; }
	
	/** Get imaginary part.
	 * 
	 * @return Imaginary part of number
	 */
	public double getImag() { return imag; }

	/** Add a complex number z (Operation: z(this) = z(this) + z).
	 * 
	 * @param z Number to add
	 * @return Reference to this object after addition
	 */
	public Complex add(Complex z) {
		this.real += z.real;
		this.imag += z.imag;
		return this;
	}

	/** Subtract a complex number z (Operation: z(this) = z(this) - z).
	 * 
	 * @param z Number to subtract
	 * @return Reference to this object after subtraction
	 */
	public Complex sub(Complex z) {
		this.real -= z.real;
		this.imag -= z.imag;
		return this;
	}
	
	/** Multiply with a complex number (Operation: z(this) = z(this) * z).<p>
	 * 
	 * For z1 = a + i*b and z2 = c + i*d:<p>
	 * z1 * z2 = (a + i*b) * (c + i*d) = (ac - bd) + i * (ad + bc)
	 * 
	 * @param z Number to multiply with
	 * @return Reference to this object after multiplication
	 */
	public Complex mul(Complex z) {
		double	newReal = this.real * z.real - this.imag * z.imag;   
		double	newImag = this.real * z.imag + this.imag * z.real;
		this.real = newReal;
		this.imag = newImag;
		return this;
	}
	
	/** Divide by a complex number (Operation: z(this) = z(this) / z).<p>
	 * 
	 * For z1, z2 and ~z2 denoting the conjugate complex:<p>
	 * z1/z2 = z1/z2 * ~z2/~z2 = (z1 * ~z2)/|z2|^2
	 * 
	 * @param z	exercises_wip.imaging_dft.Complex number to divide with
	 * @return Reference to this object after division
	 */
	public Complex div(Complex z) {
		double	nomiator = z.real * z.real + z.imag * z.imag;
		double	newReal = (this.real * z.real + this.imag * z.imag) / nomiator;
		double	newImag = (z.real * this.imag - z.imag * this.real) / nomiator;
		
		this.real = newReal;
		this.imag = newImag;
		return this;
	}
	
	/** Get absolute value of complex number.<p>
	 * 
	 * ||z|| = sqrt(a^2 + b^2) for z = a + i*b.
	 * 
	 * @return Absolute value ||z||
	 */
	public double getAbs() {
		return Math.sqrt(real * real + imag * imag);
	}

	/**
	 * Get phase (angle) of complex number.<p>
	 * 
	 * Polar coordinates:
	 * z = ||z|| * exp(i * phi)<p>
	 * 
	 * @return Angle phi in radians in [0, 2*PI)
	 */
	public double getPhase() {
		double phase = 0.0;						// Case real = imag = 0.0
		
		if (real != 0.0 || imag != 0.0)
			phase = Math.atan2(imag, real);		// phase in [-PI, PI]
		
		return (phase >= 0.0)? phase : phase + 2 * Math.PI;
	}

	/** Add two complex numbers (Operation: z = z1 + z2).
	 * 
	 * @param z1 First operand
	 * @param z2 Second operand
	 * @return New object containing result of operation
	 */
	public static Complex add(Complex z1, Complex z2) {
		Complex	z = new Complex(z1.real, z1.imag);
		return (z.add(z2));
	}

	/** Subtract two complex numbers (Operation: z = z1 - z2).
	 * 
	 * @param z1 First operand
	 * @param z2 Second operand
	 * @return New object containing result of operation
	 */
	public static Complex sub(Complex z1, Complex z2) {
		Complex	z = new Complex(z1.real, z1.imag);
		return (z.sub(z2));
	}

	/** Multiply two complex numbers (Operation: z = z1 * z2).
	 * 
	 * @param z1 First operand
	 * @param z2 Second operand
	 * @return New object containing result of operation
	 */
	public static Complex mul(Complex z1, Complex z2) {
		Complex	z = new Complex(z1.real, z1.imag);
		return (z.mul(z2));
	}

	/** Divide two complex numbers (Operation: z = z1 / z2).
	 * 
	 * @param z1 First operand
	 * @param z2 Second operand
	 * @return New object containing result of operation
	 */
	public static Complex div(Complex z1, Complex z2) {
		Complex	z = new Complex(z1.real, z1.imag);
		return (z.div(z2));
	}
	
	/** Create string representation of object.
	 * 
	 * @return String formatted "(<real> {+,-} <imag>*j)"
	 */
	public String toString() {
		if (imag >= 0.0) {
			return "(" + real + " + " + imag + "*j)";
		} else {
			return "(" + real + " - " + (-imag) + "*j)";
		}
	}	
	
	/** Compare with complex number for equal contents.
	 * 
	 * @param obj exercises_wip.imaging_dft.Complex number z to compare with
	 * @return True if real and imaginary parts of both complex numbers correspond
	 */
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof Complex)) {
			return false;
		}
		Complex other = (Complex) obj;
		if (Double.doubleToLongBits(imag) != Double
				.doubleToLongBits(other.imag)) {
			return false;
		}
		if (Double.doubleToLongBits(real) != Double
				.doubleToLongBits(other.real)) {
			return false;
		}
		return true;
	}
}