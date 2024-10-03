package ai_bandit.lab3;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

class PlotPanel extends JPanel {
    private static final Color colorGreen = new Color(0, 100, 0);
    private static final Color colorRed = new Color(150, 0, 0);
    private final String title;
    private final int dataWidth, dataHeight, padding;
    private final ArrayList<Double> data;

    public PlotPanel(String title, int dataWidth, int dataHeight, int padding, ArrayList<Double> data) {
        this.title = title;
        this.dataWidth = dataWidth;
        this.dataHeight = dataHeight;
        this.padding = padding;
        this.data = data;
        setBackground(Color.white);
    }

    @Override
    public Dimension getPreferredSize() {
        return new Dimension(dataWidth + 2 * padding, dataHeight + 2 * padding);
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        int x0 = padding;
        int y0 = padding + dataHeight / 2;

        // Determine maximum absolute data (scale y-axis)
        double maxAbsData = 0;
        for (Double value : data) {
            double absData = Math.abs(value);
            if (absData > maxAbsData)
                maxAbsData = absData;
        }

        // Draw title
        g.drawString(String.format("%s (abs. max.: %.2f)", title, maxAbsData), x0, 15);

        // Draw data plot
        g.setColor(Color.blue);
        int indexOffset = (data.size() <= dataWidth) ? 0 : (data.size() - dataWidth);
        for (int i = 0; (i < data.size()) && (i < dataWidth); i++) {
            int dy = (int)((dataHeight / 2) * (data.get(i + indexOffset) / maxAbsData));
            g.setColor((dy > 0) ? colorGreen : colorRed);
            g.drawLine(x0 + i, y0, x0 + i, y0 - dy);
        }

        // Draw axes
        g.setColor(Color.black);
        g.drawLine(x0 - 1, y0, x0 + dataWidth, y0);
        g.drawLine(x0 - 1, y0 - dataHeight/2, x0 -1, y0 + dataHeight/2);
    }
}
