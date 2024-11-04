package misc.lab1.vector;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class FlightPlan {

	public static void main(String[] args) {
		double maxRange = 200.0;
		
		// Single flight parts represented as vectors in [km]
		Vector2D s1 = new Vector2D(0.0, 25.0);
		Vector2D s2 = new Vector2D(40.0, 30.0);
		Vector2D s3 = new Vector2D(40.0, -30.0);
		
		// Distance after first two parts
		Vector2D position = new Vector2D(0.0, 0.0).add(s1).add(s2).add(s3);
		double distanceFlown = s1.getAbsolute() + s2.getAbsolute() + s3.getAbsolute();
		double distanceFromAirport = position.getAbsolute();
		
		System.out.printf("Relative position\t: (%.1f ; %.1f) km\n", position.getX(), position.getY());
		System.out.printf("Distance flown\t\t: %.1f km\n", distanceFlown);
		System.out.printf("Distance from airport\t: %.1f km\n", distanceFromAirport);
		System.out.printf("Route distance\t\t: %.1f km\n", distanceFlown + distanceFromAirport);
		System.out.printf("Maximum range\t\t: %.1f km\n", maxRange);
	}

}
