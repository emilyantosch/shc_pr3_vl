package geo_position.lab3;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

import javax.swing.JPanel;

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
	private ArrayList<Point> route = new ArrayList<>();
	
	public MapPanel(BufferedImage image) {
		super();
		this.image = image;
	}
	
	public void setRoute(ArrayList<Point> route) {
		this.route = route;
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
		
		// Draw route
		Graphics2D g2 = (Graphics2D) g;
		g2.setStroke(new BasicStroke(4));	// Increase line thickness
		g2.setColor(Color.RED);
		for (int i = 1; i < route.size(); i++) {
			g2.drawLine(route.get(i-1).x, route.get(i-1).y, route.get(i).x, route.get(i).y);
		}
	}
}