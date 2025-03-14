#import "@preview/grape-suite:1.0.0": exercise, colors
#import "@preview/gentle-clues:1.0.0": *
#import exercise: project, task, subtask
#import colors: *

#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#set text(font: "Roboto")

#codly(
  languages: (
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"),
      color: rgb("#CE412B"),
    ),
    c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"),
      icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"),
      color: rgb("#5612EC"),
    ),
  ),
)

#show: project.with(
  type: [Resitklausur],
  suffix-title: [Objektorientiere Programmierung],

  show-point-distribution-in-tasks: true,
  show-namefield: true,
  show-timefield: true,

  max-time: 90,
  show-lines: true,

  show-solutions: true,
  solutions-as-matrix: true,

  university: [HAW Hamburg],
  institute: [SHC - Fakultät TI],
  seminar: [Objektorientiere Programmierung in Java],

  task-type: [Aufgabe],
  extra-task-type: [Extraaufgabe],

  solution-matrix-task-header: [Aufgabe],
  solution-matrix-achieved-points-header: [Erreichte Punkte],

  distribution-header-point-value: [Punkte],
  distribution-header-point-grade: [Wert],

  message: (
    points-sum,
    extrapoints-sum,
  ) => [Insgesamt sind #points-sum + #extrapoints-sum P. erreichbar. Sie haben #box(line(stroke: purple, length: 1cm)) P. von #points-sum P. erreicht.],

  solutions-title: [Lösungsvorschläge],
  timefield: time => [Zeit: #time min.],

  grade-scale: (([sehr gut], 0.9), ([gut], 0.8), ([befriedigend], 0.7), ([ausreichend], 0.6), ([n.b.], 0.59)),
)

= Theoretischer Teil: 45min

#task(
  points: 12,
  [Grundbegriffe],
  [
    Erklären Sie die folgenden fünf Grundbegriffe aus der objektorientierten Programmierung und geben Sie jeweils ein Beispiel an:
    - Klassenmethode
    - Objekt
    - Klasse
    - Methode
    - Attribut
    - Vererbung\
    #box(height: 65%, width: 100%, stroke: color.black)[]
  ],
  [],
  (
    (1, [Methode, die zu einer Klasse gehört und das Keyword `static` hat.]),
    (2, [Objekt als Instanz einer Klasse]),
    (2, [Klasse als Bauplan für ein oder mehr Objekte]),
    (2, [Methode als Funktion oder Fähigkeit einer Klasse/Objekt.]),
    (2, [Attribut als Variable oder Eigenschaft einer Klasse/Objekt.]),
    (2, [Vererbung als Möglichkeit, Code zu organisieren. Weitergabe von Methoden und Attributen.]),
  ),
)

