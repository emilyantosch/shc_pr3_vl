package ai_bandit.lab3;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;

class PlotBarPanel extends JPanel {
    private final String title;
    private final int dataWidth, dataHeight, padding;
    private final int[] data;

    public PlotBarPanel(String title, int dataWidth, int dataHeight, int padding, int[] data) {
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
        int y0 = padding + dataHeight;

        // Determine maximum absolute data (scale y-axis)
        int maxAbsData = 0;
        for (int value : data) {
            int absData = Math.abs(value);
            if (absData > maxAbsData)
                maxAbsData = absData;
        }

        // Draw title
        g.drawString(title, x0, 15);

        // Draw data bars
        int barWidth = dataWidth / data.length;
        int xSpace = 40;

        g.setColor(Color.darkGray);
        for (int i = 0; (i < data.length) && (i < dataWidth); i++) {
            int dy = (int)((dataHeight - padding) * (data[i] / (double)maxAbsData));
            g.fillRect(x0 + i * barWidth + xSpace/2, y0 - dy, barWidth - xSpace, dy);
            g.drawString(String.format("%d", data[i]), x0 + i * barWidth + (xSpace/2 + 5), y0 - (dy + 5));
        }

        // Draw axes
        g.setColor(Color.black);
        g.drawLine(x0 - 1, y0, x0 + dataWidth, y0);
        g.drawLine(x0 - 1, y0, x0 -1, y0 - dataHeight);
    }
}
