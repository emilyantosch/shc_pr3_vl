package geo_position.lab4;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GeoPosition {
	private double latitude;
	private double longitude;
	
	public GeoPosition(double latitude, double longitude) {
		super();
		this.latitude = latitude;		// y: Breitengrad (= 0 auf Äquator)
		this.longitude = longitude;		// x: Längengrad (durch beide Pole)
	}
	
	public double getLatitude() {
		return latitude;
	}

	public double getLongitude() {
		return longitude;
	}
	
	public boolean isNorthernHemisphere() {
		return latitude > 0.0;
	}
	
	public boolean isSouthernHemisphere() {
		return latitude < 0.0;
	}

	public double distanceInKm(GeoPosition other) {
		return distanceInKm(this, other);
	}

	public static double distanceInKm(GeoPosition a, GeoPosition b) {
		final double RADIUS_EARTH_KM = 6378.388;
		double lat1 = Math.toRadians(a.latitude);
		double lat2 = Math.toRadians(b.latitude);
		double lon1 = Math.toRadians(a.longitude);
		double lon2 = Math.toRadians(b.longitude);
		double cosArc = Math.sin(lat1) * Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2) * Math.cos(lon2 - lon1);
		
		return RADIUS_EARTH_KM * Math.acos(cosArc);
	}

	public static double localDistanceInKm(GeoPosition a, GeoPosition b) {
		final double LATITUDE_TO_KM = 111.3;
		double meanLatitude = 0.5 * (a.latitude + b.latitude);
		double longitudeToKm = LATITUDE_TO_KM * Math.cos(Math.toRadians(meanLatitude));		// cos(): 1 at equator, 0 at poles
		double dx = longitudeToKm * (a.longitude - b.longitude);		// Absolute not required, because dx and dy get squared
		double dy = LATITUDE_TO_KM * (a.latitude - b.latitude);
		
		return Math.sqrt(dx * dx + dy * dy);
	}
	
	@Override
	public String toString() {
		return "(" + latitude + ", " + longitude + ")";
	}
}
