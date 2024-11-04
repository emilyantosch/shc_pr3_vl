package misc.lab2.calendar;

import java.util.ArrayList;

// TODO: Nach Datum sortieren, in Calendar sortierte Ausgabe

public class CalendarItem implements Ownable {
	private String subject;
	private User owner;
	private ArrayList<User> participants = new ArrayList<User>();
	private DateTime dateTime;
	private int durationInMinutes;
	
	public CalendarItem(String subject, User owner, DateTime dateTime, int durationInMinutes) {
		this.subject = subject;
		this.owner = owner;
		this.dateTime = dateTime;
		this.durationInMinutes = durationInMinutes;
	}
	
	public String getSubject() {
		return subject;
	}

	@Override
	public Person getOwner() {
		return owner;
	}

	public User[] getParticipants() {
		return participants.toArray(new User[participants.size()]);
	}

	public DateTime getDateTime() {
		return dateTime;
	}
	
	public int getDurationInMinutes() {
		return durationInMinutes;
	}

	public void addParticipant(User participant) {
		if (!participants.contains(participant)) {
			participants.add(participant);
		}
	}

	public void removeParticipant(User participant) {
		participants.remove(participant);
	}

	@Override
	public String toString() {
		String output = "";
		
		output += String.format("%s (%d min):\n", dateTime, durationInMinutes);
		output += String.format("Subject:\t%s\n", subject);
		output += String.format("Organizer:\t%s\n", owner);
		
		return output;
	}
}
