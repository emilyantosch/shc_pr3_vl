package misc.lab2.calendar;

 // TODO Fortlaufende Nutzer-ID über Klassenvariable

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class User extends Person implements Comparable<User> {
	private static int nextID = 1;
	private int userID;
	private Calendar calendar = new Calendar(this);

	public User(String firstName, String surname) {
		super(firstName, surname);
		userID = nextID++;
	}

	public Calendar getCalendar() {
		return calendar;
	}
	
	public int getUserID() {
		return userID;
	}
	
	public static void setNextUserID(int nextID) {
		User.nextID = nextID;
	}

	@Override
	public int compareTo(User other) {
		String thisComp = getSurname() + getFirstName();
		String otherComp = other.getSurname() + other.getFirstName();
		
		return thisComp.compareToIgnoreCase(otherComp);
	}
}
