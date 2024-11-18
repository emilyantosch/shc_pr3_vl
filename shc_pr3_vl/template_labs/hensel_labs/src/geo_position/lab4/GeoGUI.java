package geo_position.lab4;

import java.awt.Container;
import java.awt.GridLayout;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GeoGUI {
	private JFrame frame;
	private JLabel distanceLabel = new JLabel("Entfernung:");
	private JLabel positionLabel = new JLabel("");
	private MapPanel mapPanel;
	private double mapWidth, mapHeight;
	private GeoRoute route;
	private GeoTrack track = new GeoTrack("HAW Hamburg", "");

	public GeoGUI() {
		frame = new JFrame("Tracking");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setLocationByPlatform(true);
		frame.setResizable(false);

		// Create panels
		route = readRouteGeoCoords("src/labs/geo_position/lab4/RouteGeo.txt");
		JPanel controlPanel = createControlPanel();
		mapPanel = createMapPanel("src/labs/geo_position/lab4/OSM_BerlinerTor.png", route);

		// Layout panels
		Container contentPane = frame.getContentPane();
		contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.Y_AXIS));
		contentPane.add(controlPanel);
		contentPane.add(mapPanel);

		frame.pack();
		frame.setVisible(true);
	}

	private GeoRoute readRouteGeoCoords(String fileName) {
		GeoRoute route = new GeoRoute("Berliner Tor");
		File file = new File(fileName);
		
		try {
			// Open text file
			FileReader reader = new FileReader(file);
			BufferedReader bufferedReader = new BufferedReader(reader);
			
			// Add waypoint from each line
	        while (bufferedReader.ready()) {
	        	String line = bufferedReader.readLine();
	        	String[] split = line.split(",");
	    		route.addWaypoint(new GeoPosition(Double.parseDouble(split[0]), Double.parseDouble(split[1])));
	        }
	        bufferedReader.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return route;
	}

	private BufferedImage readImage(String fileName) {
		BufferedImage image = null;
		try {
			image = ImageIO.read(new File(fileName));
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, "Cannot open file:\n" + fileName, "Open file", JOptionPane.WARNING_MESSAGE);
		}
		return image;
	}

	private JPanel createControlPanel() {
		// Create panel
		JButton resetButton = new JButton("Track zurücksetzen");
		JPanel buttonPanel = new JPanel();
		buttonPanel.add(resetButton);		

		JPanel controlPanel = new JPanel();
		controlPanel.setLayout(new GridLayout(1, 3));
		controlPanel.add(buttonPanel);
		controlPanel.add(distanceLabel);
		controlPanel.add(positionLabel);
		
		// Event handling
		addButtonEvents(resetButton);
		
		return controlPanel;
	}

	private MapPanel createMapPanel(String fileName, GeoRoute route) {
		// Read image
		MapPanel mapPanel;
		BufferedImage image = readImage(fileName);
		if (image != null) {
			mapWidth = image.getWidth();
			mapHeight = image.getHeight();
		}
		
		// Create route
		GeoPosition[] waypointsGeo = route.getWaypoints();
		Point[] waypoints = new Point[waypointsGeo.length];
		for (int i = 0; i < waypointsGeo.length; i++) {
			waypoints[i] = new Point(toX(waypointsGeo[i].getLongitude()), toY(waypointsGeo[i].getLatitude()));
		}
		
		// Create panel
		mapPanel = new MapPanel(image, waypoints);
		
		// Event handling
		addMouseEvents(mapPanel);

		return mapPanel;
	}
	
	private double toLatitude(int y) {
		double top = 53.5631389;
		double bottom = 53.5566389;
		return top + (((double)y) / mapHeight) * (bottom - top);
	}
	
	private double toLongitude(int x) {
		double left = 10.008555555555555;
		double right = 10.025;
		return left + (((double)x) / mapWidth) * (right - left);
	}

	private int toX(double longitude) {
		double left = 10.008555555555555;
		double right = 10.025;
		return (int) Math.round(mapWidth* (longitude - left) / (right - left));
	}

	private int toY(double latitude) {
		double top = 53.5631389;
		double bottom = 53.5566389;
		return (int) Math.round(mapHeight * (latitude - top) / (bottom - top));
	}
	
	private void updateTrack() {		
		// Text display
		String message = String.format("Entfernung: %.3f km", track.getDistance());
		distanceLabel.setText(message);
		
		// Draw track on panel
		ArrayList<Point> points = new ArrayList<>();
		for (GeoPosition waypoint : track.getWaypoints()) {
			points.add(new Point(toX(waypoint.getLongitude()), toY(waypoint.getLatitude())));
		}
		
		double toleranceMeter = 25.0;
		int waypointsPassed = track.waypointsPassed(route, toleranceMeter);
		mapPanel.setTrack(points, waypointsPassed);
		frame.repaint();
	}
	
	private void updateMousePosition(int x, int y) {
		String message = String.format("(lat , lon) = (%.5f , %.5f)", toLatitude(y), toLongitude(x));
		positionLabel.setText(message);
	}

	private void addButtonEvents(JButton resetButton) {
		resetButton.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				track = new GeoTrack("HAW Hamburg", "");
				updateTrack();
			}
		});
	}
	
	private void addMouseEvents(MapPanel mapPanel) {		
		mapPanel.addMouseMotionListener(new MouseMotionListener() {
			@Override
			public void mouseMoved(MouseEvent event) {
				updateMousePosition(event.getX(), event.getY());
			}

			@Override
			public void mouseDragged(MouseEvent event) {
				// Add waypoint to track
				GeoPosition waypoint = new GeoPosition(toLatitude(event.getY()), toLongitude(event.getX()));
				track.addWaypoint(waypoint);
				updateTrack();

				// Update data displayed
				updateMousePosition(event.getX(), event.getY());
			}
		});
	}

	public static void main(String[] args) {
		new GeoGUI();
	}
}

