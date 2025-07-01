package alarm_system.lab3;

import java.util.ArrayList;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class AlarmSystem implements Observer {
	private ArrayList<AlarmSensor> sensors = new ArrayList<>();
	private int pinCode;
	private boolean isSwitchedOn;
	
	public AlarmSystem(int pinCode) {
		super();
		this.pinCode = pinCode;
	}

	public void addSensor(AlarmSensor sensor) {
		sensors.add(sensor);
		sensor.setObserver(this);
	}
	
	public boolean containsSensor(AlarmSensor sensor) {
		return sensors.contains(sensor);
	}
	
	public void switchOn() {
		isSwitchedOn = true;
	}
	
	public void switchOff(int pinCode) {
		if (pinCode == this.pinCode) {
			isSwitchedOn = false;
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
	}
}
