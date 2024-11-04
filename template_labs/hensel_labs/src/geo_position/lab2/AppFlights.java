package geo_position.lab2;

import java.util.ArrayList;
import java.util.Collections;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class AppFlights {

	public static void main(String[] args) {
		ArrayList<GeoRoute> routes = RouteData.createFlightRoutes();
		
		System.out.println("Unsortiert:");
		for (GeoRoute route : routes) {
			System.out.println(route);
		}
		
		Collections.sort(routes);
		System.out.println("\nSortiert:");
		for (GeoRoute route : routes) {
			System.out.println(route);
		}
	}
}
