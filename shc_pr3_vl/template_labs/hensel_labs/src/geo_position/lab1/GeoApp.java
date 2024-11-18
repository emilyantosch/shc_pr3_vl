package geo_position.lab1;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GeoApp {
	
	public static void printDistance(GeoPosition a, GeoPosition b, String name) {
		double distance = GeoPosition.distanceInKm(a, b);
		double localDistance = GeoPosition.localDistanceInKm(a, b);
		double deltaPerc = 100.0 * Math.abs(localDistance - distance) / distance;

		System.out.printf("Entfernung %s\t: %7.1f km (lokal: %7.1f km, Abweichung: %5.2f %%)\n", name, distance, localDistance, deltaPerc);
	}
	
	public static void main(String[] args) {
		GeoPosition haw = new GeoPosition(53.557078, 10.023109);
		GeoPosition eiffelTower = new GeoPosition(48.858363, 2.294481);
		GeoPosition palma = new GeoPosition(39.562553, 2.661947);
		GeoPosition chapelLasVegas = new GeoPosition(36.156214, -115.148736);
		GeoPosition copacabana = new GeoPosition(-22.971177, -43.182543);
		GeoPosition waikiki = new GeoPosition(21.281004, -157.837456);
		GeoPosition surfersParadise = new GeoPosition(-28.002695, 153.431781);

		GeoPosition northpole = new GeoPosition(90.0, 0.0);
		GeoPosition equator = new GeoPosition(0.0, haw.getLongitude());
		GeoPosition southpole = new GeoPosition(-90.0, 0.0);
		
		printDistance(haw, eiffelTower, "Eiffelturm (Paris)");
		printDistance(haw, palma, "Palma de Mallorca");
		printDistance(haw, chapelLasVegas, "Kapelle (Las Vegas)");
		printDistance(haw, copacabana, "Copacabana (Rio)");
		printDistance(haw, waikiki, "Waikiki (Hawaii)");
		printDistance(haw, surfersParadise, "Surfer's Paradise");
		
		System.out.println();
		printDistance(haw, northpole, "Nordpol");
		printDistance(haw, equator, "Äquator");
		printDistance(haw, southpole, "Südpol");
	}
}
