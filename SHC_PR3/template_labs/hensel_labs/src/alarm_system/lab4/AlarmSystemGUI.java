package alarm_system.lab4;

import java.awt.Container;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class AlarmSystemGUI implements Observer, ActionListener {
	private JFrame frame;
	private MyPaintPanel paintPanel;
	private AlarmSensor sensor;
	private AlarmSystem system;
	private String pin = "";
	
	public AlarmSystemGUI() {
		system = new AlarmSystem(2016);
		sensor = new AlarmSensor("Window");
		system.addSensor(sensor);
		system.setObserver(this);
		
		createGUI();
	}

	private void createGUI() {
		// Create frame and set properties
		frame = new JFrame("Alarm system");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setLocationByPlatform(true);

		// Add contents
		paintPanel = new MyPaintPanel(system);

		JButton buttonOpenWindow = new JButton("Open window");
		buttonOpenWindow.setActionCommand("Open window");
		buttonOpenWindow.addActionListener(this);
		
		JPanel controlsPanel = new JPanel();
		controlsPanel.setLayout(new BoxLayout(controlsPanel, BoxLayout.Y_AXIS));
		controlsPanel.add(createNumberPanel());
		controlsPanel.add(new JPanel());
		controlsPanel.add(buttonOpenWindow);
		controlsPanel.add(new JPanel());

		Container contentPane = frame.getContentPane();
		frame.setLayout(new BoxLayout(contentPane, BoxLayout.X_AXIS));
		frame.add(paintPanel);
		frame.add(controlsPanel);

		frame.pack();
		frame.setVisible(true);
	}
	
	private JPanel createNumberPanel() {
		// Create buttons
		JButton[] digitButtons = new JButton[10];
		for (int i = 0; i< digitButtons.length; i++) {
			digitButtons[i] = new JButton(Integer.toString(i));
			digitButtons[i].setActionCommand(Integer.toString(i));
			digitButtons[i].addActionListener(this);
		}

		JButton buttonOn = new JButton("On");
		JButton buttonClear = new JButton("Clear");		
		buttonOn.setActionCommand("SwitchOn");
		buttonOn.addActionListener(this);
		buttonClear.setActionCommand("Clear");
		buttonClear.addActionListener(this);

		// Layout
		JPanel numberPanel = new JPanel();
		numberPanel.setLayout(new GridLayout(4, 3));
		for (int index : new int[]{7, 8, 9, 4, 5, 6, 1, 2, 3}) {
			numberPanel.add(digitButtons[index]);
		}
		numberPanel.add(buttonOn);
		numberPanel.add(digitButtons[0]);
		numberPanel.add(buttonClear);

		return numberPanel;
	}

	public static void main(String[] args) {
		new AlarmSystemGUI();
	}

	@Override
	public void update(Observable observable) {
		frame.repaint();
	}

	@Override
	public void actionPerformed(ActionEvent event) {
		String command = event.getActionCommand();
		
		if (command.equalsIgnoreCase("SwitchOn")) {
			system.switchOn();
			pin = "";
		} else if (command.equalsIgnoreCase("Clear")) {
			pin = "";
			System.out.println("Resetting code");
		} else if (command.equalsIgnoreCase("Open window")) {
			sensor.trigger();
		} else {
			if (system.isSwitchedOn()) {
				pin += command;
				System.out.println("Entered code: " + pin);
				system.switchOff(Integer.parseInt(pin));

				if (!system.isSwitchedOn()) {
					pin = "";
					JOptionPane.showMessageDialog(frame, "System deactivated", "Deactivate system", JOptionPane.INFORMATION_MESSAGE);
				}
				if (pin.length() == 4) {
					pin = "";
					JOptionPane.showMessageDialog(frame, "Incorrect code", "Deactivate system", JOptionPane.WARNING_MESSAGE);
					System.out.println("Incorrect code");
				}
			} else {
				System.out.println("System is switched off. No code required.");
				pin = "";				
			}
		}
		
	}
}
