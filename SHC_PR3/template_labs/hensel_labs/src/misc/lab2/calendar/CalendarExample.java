package misc.lab2.calendar;


/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class CalendarExample {

	public static void main(String[] args) {
		Users users = new Users();
		
		// Create some users
		User hensel = users.createNewUser("Marc", "Hensel");
		User goossen = users.createNewUser("Andreas", "Goossen");
		User someone = users.createNewUser("Someone", "Else");
		System.out.printf("Users:\n------\n%s\n\n", users);

		// Create calendar items
		hensel.getCalendar().createItem(
				"Reserve still hour", new DateTime(2013, 9, 2, 7, 30), 60, new User[]{});
		CalendarItem item1 = hensel.getCalendar().createItem(
				"Align with student tutor", new DateTime(2013, 9, 10, 11, 0), 90, new User[]{goossen, someone});
		CalendarItem item2 = goossen.getCalendar().createItem(
				"Align OP/OPP", new DateTime(2013, 9, 25, 14, 15), 60, new User[]{hensel});
		System.out.println(hensel.getCalendar());
		System.out.println(goossen.getCalendar());
		System.out.println(someone.getCalendar());
		
		// Delete meeting (owner)
		hensel.getCalendar().removeItem(item1);
		goossen.getCalendar().removeItem(item2);
		System.out.println(hensel.getCalendar());
		System.out.println(goossen.getCalendar());
		System.out.println(someone.getCalendar());
		
		
	}

}