#task(
  [Konzepte der Objektorientieren Programmierung],
  [
    Beschreiben Sie kurz, was die verschiedenen Begriffe und Konzepte in Java bzw. der objektorientieren Programmierung bedeuten.
  ],
  [
    #subtask(points: 5)[
      Definieren Sie den Begriff „Überladen“ (Overloading). Geben Sie ein Beispiel an, das zeigt, wie eine Überladung (Overloading) in Java implementiert wird. Was ist dafür wichtig?\
      #box(height: 80%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Erklären Sie die Unterschiede zwischen einer abstrakten Klasse und einem Interface in Java. Nennen Sie jeweils ein Beispiel für den Einsatz.\
      #box(height: 40%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Was ist ein Thread? Wofür wird dieser verwendet? Geben Sie ein Beispiel für dessen Verwendung an.\
      #box(height: 46%, width: 100%, stroke: color.black)[]
    ]
    #subtask(points: 5)[
      Warum ist es gut, wenn Daten gekapselt werden? Und wie wird diese Datenkapselung erzeugt? Erklären Sie dies und geben Sie ein Beispiel.\
      #box(height: 45%, width: 100%, stroke: color.black)[]
    ]
  ],
  (
    (
      5,
      [Eine Methode, die in der selben Klasse mit unterschiedlichen Implementierungen existieren kann, während sie den gleichen Methodennamen, aber eine andere Signatur trägt.],
    ),
    (
      5,
      [Eine abstrakte Klasse ist eine Klasse, die nicht instanziiert werden kann. Ein Interface ist eine Sammlung aus abstrakten Methoden.],
    ),
    (
      5,
      [Ein weiterer Strang im Programm, der gleichzeitig zu einem anderen Strang Code ausführen kann.],
    ),
    (5, [Klarheit und Struktur, Sicherheit, Wartbarkeit. Kapselung mittels `private`, sowie Getter und Setter.]),
  ),
)
#v(90%)
#task(
  points: 16,
  [Wahr oder Falsch],
  [
    Entscheiden Sie bei den folgenden Aussagen, ob Sie richtig oder falsch sind:
    #table(
      columns: (auto, auto, auto),
      inset: 10pt,
      align: horizon,
      table.header(
        [*Frage*],
        [*Wahr*],
        [*Falsch*],
      ),

      [Eine Klasse kann von mehreren anderen Klassen erben.], [], [],
      [In Java gibt es keine Klassen, sondern nur `struct`s.], [], [],
      [Eine Referenz auf ein Objekt muss immer von genau der selben Klasse sein wie das Objekt selbst.], [], [],
      [Mit ```java public Auto()``` definieren Sie einen Konstruktor für die Klasse ```java Auto```.], [], [],
      [Eine Klasse kann nur maximal ein Interface implementieren.], [], [],
      [Mit dem Schlüsselwort ```java final``` können Sie definieren, dass beispielsweise eine Variable ihren Wert nicht mehr ändern kann.],
      [],
      [],

      [Mit dem Ausdruck ```java let number : i32 = 0;``` definieren Sie eine Variable mit dem Namen ```java number``` und dem Wert `0`.],
      [],
      [],

      [Der Hauptvorteil der Datenkapselung ist es, dass Sie Daten vor unerlaubten Zugriff schützen.], [], [],
    )
  ],
  [],
  (
    (2, [Falsch]),
    (2, [Falsch]),
    (2, [Falsch]),
    (2, [Wahr]),
    (2, [Falsch]),
    (2, [Falsch]),
    (2, [Wahr]),
  ),
)

