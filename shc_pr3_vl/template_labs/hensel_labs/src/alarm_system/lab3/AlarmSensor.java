package alarm_system.lab3;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class AlarmSensor implements Observable {
	private String name;
	private Observer observer;

	public AlarmSensor(String name) {
		super();
		this.name = name;
	}

	public Observer getObserver() {
		return observer;
	}
	
	public void trigger() {
		if (observer != null) {
			observer.update(this);
		}
	}

	@Override
	public void setObserver(Observer observer) {
		this.observer = observer;
	}

	@Override
	public String toString() {
		return name;
	}
}
