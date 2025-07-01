package complex_numbers.lab3;

import javax.swing.DefaultListModel;
import javax.swing.JList;

/** List of complex numbers with GUI and convenience methods.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
class ComplexList {
	private JList<Complex> list;
	
	/** Create instance (empty list).
	 */
	public ComplexList() {
		list = new JList<>(new DefaultListModel<>());
	}
	
	/** Get the GUI list object.
	 * 
	 * @return The GUI list object
	 */
	public JList<Complex> getList() { return list; }
	
	/** Get the model (containing the data) associated with the list.
	 * 
	 * @return List model containing the list data
	 */
	public DefaultListModel<Complex> getDefaultListModel() {
		return (DefaultListModel<Complex>) list.getModel();
	}
	
	/** Get sum of all complex numbers selected in the list's GUI.
	 * 
	 * @return Sum of all complex numbers selected in the list's GUI
	 */
	public Complex getSelectedSum() {
		int[] selectedIndices = list.getSelectedIndices();
		Complex sum = new Complex(0.0, 0.0);

		for (int index : selectedIndices) {
			Complex z = getDefaultListModel().getElementAt(index);
			sum.add(z);
		}
		return sum;
	}
	
	/** Get product of all complex numbers selected in the list's GUI.
	 * 
	 * @return Product of all complex numbers selected in the list's GUI
	 */
	public Complex getSelectedProduct() {
		int[] selectedIndices = list.getSelectedIndices();
		Complex product = new Complex(1.0, 0.0);

		for (int index : selectedIndices) {
			Complex z = getDefaultListModel().getElementAt(index);
			product.mul(z);
		}
		return product;
	}

	/** Get all numbers in list.
	 * 
	 * @return Array of all numbers stored in list
	 */
	public Complex[] getAllNumbers() {
		int numberElements = getDefaultListModel().getSize();
		Complex[] complexArray = new Complex[numberElements];
		
		for (int i = 0; i < numberElements; i++) {
			complexArray[i] = getDefaultListModel().getElementAt(i);
		}
		return complexArray;
	}

	/** Get all numbers selected in list's GUI.
	 * 
	 * @return Array of all numbers selected in list's GUI
	 */
	public Complex[] getSelectedNumbers() {
		int[] selectedIndices = list.getSelectedIndices();
		Complex[] complexArray = new Complex[selectedIndices.length];
		
		for (int i = 0; i < selectedIndices.length; i++) {
			complexArray[i] = getDefaultListModel().getElementAt(selectedIndices[i]);
		}
		return complexArray;
	}
}
