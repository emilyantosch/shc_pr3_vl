package misc.lab2.calendar;

import java.util.ArrayList;
import java.util.Collections;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class Users {
	private ArrayList<User> users = new ArrayList<>();
	
	public User createNewUser(String firstName, String surname) {
		User user = new User(firstName, surname);
		users.add(user);
		Collections.sort(users);
		
		return user;
	}
	
	public User[] getUsers() {
		return users.toArray(new User[users.size()]);
	}

	public String toString() {
		String output = "";
		
		for (User user : users) {
			output += String.format("%s\n", user);
		}
		
		return output;
	}
}
