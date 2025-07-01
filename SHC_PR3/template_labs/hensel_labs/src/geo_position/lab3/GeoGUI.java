package geo_position.lab3;

import java.awt.Container;
import java.awt.GridLayout;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;
import java.io.File;
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
	private JLabel positionLabel = new JLabel("Position:");
	private MapPanel mapPanel;
	private double mapWidth, mapHeight;
	private GeoRoute route = new GeoRoute("");

	public GeoGUI() {
		frame = new JFrame("Geografische Strecken");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setLocationByPlatform(true);
		frame.setResizable(false);

		// Create panels
		JPanel controlPanel = createControlPanel();
		mapPanel = createMapPanel("src/labs/geo_position/lab3/OSM_Map.png");

		// Layout panels
		Container contentPane = frame.getContentPane();
		contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.Y_AXIS));
		contentPane.add(controlPanel);
		contentPane.add(mapPanel);

		frame.pack();
		frame.setVisible(true);
	}

	private JPanel createControlPanel() {
		// Create panel
		JButton resetButton = new JButton("Route zurücksetzen");
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

	private MapPanel createMapPanel(String fileName) {
		// Create panel
		MapPanel mapPanel;
		BufferedImage image = readImage(fileName);
		if (image != null) {
			mapWidth = image.getWidth();
			mapHeight = image.getHeight();
		}
		mapPanel = new MapPanel(image);
		
		// Event handling
		addMouseEvents(mapPanel);

		return mapPanel;
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
	
	private double toLatitude(int y) {
		double top = 54.5720556;
		double bottom = 53.3325;
		return top + (((double)y) / mapHeight) * (bottom - top);
	}
	
	private double toLongitude(int x) {
		double left = 8.4375;
		double right = 11.24725;
		return left + (((double)x) / mapWidth) * (right - left);
	}

	private int toX(double longitude) {
		double left = 8.4375;
		double right = 11.24725;
		return (int) Math.round(mapWidth* (longitude - left) / (right - left));
	}

	private int toY(double latitude) {
		double top = 54.5720556;
		double bottom = 53.3325;
		return (int) Math.round(mapHeight * (latitude - top) / (bottom - top));
	}
	
	private void updateRoute() {
		// Text display
		String message = String.format("Entfernung: %.0f km", route.getDistance());
		distanceLabel.setText(message);
		
		// Draw route on panel
		ArrayList<Point> points = new ArrayList<>();
		for (GeoPosition waypoint : route.getWaypoints()) {
			points.add(new Point(toX(waypoint.getLongitude()), toY(waypoint.getLatitude())));
		}
		mapPanel.setRoute(points);
		frame.repaint();
	}
	
	private void updateMousePosition(int x, int y) {
		String message = String.format("Position: (lat , lon) = (%.3f , %.3f)", toLatitude(y), toLongitude(x));
		positionLabel.setText(message);
	}

	private void addButtonEvents(JButton resetButton) {
		resetButton.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				route = new GeoRoute("");
				updateRoute();
			}
		});
	}
	
	private void addMouseEvents(MapPanel mapPanel) {
		mapPanel.addMouseListener(new MouseListener() {

			@Override
			public void mouseClicked(MouseEvent event) {
			}

			@Override
			public void mouseEntered(MouseEvent event) {
			}

			@Override
			public void mouseExited(MouseEvent event) {
			}

			@Override
			public void mousePressed(MouseEvent event) {
				GeoPosition waypoint = new GeoPosition(toLatitude(event.getY()), toLongitude(event.getX()));
				route.addWaypoint(waypoint);
				updateRoute();
			}

			@Override
			public void mouseReleased(MouseEvent event) {
			}			
		});
		
		mapPanel.addMouseMotionListener(new MouseMotionListener() {
			@Override
			public void mouseMoved(MouseEvent event) {
				updateMousePosition(event.getX(), event.getY());
			}

			@Override
			public void mouseDragged(MouseEvent event) {
				updateMousePosition(event.getX(), event.getY());
			}
		});
	}

	public static void main(String[] args) {
		new GeoGUI();
	}
}

