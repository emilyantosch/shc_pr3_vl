package game_of_life;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/** Game of life.<br><br>
 * 
 * Contains the application logic (i.e., control in MVC architecture).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GameOfLife implements ActionListener {
	private static int size = 71;
	private static int randomCellsPercent = 25;
	private static int waitTimeMs = 50;

	private GameModel model;
	private GameView view;
	private PlayThread playThread = null;
	
	public GameOfLife() {
		model = new GameModel(size);
		view = new GameView(this, model);
		
		model.setObserver(view);
		model.initRandomPopulation(randomCellsPercent);
	}

	@Override
	public void actionPerformed(ActionEvent event) {
		String command = event.getActionCommand();
		
		// Create new random population
		if (command.equalsIgnoreCase("NewRandom")) {
			model.initRandomPopulation(randomCellsPercent);
		}
		
		// Start / stop generating next generations
		else if (command.equalsIgnoreCase("StartStop")) {
			if (playThread == null) {
				playThread = new PlayThread(model, view, waitTimeMs);
				playThread.start();
			} else {
				playThread.terminateRun();
				playThread = null;
			}
		}

		// Generate next generation
		else if (command.equalsIgnoreCase("NextGeneration")) {
			model.next();
		}
	}
	
	public static void main(String[] args) {
		new GameOfLife();
	}
}

class PlayThread extends Thread {
	private GameModel model;
	private GameView view;
	private boolean isRun = false;
	private int waitTimeMs;
	
	public PlayThread(GameModel model, GameView view, int waitTimeMs) {
		super();
		this.model = model;
		this.view = view;
		this.waitTimeMs = waitTimeMs;
	}

	public void terminateRun() {
		isRun = false;
	}
	
	@Override
	public void run() {
		isRun = true;
		
		while (isRun) {
			model.next();
			view.update();

			try {
				Thread.sleep(waitTimeMs);
			} catch (InterruptedException e) {
			}
		}		
	}
}