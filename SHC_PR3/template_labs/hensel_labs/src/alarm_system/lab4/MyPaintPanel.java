package alarm_system.lab4;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;

import javax.swing.BorderFactory;
import javax.swing.JPanel;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
class MyPaintPanel extends JPanel {
	private AlarmSystem system;
	
	public MyPaintPanel(AlarmSystem system) {
		this.system = system;
		setBorder(BorderFactory.createLineBorder(Color.black));
	}

	@Override
	public Dimension getPreferredSize() {
		return new Dimension(450, 350);
	}

	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);

		drawGroundPlan(g);
		drawAlarmSystem(g);
	}
	
	private void drawGroundPlan(Graphics g) {
		int outerWall = 5, innerWall = 3;
		int x0 = 25, y0 = 25;
		int width = 400, height = 300;
		int doorWidth = 35;
		
		// Inner walls
		g.setColor(Color.DARK_GRAY);
		g.fillRect(x0, y0 + height/2, width*2/3, innerWall);
		g.fillRect(x0, y0 + height*3/4, width/3, innerWall);
		g.fillRect(x0 + width/3, y0 + height/2, innerWall, height/2);
		g.fillRect(x0 + width*2/3, y0 + height/2, innerWall, height/2);
		
		// Inner doors
		g.setColor(Color.LIGHT_GRAY);
		g.fillRect(x0 + width/2 - doorWidth, y0 + height/2, doorWidth, innerWall);
		g.fillRect(x0 + width/3, y0 + height/2 + 25, innerWall, doorWidth);
		g.fillRect(x0 + width/3, y0 + height*3/4 + 25, innerWall, doorWidth);
		
		// Outer walls
		g.setColor(Color.BLACK);
		g.fillRect(x0, y0, outerWall, height);
		g.fillRect(x0 + width - outerWall, y0, outerWall, height);
		g.fillRect(x0, y0, width, outerWall);
		g.fillRect(x0, y0 + height - outerWall, width, outerWall);
		
		// Outer doors and windows
		g.setColor(Color.LIGHT_GRAY);
		g.fillRect(x0 + width/2 - doorWidth, y0 + height - outerWall, doorWidth, outerWall);	// Entrance
		g.fillRect(x0 + width/5 - doorWidth, y0 + height - outerWall, doorWidth, outerWall);	// Bathroom
		g.fillRect(x0 + width/2 - doorWidth, y0, 2 * doorWidth, outerWall);						// Terrance
		g.fillRect(x0, y0 + height/5, outerWall, doorWidth);									// Kitchen
		g.fillRect(x0 + width - outerWall, y0 + height/5, outerWall, doorWidth);				// Living room
		g.fillRect(x0, y0 + height/2 + 25, outerWall, doorWidth);								// Utility room
		
		// Labels
		g.setColor(Color.BLACK);
		g.drawString("Kitchen", x0 + 40, y0 + height/4);
		g.drawString("Utility room", x0 + 40, y0 + height/2 + 45);
		g.drawString("Bathroom", x0 + 40, y0 + height*3/4 + 45);
		g.drawString("Entrance", x0 + width/2 - doorWidth, y0 + height*3/4 + 45);
		g.drawString("Living room", x0 + width * 3/4, y0 + height/4);
	}
	
	private void drawAlarmSystem(Graphics g) {
		g.setColor(Color.LIGHT_GRAY);
		g.fillRect(350, 250, 25, 50);

		if (system.isAlarm()) {
			g.setColor(Color.RED);
		} else if (system.isSwitchedOn()) {
			g.setColor(Color.GREEN);
		} else {
			g.setColor(Color.GRAY);
		}
		g.fillRect(350, 255, 25, 10);

		g.setColor(Color.GRAY);
		g.drawRect(350, 250, 25, 50);
		g.drawLine(355,  280, 370, 280);
		g.drawLine(355,  285, 370, 285);
		g.drawLine(355,  290, 370, 290);
}
}