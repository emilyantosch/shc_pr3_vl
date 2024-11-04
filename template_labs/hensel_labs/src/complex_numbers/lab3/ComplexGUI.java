package complex_numbers.lab3;

import java.io.*;
import java.util.Random;
import java.awt.event.*;
import java.awt.Container;
import java.awt.Dimension;

import javax.swing.*;
import javax.swing.border.BevelBorder;
import javax.swing.event.*;

/** GUI with list and drawing of complex numbers.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class ComplexGUI implements ActionListener, ListSelectionListener {

	private String lastListFileName = "D:/ComplexGUI.ser";
	private JFrame frame;						// GUI main frame
	private ComplexList complexList;			// List of complex numbers (list + GUI)
	private JTextField textReal, textImag;		// Text fields to add new complex number to list
	private JLabel labelSum, labelProduct;		// Labels to display sum and product of selected numbers to GUI
	private ComplexDrawPanel drawPanel;					// GUI panel containing drawing of complex numbers in list
	
	/** Constructor (creates GUI)
	 */
	public ComplexGUI() {
		// Create frame and set properties
		frame = new JFrame("exercises_wip.imaging_dft.Complex Numbers");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(400, 300);
		frame.setLocation(50, 50);

		// Create list of complex numbers
		complexList = new ComplexList();
		JScrollPane numberPane = new JScrollPane(complexList.getList());
		numberPane.setPreferredSize(new Dimension(175, 130));
		
		// Create text entry panel
		JPanel textPanel = new JPanel();
		JButton buttonAdd = new JButton("Add");
		textReal = new JTextField("");
		textImag = new JTextField("");
		
		textPanel.setLayout(new BoxLayout(textPanel, BoxLayout.X_AXIS));
		textPanel.add(buttonAdd);
		textPanel.add(new JLabel(" = "));
		textPanel.add(textReal);
		textPanel.add(new JLabel(" + "));
		textPanel.add(textImag);
		textPanel.add(new JLabel(" *i "));

		// Create button panel
		JPanel buttonPanel = new JPanel();
		JButton buttonAddRandom = new JButton("Add random");
		JButton buttonDelete = new JButton("Delete");
		JButton buttonLoad = new JButton("Load");
		JButton buttonStore = new JButton("Store");
			
		buttonPanel.setLayout(new BoxLayout(buttonPanel, BoxLayout.Y_AXIS));
		buttonPanel.add(textPanel);
		buttonPanel.add(buttonAddRandom);
		buttonPanel.add(buttonDelete);
		buttonPanel.add(buttonLoad);
		buttonPanel.add(buttonStore);

		// Combine list and button panels
		JPanel listButtonPanel = new JPanel();
		
		listButtonPanel.setLayout(new BoxLayout(listButtonPanel, BoxLayout.X_AXIS));
		listButtonPanel.setBorder(BorderFactory.createBevelBorder(BevelBorder.RAISED));
		listButtonPanel.add(numberPane);
		listButtonPanel.add(buttonPanel);

		// Add elements to content pane
		Container contentPane = frame.getContentPane();
		
		contentPane.setLayout(new BoxLayout(contentPane, BoxLayout.Y_AXIS));
		contentPane.add(listButtonPanel);

		labelSum = new JLabel();
		labelProduct = new JLabel();
		setSelectionEmpty();
		drawPanel = new ComplexDrawPanel(complexList);
		contentPane.add(new JLabel("Selected number(s):"));
		contentPane.add(labelSum);
		contentPane.add(labelProduct);
		contentPane.add(drawPanel);
		
		// Event handling
		complexList.getList().addListSelectionListener(this);
		buttonAdd.setActionCommand("ButtonAdd");
		buttonAdd.addActionListener(this);
		buttonAddRandom.setActionCommand("ButtonAddRandom");
		buttonAddRandom.addActionListener(this);
		buttonDelete.setActionCommand("ButtonDelete");
		buttonDelete.addActionListener(this);
		buttonLoad.setActionCommand("ButtonLoad");
		buttonLoad.addActionListener(this);
		buttonStore.setActionCommand("ButtonStore");
		buttonStore.addActionListener(this);
		
		frame.pack();
		frame.setVisible(true);
	}

	/** Set text labels for sum and product of selected numbers.
	 */
	private void setSelectionEmpty() {
		labelSum.setText("No number(s) selected");
		labelProduct.setText(" ");
	}

	/** Set text labels for sum and product of selected numbers.
	 * 
	 * @param sum		Sum of complex numbers selected in list
	 * @param product	Product of complex numbers selected in list
	 */
	private void setSelection(Complex sum, Complex product) {
		labelSum.setText("sum = " + sum);
		labelProduct.setText("product = " + product);
	}
	
	/** Load complex list from file (using serialization)
	 * 
	 * @param fileName Name (and path) of file from which to load the list
	 */
	@SuppressWarnings("unchecked")
	private void loadComplexListFromFile(String fileName) {
		try {
			FileInputStream fileStream = new FileInputStream(fileName);
			ObjectInputStream objectStream = new ObjectInputStream(fileStream);
			complexList.getList().setModel((ListModel<Complex>) objectStream.readObject());
			objectStream.close();
		} catch (ClassNotFoundException | IOException e) {
			System.err.println(e);
		}
    }
	
	/** Store complex list in file (using serialization)
	 * 
	 * @param fileName Name (and path) of file in which to store the list
	 */
	private void storeComplexListInFile(String fileName) {
		try {
			FileOutputStream fileStream = new FileOutputStream(fileName);
			ObjectOutputStream objectStream = new ObjectOutputStream(fileStream);
			objectStream.writeObject(complexList.getList().getModel());
			objectStream.close();
		} catch (IOException e) {
			System.err.println(e);
		}
	}
	
	/** Event handling for buttons.
	 * 
	 * @param event Event object (created by runtime)
	 */
	public void actionPerformed(ActionEvent event) {
		// Add specified number to list
		if (event.getActionCommand().equals("ButtonAdd")) {
			double real, imag;

			try {
				real = Double.parseDouble(textReal.getText());
			} catch (NumberFormatException e) {
				System.out.println("Cannot convert real part to double: " + textReal.getText());
				return;
			}
			try {
				imag = Double.parseDouble(textImag.getText());				
			} catch (NumberFormatException e) {
				System.out.println("Cannot convert imaginary part to double: " + textImag.getText());
				return;
			}
			addNumberIfNoDuplicate(new Complex(real, imag));
		}
		
		// Add random number to list
		if (event.getActionCommand().equals("ButtonAddRandom")) {
			Random	random = new Random();
			double	real = Math.round(200.0 * (random.nextDouble() - 0.5)) / 10.0;
			double	imag = Math.round(200.0 * (random.nextDouble() - 0.5)) / 10.0;
			addNumberIfNoDuplicate(new Complex(real, imag));
		}
			
		// Delete selected number(s) from list
		if (event.getActionCommand().equals("ButtonDelete")) {
			int[] indicesToRemove = complexList.getList().getSelectedIndices();
			for (int i = indicesToRemove.length - 1; i >= 0; i--) {
				complexList.getDefaultListModel().remove(indicesToRemove[i]);
			}
		}
		
		// Load list from file (serialization)
		if (event.getActionCommand().equals("ButtonLoad")) {
			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
			fileChooser.setApproveButtonText("Laden");
			fileChooser.setDialogTitle("Komplexe Zahlen laden");
			fileChooser.setSelectedFile(new File(lastListFileName));
			if (fileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
				lastListFileName = fileChooser.getSelectedFile().getPath();
				loadComplexListFromFile(lastListFileName);
			}
		}
		
		// Store list to file (serialization)
		if (event.getActionCommand().equals("ButtonStore")) {
			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
			fileChooser.setApproveButtonText("Speichern");
			fileChooser.setDialogTitle("Komplexe Zahlen speichern");
			fileChooser.setSelectedFile(new File(lastListFileName));
			if (fileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
				lastListFileName = fileChooser.getSelectedFile().getPath();
				storeComplexListInFile(lastListFileName);
			}
		}
		
		// Update drawing
		drawPanel.repaint();
	}

	/** Event handling for list selection changed.
	 * 
	 * @param event Event object (created by runtime)
	 */
	public void valueChanged(ListSelectionEvent event) {
		if (event.getSource() == complexList.getList()) {
			int[] selectedIndices = complexList.getList().getSelectedIndices();
			
			if (selectedIndices.length > 0) {
				Complex sum = complexList.getSelectedSum();
				Complex product = complexList.getSelectedProduct();

				setSelection(sum, product);				
			} else {
				setSelectionEmpty();
			}
		}
		
		// Update drawing
		drawPanel.repaint();
	}
	
	/** Add number to list unless the number is already in the list.
	 * 
	 * @param z exercises_wip.imaging_dft.Complex number to add
	 */
	private void addNumberIfNoDuplicate(Complex z) {
		int listModelSize = complexList.getDefaultListModel().getSize();

		for (int i = 0; i < listModelSize; i++) {
			if (z.equals(complexList.getDefaultListModel().elementAt(i))) {
				System.out.println("Number not added (already in list): " + z);
				return;
			}
		}
		complexList.getDefaultListModel().addElement(z);
	}
	
	/** Application starting point.
	 * 
	 * @param args Command-line parameters
	 */
	public static void main(String[] args) {
		new ComplexGUI();
	}
}

