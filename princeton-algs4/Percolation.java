/* *****************************************************************************
 *  Name:              Ada Lovelace
 *  Coursera User ID:  123456
 *  Last modified:     October 16, 1842
 **************************************************************************** */

 /*
  * Corner cases.  
    -   By convention, the row and column indices are integers between 1 and n, where (1, 1) is the upper-left site: 
        Throw an IllegalArgumentException if any argument to open(), isOpen(), or isFull() is outside its prescribed range. 
        Throw an IllegalArgumentException in the constructor if n ≤ 0.
  */
public class Percolation {

    // creates n-by-n grid, with all sites initially blocked
    private boolean[][] grid;
    private int openSites;

    public Percolation(int n) {
        if (n <= 0) {
            throw new IllegalArgumentException("Grid size must be greater than 0");
        }
        grid = new boolean[n][n];
        openSites = 0;
    }


    // opens the site (row, col) if it is not open already
    public void open(int row, int col) {
        if (row < 1 || row > grid.length || col < 1 || col > grid.length) {
            throw new IllegalArgumentException("Row and column must be within the grid");
        }
        grid[row-1][col-1] = true;
        openSites++;
    }

    // is the site (row, col) open?
    public boolean isOpen(int row, int col) {
        if (row < 1 || row > grid.length || col < 1 || col > grid.length) {
            throw new IllegalArgumentException("Row and column must be within the grid");
        }
        return grid[row-1][col-1];
    }

    // is the site (row, col) full?
    public boolean isFull(int row, int col) {
        if (row < 1 || row > grid.length || col < 1 || col > grid.length) {
            throw new IllegalArgumentException("Row and column must be within the grid");
        }
        return !grid[row-1][col-1];
    }

    // returns the number of open sites
    public int numberOfOpenSites() {
        return openSites;
    }

    // does the system percolate?
    public boolean percolates() {
        return false;
    }
    public static void main(String[] args) {
        Percolation percolation = new Percolation(3);
        percolation.test3Simple();
    }
    // test client (optional)
    private void test3Simple() {
        Percolation p = new Percolation(3);
        boolean initialPercolates = p.percolates();
        p.open(1, 1);
        p.open(2, 1);
        p.open(3, 1);
        boolean finalPercolates = p.percolates();

        if (!initialPercolates && finalPercolates) {
            System.out.println("test3Simple: PASSED ✅");
        } else {
            System.out.println("test3Simple: FAILED ❌");
        }
    }
}
