package alarm_system.lab4;

import java.util.ArrayList;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class AlarmSystem implements Observer, Observable {
	private ArrayList<AlarmSensor> sensors = new ArrayList<>();
	private int pinCode;
	private boolean isSwitchedOn;
	private boolean isAlarm;
	private Observer observer;
	
	public AlarmSystem(int pinCode) {
		super();
		this.pinCode = pinCode;
	}

	public boolean isSwitchedOn() {
		return isSwitchedOn;
	}

	public boolean isAlarm() {
		return isAlarm;
	}

	public void addSensor(AlarmSensor sensor) {
		sensors.add(sensor);
		sensor.setObserver(this);
		updateObserver();
	}
	
	public boolean containsSensor(AlarmSensor sensor) {
		return sensors.contains(sensor);
	}
	
	public void switchOn() {
		isSwitchedOn = true;
		updateObserver();
	}
	
	public void switchOff(int pinCode) {
		if (pinCode == this.pinCode) {
			isSwitchedOn = false;
			isAlarm = false;
			updateObserver();
		}
	}

	public String getStatus() {
		if (isSwitchedOn) {
			return "Anlage scharfgeschaltet";
		} else {
			return "Anlage nicht scharfgeschaltet";
		}
	}

	@Override
	public void update(Observable observable) {
		AlarmSensor sensor = (AlarmSensor) observable;
		System.out.println("<!> Sensor ausgelöst: " + sensor);
		
		if (isSwitchedOn) {
			isAlarm = true;
		}
		updateObserver();
	}

	@Override
	public void setObserver(Observer observer) {
		this.observer = observer;
	}
	
	private void updateObserver() {
		if (observer != null) {
			observer.update(this);
		}
	}
}
