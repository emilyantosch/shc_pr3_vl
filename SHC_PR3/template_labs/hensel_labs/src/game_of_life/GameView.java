package game_of_life;

import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Arrays;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

/** Graphical user interface for game of life.<br><br>
 * 
 * Implements the user view data (i.e., view in MVC architecture).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GameView implements Observer {
	private GameModel model;
	private GamePanel gamePanel;
	private PopulationPanel populationPanel;
	private JLabel labelGeneration, labelPopulation;
	
	/**
	 * 
	 * @param actionListener
	 * @param model
	 */
	public GameView(ActionListener actionListener, GameModel model) {
		this.model = model;
		
		// Set frame properties
		JFrame frame = new JFrame("Game of Life");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setLocationByPlatform(true);
		frame.setResizable(false);
		
		// Create panels
		gamePanel = new GamePanel(this);
		populationPanel = new PopulationPanel(this);
		
		// Create buttons
		JButton buttonCreateRandom = new JButton("Neue Population");
		buttonCreateRandom.setActionCommand("NewRandom");
		buttonCreateRandom.addActionListener(actionListener);

		JButton buttonNextGeneration = new JButton("Nächste Generation");
		buttonNextGeneration.setActionCommand("NextGeneration");
		buttonNextGeneration.addActionListener(actionListener);

		JButton buttonStartStop = new JButton("Start");
		buttonStartStop.setActionCommand("StartStop");
		buttonStartStop.addActionListener(actionListener);
		
		// Events: Enable / disable buttons
		buttonStartStop.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) {
				if (buttonStartStop.getText().equalsIgnoreCase("Start")) {
					buttonStartStop.setText("Stop");
					buttonCreateRandom.setEnabled(false);
					buttonNextGeneration.setEnabled(false);
				} else {
					buttonStartStop.setText("Start");
					buttonCreateRandom.setEnabled(true);
					buttonNextGeneration.setEnabled(true);
				}
			}
		});

		// Create texts
		labelGeneration = new JLabel("");
		labelPopulation = new JLabel("");
		
		// Layout button panel
		JPanel buttonPanel = new JPanel();
		buttonPanel.setLayout(new GridLayout(1,3));
		buttonPanel.add(buttonCreateRandom);
		buttonPanel.add(buttonNextGeneration);
		buttonPanel.add(buttonStartStop);
		
		// Layout info panel
		JPanel infoPanel = new JPanel();
		infoPanel.setLayout(new GridLayout(2,1));
		infoPanel.add(labelGeneration);
		infoPanel.add(labelPopulation);
		
		// Layout control panel
		JPanel controlPanel = new JPanel();
		controlPanel.setLayout(new BoxLayout(controlPanel, BoxLayout.Y_AXIS));
		controlPanel.add(buttonPanel);
		controlPanel.add(new JLabel(" "));
		controlPanel.add(infoPanel);

		// Layout content pane
		Container contentPane = frame.getContentPane();
		contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.Y_AXIS));
		contentPane.add(gamePanel);
		contentPane.add(controlPanel);
		contentPane.add(populationPanel);
		frame.pack();
		
		// Update data and display frame
		update();
		frame.setVisible(true);
	}
	
	public GameModel getModel() {
		return model;
	}

	/**
	 * 
	 */
	public void update() {
		labelGeneration.setText("Generation: " + model.getGeneration());
		labelPopulation.setText("Population: " + model.getPopulation());
		gamePanel.repaint();
		populationPanel.repaint();
	}
	
	public void onCellClicked(int x, int y) {
		model.toggleCell(x, y);
	}
}

class GamePanel extends JPanel implements MouseListener {
	private int scale = 6;
	private GameView parent;
	
	/**
	 * 
	 * @param parent
	 */
	public GamePanel(GameView parent) {
		this.parent = parent;
		setBackground(Color.white);
		addMouseListener(this);
	}

	@Override
	public Dimension getPreferredSize() {
		int size = scale * parent.getModel().size;
		
		return new Dimension(size, size);
	}

	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);

		// Draw cells in model (each scale x scale pixel in size)
		GameModel model = parent.getModel();

		for (int y = 0; y < model.size; y++) {
			for (int x = 0; x < model.size; x++) {
				if (model.getCell(x, y) == 1) {
					g.fillRect(scale * x, scale * y, scale, scale);
				}
			}
		}
	}

	@Override
	public void mouseClicked(MouseEvent e) {
	}

	@Override
	public void mouseEntered(MouseEvent e) {
	}

	@Override
	public void mouseExited(MouseEvent e) {
	}

	@Override
	public void mousePressed(MouseEvent e) {
	}

	@Override
	public void mouseReleased(MouseEvent e) {
		int x = e.getX() / scale;
		int y = e.getY() / scale;
		parent.onCellClicked(x, y);
	}
}

class PopulationPanel extends JPanel {
	private int width = 200, height = 100;
	private GameView parent;
	
	public PopulationPanel(GameView parent) {
		this.parent = parent;
		setBackground(Color.white);
	}
	
	@Override
	public Dimension getPreferredSize() {
		return new Dimension(width, height);
	}

	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		
		// Init data to draw
		GameModel model = parent.getModel();
		int[] values = model.getPopulationHistory();
		double maxValue = model.getMaxPopulation();

		if (values.length >= getWidth())
			values = Arrays.copyOfRange(values, values.length - getWidth(), values.length);
		
		// Draw
		g.setColor(Color.blue);
		for (int i = 0; i < values.length; i++) {
			g.drawLine(i, height, i, height - (int)(height * values[i] / maxValue));
		}
		g.setColor(Color.red);
		g.drawLine(values.length, 0, values.length, height);
	}
}