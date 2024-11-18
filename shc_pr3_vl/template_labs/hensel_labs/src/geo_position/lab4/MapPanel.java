package geo_position.lab4;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

import javax.swing.JPanel;

@SuppressWarnings("serial")
/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class MapPanel extends JPanel {
	private BufferedImage image;
	private Point[] route;
	private ArrayList<Point> track = new ArrayList<>();
	private int numberWaypointsPassed;

	public MapPanel(BufferedImage image, Point[] route) {
		super();
		this.image = image;
		this.route = route;
	}

	public void setTrack(ArrayList<Point> track, int numberWaypointsPassed) {
		this.track = track;
		this.numberWaypointsPassed = numberWaypointsPassed;
	}

	@Override
	public Dimension getPreferredSize() {
		if (image != null) {
			return new Dimension(image.getWidth(), image.getHeight());
		} else {
			return new Dimension(0, 0);
		}
	}

	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);

		// Draw map image
		g.drawImage(image, 0, 0, null);

		// Draw route path
		Graphics2D g2 = (Graphics2D) g;
		g2.setStroke(new BasicStroke(2));	// Set line thickness
		
		g.setColor(Color.RED);	
		for (int i = 1; i < route.length; i++) {
			g.drawLine(route[i-1].x, route[i-1].y, route[i].x, route[i].y);
		}

		// Draw track
		g.setColor(Color.BLUE);
		for (int i = 1; i < track.size(); i++) {
			g.drawLine(track.get(i-1).x, track.get(i-1).y, track.get(i).x, track.get(i).y);
		}

		// Draw route waypoints and annotation
		int radius = 5;
		int diameter = 2 * radius + 1;
		
		g2.setStroke(new BasicStroke(1));
		for (int i = 0; i < route.length; i++) {
			if (i < numberWaypointsPassed) {
				g.setColor(Color.GREEN);	
			} else {
				g.setColor(Color.RED);	
			}
			g.fillOval(route[i].x - radius, route[i].y - radius, diameter, diameter);

			g.setColor(Color.BLACK);	
			g.drawOval(route[i].x - radius, route[i].y - radius, diameter, diameter);
			g.drawString(Integer.toString(i), route[i].x + 2 * radius, route[i].y);
		}
	}
}