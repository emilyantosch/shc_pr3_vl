package geo_position.lab2;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class AppHamburg {

	public static GeoRoute createStadtpark() {
		GeoRoute route = new GeoRoute("Stadtpark");
		
		route.addWaypoint(new GeoPosition(53.598256, 10.005262));
		route.addWaypoint(new GeoPosition(53.594212, 10.006316));
		route.addWaypoint(new GeoPosition(53.593709, 10.014191));
		route.addWaypoint(new GeoPosition(53.591226, 10.029254));
		route.addWaypoint(new GeoPosition(53.596148, 10.030938));
		route.addWaypoint(new GeoPosition(53.596466, 10.027773));
		route.addWaypoint(new GeoPosition(53.599013, 10.029415));
		route.addWaypoint(new GeoPosition(53.598574, 10.009824));
		route.addWaypoint(new GeoPosition(53.599166, 10.007067));
		route.addWaypoint(new GeoPosition(53.598256, 10.005262));
		return route;
	}

	public static void main(String[] args) {
		GeoRoute alster1 = RouteData.createAlsterRoute1();
		GeoRoute alster2 = RouteData.createAlsterRoute2();
		GeoRoute stadtpark = createStadtpark();

		System.out.println("Joggen in Hamburg:");
		System.out.println(alster1);
		System.out.println(alster2);
		System.out.println(stadtpark);
	}
}
