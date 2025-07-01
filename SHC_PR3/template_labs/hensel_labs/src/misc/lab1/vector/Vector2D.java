package misc.lab1.vector;

/** Class representing a 2D vector.<br><br>
 * 
 * Vectors a have two components: a = (x, y)^T.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class Vector2D {
	private double x, y;

	/** Constructor initializing vector components.
	 * 
	 * @param x Value of x component
	 * @param y Value of y component
	 */
	public Vector2D(double x, double y) {
		this.x = x;
		this.y = y;
	}

	/** Get component value.
	 * 
	 * @return value of x component
	 */
	public double getX() {
		return x;
	}

	/** Get component value.
	 * 
	 * @return value of y component
	 */
	public double getY() {
		return y;
	}
	
	/** Add another vector to this one.
	 * 
	 * @return this = this + a
	 */
	public Vector2D add(Vector2D a) {
		x += a.x;
		y += a.y;
		
		return this;
	}

	/** Subtract another vector from this one.
	 * 
	 * @return this = this - a
	 */
	public Vector2D subtract(Vector2D a) {
		x -= a.x;
		y -= a.y;
		
		return this;
	}
	
	/** Multiply vector with scalar value.
	 * 
	 * @return this = c * this
	 */
	public Vector2D multiply(double c) {
		x *= c;
		y *= c;
		
		return this;
	}

	/** Get absolute value.
	 * 
	 * @return Euclidean length |this| = sqrt(x^2 + y^2)
	 */
	public double getAbsolute() {
		return Math.sqrt(x * x + y * y);
	}

	/** Calculate scalar product of two vectors.
	 * 
	 * @return x1 * x2 + y1 * y2
	 */
	public static double multiply(Vector2D a1, Vector2D a2) {
		return a1.x * a2.x + a1.y * a2.y;
	}

	/** Return string representation.
	 * 
	 * @return formatted: "(x, y)^T"
	 */
	@Override
	public String toString() {
		return "(" + x + " , " + y + ")^T";
	}
}