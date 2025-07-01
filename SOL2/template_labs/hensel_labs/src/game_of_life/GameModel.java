package game_of_life;

import java.util.ArrayList;

/** Model class for game of life.<br><br>
 * 
 * Contains the game data (i.e., model in MVC architecture).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class GameModel extends Subject {
	public final int size;
	private int generation;
	private ArrayList<Integer> populationHistory;
	private int[][] data;
	private int[][] lastData;

	/**
	 * 
	 * @param size
	 */
	public GameModel(int size) {
		super();
		this.size = size;

		// Create empty data
		generation = 1;
		data = new int[size][size];
		lastData = new int[size][size];
		populationHistory = new ArrayList<>();
		populationHistory.add(0);
		
		// Update view
		notifyObserver();
	}
	
	/**
	 * 
	 * @param x
	 * @param y
	 * @return
	 */
	public int getCell(int x, int y) {
		return data[y][x];
	}
	
	/**
	 * 
	 * @return
	 */
	public int getGeneration() {
		return generation;
	}

	/**
	 * 
	 * @return
	 */
	public int getPopulation() {
		int count = 0;
		
		for (int y = 0; y < size; y++) {
			for (int x = 0; x < size; x++) {
				count += data[y][x];
			}
		}

		return count;
	}
	
	public int getMaxPopulation() {
		int max = 0;
		
		for (Integer population : populationHistory) {
			if (population > max)
				max = population;
		}
		return max;
	}
	
	public int[] getPopulationHistory() {
		int[] history = new int[populationHistory.size()];
		
		for (int i = 0; i < history.length; i++)
			history[i] = populationHistory.get(i);
		return history;
	}

	/**
	 * 
	 * @param percentageCells
	 */
	public void initRandomPopulation(int percentageCells) {
		// Init data randomly
		for (int y = 0; y < size; y++) {
			for (int x = 0; x < size; x++) {
				data[y][x] = (100. * Math.random() > percentageCells) ? 0 : 1;
			}
		}
		
		// Reset generation counter and population history
		generation = 1;
		populationHistory.clear();
		populationHistory.add(getPopulation());
		
		// Update view
		notifyObserver();
	}
	
	public void toggleCell(int x, int y) {
		if (x < size && y < size)
			data[y][x] = (data[y][x] == 0) ? 1 : 0;
		populationHistory.remove(populationHistory.size() - 1);		// Remove last element in history
		populationHistory.add(getPopulation());
		
		// Update view
		notifyObserver();
	}
	
	/**
	 * 
	 */
	public void next() {
		int[][] nextData = lastData;

		createNextGeneration(nextData);
		
		lastData = data;
		data = nextData;
		generation++;
		populationHistory.add(getPopulation());
		
		// Update view
		notifyObserver();
	}
	
	/**
	 * 
	 * @param a
	 * @param x0
	 * @param x1
	 * @param y0
	 * @param y1
	 * @return
	 */
	private int subMatrixSum(int[][] a, int x0, int x1, int y0, int y1) {
		int sum = 0;
		for (int y = y0; y <= y1; y++) {
			for (int x = x0; x <= x1; x++) {
				sum += a[y][x];
			}
		}
		return sum;
	}
	
	/**
	 * 
	 * @param x
	 * @param y
	 * @return
	 */
	private int countNeighbors(int x, int y) {
		// Stay within array borders
	    int x0 = Math.max(x - 1, 0);
	    int y0 = Math.max(y - 1, 0);
	    int x1 = Math.min(x + 1, size - 1);
	    int y1 = Math.min(y + 1, size - 1);
	    
	    return subMatrixSum(data, x0, x1, y0, y1) - data[y][x];
	}

	/**
	 * 
	 * @param nextData
	 */
	private void createNextGeneration(int[][] nextData) {
		for (int y = 0; y < size; y++) {
			for (int x = 0; x < size; x++) {
				int neighbors = countNeighbors(x, y);
				
				if ((data[y][x] == 0) && (neighbors == 3))
					nextData[y][x] = 1;
				else if ((data[y][x] == 1) && (neighbors == 2 || neighbors == 3))
					nextData[y][x] = 1;
				else
					nextData[y][x] = 0;
			}
	    }
	}
}
