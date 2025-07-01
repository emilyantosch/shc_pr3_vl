package geo_position.lab3;

import java.util.ArrayList;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GeoRoute implements Distance, Comparable<GeoRoute> {
	private String name;
	private ArrayList<GeoPosition> waypoints = new ArrayList<>();

	public GeoRoute(String name) {
		super();
		this.name = name;
	}

	public GeoRoute(String name, ArrayList<GeoPosition> waypoints) {
		super();
		this.name = name;
		this.waypoints = waypoints;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void addWaypoint(GeoPosition waypoint) {
		waypoints.add(waypoint);
	}

	public void removeWaypoint(int index) {
		if ((index >= 0) && (index < waypoints.size())) {
			waypoints.remove(index);
		}
	}
	
	public int getNumberWaypoints() {
		return waypoints.size();
	}

	public GeoPosition getWaypoint(int index) {
		GeoPosition waypoint = null;

		if ((index >= 0) && (index < waypoints.size())) {
			waypoint = waypoints.get(index);
		}
		return waypoint;
	}

	public GeoPosition[] getWaypoints() {
		return waypoints.toArray(new GeoPosition[waypoints.size()]);
	}

	@Override
	public double getDistance() {
		double distance = 0.0;

		for (int i = 1; i < waypoints.size(); i++) {
			distance += GeoPosition.distanceInKm(waypoints.get(i - 1), waypoints.get(i));
		}
		return distance;
	}

	@Override
	public int compareTo(GeoRoute other) {
		double difference = getDistance() - other.getDistance();

		if (difference > 0.0) {
			return 1;
		} else if (difference < 0.0) {
			return -1;
		} else {
			return 0;
		}
	}

	@Override
	public String toString() {
		return String.format("%s (%.1f km)", name, getDistance());
	}
}
