package geo_position.lab4;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GeoTrack extends GeoRoute {
	private String date;

	public GeoTrack(String name, String date) {
		super(name);
		this.date = date;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	public int waypointsPassed(GeoRoute route, double toleranceMeter) {
		double toleranceKm = toleranceMeter / 1000.0;
		int waypointsPassed = 0;
		
		// Route exists
		if ((route != null) && (route.getNumberWaypoints() > 0)) {
			GeoPosition nextWaypoint = route.getWaypoint(waypointsPassed);
			
			for (int i = 0; i < getNumberWaypoints(); i++) {
				double distanceKm = nextWaypoint.distanceInKm(getWaypoint(i));
				if (distanceKm <= toleranceKm) {
					waypointsPassed++;
					if (waypointsPassed < route.getNumberWaypoints()) {
						nextWaypoint = route.getWaypoint(waypointsPassed);
					} else {
						break;
					}
				}
			}
		}
				
		return waypointsPassed;
	}
}
