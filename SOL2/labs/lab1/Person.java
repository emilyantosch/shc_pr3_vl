public class Person {
  String first_name;
  String last_name;
  int day;
  int month;
  int year;

  // Constructor to initialize a person
  public Person(String firstName, String lastName, int d, int m, int y) {
    this.first_name = firstName;
    this.last_name = lastName;
    this.day = d;
    this.month = m;
    this.year = y;
  }

  // Display person information
  public void displayInfo() {
    System.out.println("Name: " + first_name + " " + last_name);
    System.out.println("Name change date: " + day + "." + month + "." + year);
  }

  // Check if three years have passed since last name change
  public boolean canChangeName(int newDay, int newMonth, int newYear) {
    // Calculate years difference
    int yearsDiff = newYear - this.year;

    // If less than 3 years, return false
    if (yearsDiff < 3) {
      return false;
    }

    // If exactly 3 years, check month and day
    if (yearsDiff == 3) {
      if (newMonth < this.month) {
        return false;
      }
      if (newMonth == this.month && newDay < this.day) {
        return false;
      }
    }

    return true;
  }

  // Change person's name
  public void changeName(String newFirst, String newLast, int d, int m, int y) {
    this.first_name = newFirst;
    this.last_name = newLast;
    this.day = d;
    this.month = m;
    this.year = y;
  }
}
