package misc.lab2.calendar;

import java.util.ArrayList;

/** Sample solution for lab assignment.<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.01.31<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class Calendar implements Ownable {
	private User owner;
	private ArrayList<CalendarItem> items = new ArrayList<>();
	
	public Calendar(User owner) {
		this.owner = owner;
	}
	
	@Override
	public Person getOwner() {
		return owner;
	}
	
	public CalendarItem[] getItems() {
		return items.toArray(new CalendarItem[items.size()]);
	}

	public CalendarItem createItem(String subject, DateTime dateTime, int durationInMinutes, User[] participants) {
		CalendarItem item = new CalendarItem(subject, owner, dateTime, durationInMinutes);
		
		for (User participant : participants) {
			item.addParticipant(participant);
			participant.getCalendar().addItem(item);
		}
		items.add(item);
		
		return item;
	}

	private void addItem(CalendarItem item) {
		// TODO Doppelte ausschlie�en?
		items.add(item);
	}
	
	public void removeItem(CalendarItem item) {
		for (int i = 0; i < items.size(); i++) {
			CalendarItem listItem = items.get(i);
			if (listItem == item) {
				// Owner => Delete complete meeting
				if (item.getOwner() == owner) {
					User[] participants = item.getParticipants();
					
					for (User participant : participants) {
						participant.getCalendar().removeItem(item);
					}
					items.remove(item);
					
				// Participant => Remove calendar owner from list of participants
				} else {
					item.removeParticipant(owner);
					items.remove(item);
				}
			}
		}
	}

	@Override
	public String toString() {
		String output = "";
		
		output += String.format("*** Calendar of %s ***\n", owner);
		for (CalendarItem item : items) {
			output += item + "\n";
		}
		
		return output;
	}
}