#pagebreak()
#task(
  [Beschreibung eines bestehenden Programms],
  points: 10,
  [
    In dem folgenden Programmcode wird ein einfaches System erzeugt, in dem Sie Rezepte verarbeiten können. Beschreiben Sie, welche Funktionen mit dem Code abgedeckt werden. Welche Klassen und Methoden sind definiert?
    Fällt Ihnen ein, wie Sie das Programm erweitern könnten?\
    #box(width: 100%, height: 87%, stroke: color.black)[]
    1. Die Klasse ```java Book```
    ```java
    public class Recipe {
        private String name;
        private String category;
        private String recipeId;
        private int prepTimeMinutes;
        private boolean isFavorite;

        public Recipe(String name, String category, String recipeId, int prepTimeMinutes) {
            this.name = name;
            this.category = category;
            this.recipeId = recipeId;
            this.prepTimeMinutes = prepTimeMinutes;
            this.isFavorite = false;
        }

        public String getName() {
            return name;
        }

        public String getCategory() {
            return category;
        }

        public String getRecipeId() {
            return recipeId;
        }

        public int getPrepTimeMinutes() {
            return prepTimeMinutes;
        }

        public boolean isFavorite() {
            return isFavorite;
        }

        public void addToFavorites() {
            if (!isFavorite) {
                isFavorite = true;
                System.out.println(name + " has been added to favorites.");
            } else {
                System.out.println(name + " is already in favorites.");
            }
        }

        public void removeFromFavorites() {
            if (isFavorite) {
                isFavorite = false;
                System.out.println(name + " has been removed from favorites.");
            } else {
                System.out.println(name + " is not in favorites.");
            }
        }

        @Override
        public String toString() {
            return "Recipe: " + name +
                   "\nCategory: " + category +
                   "\nID: " + recipeId +
                   "\nPrep Time: " + prepTimeMinutes + " minutes" +
                   "\nStatus: " + (isFavorite ? "Favorite" : "Regular");
        }
    }
    ```

    #v(90%)
    2. Die Klasse ```java RecipeManager```

    ```java
    import java.util.ArrayList;
    import java.util.List;

    public class RecipeManager {
        private List<Recipe> recipeCollection;

        public RecipeManager() {
            recipeCollection = new ArrayList<>();
        }

        public void addRecipe(Recipe recipe) {
            recipeCollection.add(recipe);
            System.out.println(recipe.getName() + " has been added to your cookbook.");
        }

        public void removeRecipe(String recipeId) {
            Recipe recipeToRemove = findRecipeById(recipeId);
            if (recipeToRemove != null) {
                recipeCollection.remove(recipeToRemove);
                System.out.println(recipeToRemove.getName() + " has been removed from your cookbook.");
            } else {
                System.out.println("Recipe with ID " + recipeId + " not found.");
            }
        }

        public Recipe findRecipeById(String recipeId) {
            for (Recipe recipe : recipeCollection) {
                if (recipe.getRecipeId().equals(recipeId)) {
                    return recipe;
                }
            }
            return null;
        }

        public List<Recipe> findRecipesByCategory(String category) {
            List<Recipe> result = new ArrayList<>();
            for (Recipe recipe : recipeCollection) {
                if (recipe.getCategory().equalsIgnoreCase(category)) {
                    result.add(recipe);
                }
            }
            return result;
        }

        public void displayAllRecipes() {
            if (recipeCollection.isEmpty()) {
                System.out.println("Your cookbook is empty.");
                return;
            }

            System.out.println("Cookbook Collection:");
            for (Recipe recipe : recipeCollection) {
                System.out.println("-------------------");
                System.out.println(recipe);
            }
            System.out.println("-------------------");
        }

        public static void main(String[] args) {
            // Create recipe manager
            RecipeManager cookbook = new RecipeManager();

            // Add some recipes
            cookbook.addRecipe(new Recipe("Spaghetti Carbonara", "Italian", "R001", 30));
            cookbook.addRecipe(new Recipe("Chicken Curry", "Indian", "R002", 45));
            cookbook.addRecipe(new Recipe("Margherita Pizza", "Italian", "R003", 60));
            cookbook.addRecipe(new Recipe("Butter Chicken", "Indian", "R004", 50));

            // Display all recipes
            cookbook.displayAllRecipes();

            // Find recipes by category
            System.out.println("\nItalian Recipes:");
            List<Recipe> italianRecipes = cookbook.findRecipesByCategory("Italian");
            for (Recipe recipe : italianRecipes) {
                System.out.println(recipe.getName() + " (" + recipe.getPrepTimeMinutes() + " minutes)");
            }

            // Add a recipe to favorites
            System.out.println();
            Recipe pizzaRecipe = cookbook.findRecipeById("R003");
            if (pizzaRecipe != null) {
                pizzaRecipe.addToFavorites();
            }

            // Try to add to favorites again
            if (pizzaRecipe != null) {
                pizzaRecipe.addToFavorites();
            }

            // Remove from favorites
            System.out.println();
            if (pizzaRecipe != null) {
                pizzaRecipe.removeFromFavorites();
            }

            // Remove a recipe
            System.out.println();
            cookbook.removeRecipe("R002");

            // Display updated collection
            System.out.println();
            cookbook.displayAllRecipes();
        }
    }
    ```
  ],
  [],
  (
    (2, [Override von `toString`]),
    (2, [Datenkapselung mittels `private` und Getter und Setter]),
    (2, [`ArrayList` statt normalem Array.]),
    (2, [`Scanner` wird als Eingabe über die Kommandozeile verwendet.]),
    (2, [Erweiterungen: Abstrakte-Klassen, Exceptions]),
  ),
)
#pagebreak()

