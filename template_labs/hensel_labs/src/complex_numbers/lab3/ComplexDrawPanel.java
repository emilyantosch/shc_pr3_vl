package complex_numbers.lab3;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.io.Serial;

import javax.swing.*;

/** Panel to display complex numbers.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
class ComplexDrawPanel extends JPanel {
	@Serial
	private static final long serialVersionUID = 20100521L;
	private ComplexList complexList;
	private int panelSize = 400;
	
	/** Create instance.<p>
	 * 
	 * Marks the panel border with a black line.
	 */
	public ComplexDrawPanel(ComplexList complexList) {
		this.complexList = complexList;
		setBorder(BorderFactory.createLineBorder(Color.black));
	}
	
	/** Set panel size.
	 */
	public Dimension getPreferredSize() {
		return new Dimension(panelSize, panelSize);
	}
	
	/** Clear list and repaint.
	 */
	public void clear() {
		repaint();
	}
	
	/** Repaint: Draw complex numbers in coordinate system.<p>
	 * 
	 * Color code:
	 * - Black: complex number(s) in list
	 * - Blue: complex number(s) selected in list's GUI
	 * - Cyan: sum of all complex number(s) selected in list's GUI
	 * - Magenta: product of all complex number(s) selected in list's GUI
	 */
	public void paintComponent(Graphics g) {
		super.paintComponent(g);

		int border = 20;
		int x0 = panelSize/2,
			y0 = panelSize/2;
		int maxDrawXY = panelSize/2 - border;
		int xMin = x0 - maxDrawXY,
			xMax = x0 + maxDrawXY;
		int yMin = y0 + maxDrawXY,
			yMax = y0 - maxDrawXY;
		
		// Draw coordinate system
		g.drawLine(xMin, y0, xMax, y0);
		g.fillPolygon(new int[]{xMax - 5, xMax, xMax - 5}, new int[]{y0 - 5, y0, y0 + 5}, 3);
		g.drawLine(x0, yMin, x0, yMax);
		g.fillPolygon(new int[]{x0 - 5, x0, x0 + 5}, new int[]{yMax + 5, yMax, yMax + 5}, 3);
		
		// Initialize data to display
		Complex[] arrayAll = complexList.getAllNumbers();
		Complex[] arraySelected = complexList.getSelectedNumbers();
		Complex sum = complexList.getSelectedSum();
		Complex product = complexList.getSelectedProduct();
		
		// Find maximum (scale drawing)
		double maxAbsXY = 0.0;

		if (arraySelected.length > 0) {
			double maxAbsSumXY = Math.max(Math.abs(sum.getReal()), Math.abs(sum.getImag()));
			double maxAbsProductXY = Math.max(Math.abs(product.getReal()), Math.abs(product.getImag()));
			maxAbsXY = Math.max(maxAbsSumXY, maxAbsProductXY);
		}
		for (Complex z : arrayAll) {
			double thisMax = Math.max(Math.abs(z.getReal()), Math.abs(z.getImag()));
			maxAbsXY = Math.max(maxAbsXY, thisMax);
		}
		double scale = maxDrawXY / maxAbsXY;

		// Display all complex numbers in list
		g.setColor(Color.black);
		for (Complex z : arrayAll) {
			g.drawLine(x0, y0, x0 + (int)Math.round(scale * z.getReal()), y0 - (int)Math.round(scale * z.getImag()));
		}
		
		// Display selected complex numbers
		if (arraySelected.length > 0) {
			// Display selected complex numbers in blue color
			g.setColor(Color.blue);
			for (Complex z : arraySelected) {
				g.drawLine(x0, y0, x0 + (int)Math.round(scale * z.getReal()), y0 - (int)Math.round(scale * z.getImag()));
			}
			
			// Display sum and product
			g.setColor(Color.cyan);
			g.drawLine(x0, y0, x0 + (int)Math.round(scale * sum.getReal()), y0 - (int)Math.round(scale * sum.getImag()));
			g.setColor(Color.magenta);
			g.drawLine(x0, y0, x0 + (int)Math.round(scale * product.getReal()), y0 - (int)Math.round(scale * product.getImag()));
		}		
	}

}
