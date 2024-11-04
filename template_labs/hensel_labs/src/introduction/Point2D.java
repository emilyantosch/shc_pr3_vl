package introduction;

/** Class representing a 2D point with integer values.<br><br>
 *
 * Points a have two components: a = (x, y).<br><br>
 *
 * Author: Marc Hensel (<a href="http://www.haw-hamburg.de/marc-hensel">link</a>)<br>
 * Project: coding_learners_java (<a href="https://github.com/MarcOnTheMoon/coding_learners_java/">link</a>)<br>
 * Copyright: 2024, Marc Hensel<br>
 * Version: 2024.04.17<br>
 * License: CC BY-NC-SA 4.0 (see <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en">link</a>)
 */
public class Point2D {
    int x, y;

    /** Constructor initializing the components.
     *
     * @param x Value of x
     * @param y Value of y
     */
    public Point2D(int x, int y) {
        this.x = x;
        this.y = y;
    }

    /** Standard constructor initializing the components.
     */
    public Point2D() {
        this.x = 0;
        this.y = 0;
    }

    /** Get the x-value.
     *
     * @return value of x-component
     */
    public int getX() {
        return x;
    }

    /** Get the y-value.
     *
     * @return value of y-component
     */
    public int getY() {
        return y;
    }

    /** Add another point to this one.
     *
     * @return this = this + a
     */
    public Point2D add(Point2D a) {
        x += a.x;
        y += a.y;

        return this;
    }

    /** Get the distance of the point from the origin (0, 0).
     *
     * @return Euclidean length sqrt(x^2 + y^2)
     */
    public double getDistanceFromOrigin() {
        return Math.sqrt(x * x + y * y);
    }
}