= Praktischer Teil: 45min

#task(
  [Array-Verdopplung],
  [
    Gegeben ist ein Integer-Array `nums` mit der Länge `n`. Ihre Aufgabe ist es, ein neues Array ans mit der Länge `2n` zu erstellen, das folgende Eigenschaften erfüllt:

    Für jeden Index `i`, wobei `0 <= i < n` gilt (nullbasierte Indizierung):
    - `ans[i] == nums[i]` (Die ersten `n` Elemente von `ans` entsprechen exakt dem ursprünglichen Array `nums`)
    - `ans[i + n] == nums[i]` (Die letzten `n` Elemente von `ans` sind eine Wiederholung des Arrays `nums`)

    Anders ausgedrückt: Das Array `ans` ist die Konkatenation (Aneinanderreihung) von zwei identischen `nums` Arrays.
    Beispiel zur Verdeutlichung:
    Wenn `nums = [1, 2, 3]` (hier ist `n = 3`), dann soll `ans = [1, 2, 3, 1, 2, 3]` sein.
    Die ersten drei Elemente (`ans[0], ans[1], ans[2]`) entsprechen den Elementen von nums.
    Die letzten drei Elemente (`ans[3], ans[4], ans[5]`) sind ebenfalls die Elemente von nums.

    Implementiere eine Funktion, die das Array `nums` als Eingabe nimmt und das oben beschriebene Array `ans` zurückgibt.
    Hinweis: Denke daran, dass wir eine nullbasierte Indizierung verwenden, das heißt, der erste Index eines Arrays ist 0, nicht 1.
  ],
  [
    #subtask(points: 3)[
      Legen Sie ein neues Projekt an. Geben Sie dabei dem Projekt einen Namen, der Ihre Matrikelnummer und Ihren Namen enthält.
      Erstellen Sie eine Klasse mit einer Methode, die einen entsprechenden Namen und Parameter sowie Rückgabewert enthält.
    ]
    #subtask(points: 5)[
      Legen Sie eine Variable an, die den Wert des neuen Arrays enthält.
    ]
    #subtask(points: 5)[
      Schreiben Sie eine `for`-Schleife, die durch das gegebene Array iteriert.
    ]
    #subtask(points: 10)[
      Bauen Sie eine Logik ein, die das Array zweimal in das neue Array verlegt.
    ]
    #subtask(points: 5)[
      Lassen Sie sich von der Methode einen Wert zurückgeben, der dem geforderten Array entspricht.
    ]
    #subtask(points: 5)[
      Schreiben Sie eine `main`-Methode, welche die Methode gegen Testinput laufen lässt.
    ]
    #subtask(points: 4)[
      Achten Sie bei der Programmierung Ihrer Lösung auf die gängigen Coding Styles, die in der Vorlesung festgelegt worden sind.
    ]
  ],
  (
    (4, [Der Code hat den richtigen Coding Style und sieht ordentlich aus.]),
    (10, [Der Code funktioniert wie beschrieben und gibt bei richtigem Input eine richtige Antwort zurück.]),
    (
      4,
      [Das Programm ist gegen Fehler durch falsche Eingaben gesichert. Ein nicht definiertes Zeichen führt zu einem Abbruch der Operation.],
    ),
    (
      4,
      [Das Programm ist gegen Fehler durch falsche Eingaben gesichert. Es wurde ein entsprechendes Exception Handling implementiert.],
    ),
    (5, [Es ist ein Projekt mit entsprechendem Namen, sowie eine Klasse und eine Methode angelegt.]),
    (
      5,
      [Die Methode ist entsprechend benannt, hat Parameter und Rückgabewert, die mit der Aufgabenstellung zusammenpassen.],
    ),
    (5, [Es gibt eine main-Methode in einer der Klassen, die ausführbar ist und den Code gegen Testinput testet.]),
  ),
)

