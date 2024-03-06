/* *****************************************************************************
 *  Name:              Ada Lovelace
 *  Coursera User ID:  123456
 *  Last modified:     October 16, 1842
 **************************************************************************** */

import edu.princeton.cs.algs4.WeightedQuickUnionUF;

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
    private int topSiteIdx;
    private int bottomSiteIdx;
    private WeightedQuickUnionUF uf;

    public Percolation(int n) {
        if (n <= 0) {
            throw new IllegalArgumentException("Grid size must be greater than 0");
        }
        grid = new boolean[n][n];
        openSites = 0;

        uf = new WeightedQuickUnionUF(n * n + 2);
        topSiteIdx = 0;
        bottomSiteIdx = n * n + 1;

        for (int i = 1; i <= n; i++) {
            uf.union(topSiteIdx, i);
        }

        for (int i = n * n - n + 1; i <= n * n; i++) {
            uf.union(bottomSiteIdx, i);
        }
    }

    private int getIdx(int row, int col) {
        return grid.length * (row - 1) + (col - 1) + 1;
    }


    private void union(int row0, int col0, int row1, int col1) {
        uf.union(getIdx(row0, col0), getIdx(row1, col1));
    }

    // opens the site (row, col) if it is not open already
    public void open(int row, int col) {
        if (row < 1 || row > grid.length || col < 1 || col > grid.length) {
            throw new IllegalArgumentException("Row and column must be within the grid");
        }
        if (isOpen(row, col)) return;
        grid[row - 1][col - 1] = true;


        if (row > 1 && isOpen(row - 1, col)) {
            union(row, col, row - 1, col);
        }

        if (row < grid.length && isOpen(row + 1, col)) {
            union(row, col, row + 1, col);
        }

        if (col > 1 && isOpen(row, col - 1)) {
            union(row, col, row, col - 1);
        }

        if (col < grid.length && isOpen(row, col + 1)) {
            union(row, col, row, col + 1);
        }

        openSites++;
    }

    // is the site (row, col) open?
    public boolean isOpen(int row, int col) {
        if (row < 1 || row > grid.length || col < 1 || col > grid.length) {
            throw new IllegalArgumentException("Row and column must be within the grid");
        }
        return grid[row - 1][col - 1];
    }

    // is the site (row, col) full?
    public boolean isFull(int row, int col) {
        if (row < 1 || row > grid.length || col < 1 || col > grid.length) {
            throw new IllegalArgumentException("Row and column must be within the grid");
        }
        return isOpen(row, col) && uf.find(topSiteIdx) == uf.find(getIdx(row, col));
    }

    // returns the number of open sites
    public int numberOfOpenSites() {
        return openSites;
    }

    // does the system percolate?
    public boolean percolates() {
        return uf.find(topSiteIdx) == uf.find(bottomSiteIdx);
    }

    public static void main(String[] args) {
        Percolation percolation = new Percolation(3);
        percolation.test3Simple();
        percolation.test3Diagonal();
        percolation.test3Backslash();
        percolation.extensiveTesting();
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
        }
        else {
            System.out.println("test3Simple: FAILED ❌");
        }
    }

    private void test3Diagonal() {
        Percolation p = new Percolation(3);
        boolean initialPercolates = p.percolates();
        p.open(1, 1);
        p.open(2, 2);
        p.open(3, 3);
        boolean finalPercolates = p.percolates();

        if (!initialPercolates && !finalPercolates) {
            System.out.println("test3Diagonal: PASSED ✅");
        }
        else {
            System.out.println("test3Diagonal: FAILED ❌");
        }
    }

    private void test3Backslash() {
        Percolation p = new Percolation(3);
        boolean initialPercolates = p.percolates();
        p.open(1, 3);
        p.open(2, 2);
        p.open(3, 1);
        boolean finalPercolates = p.percolates();

        if (!initialPercolates && !finalPercolates) {
            System.out.println("test3Backslash: PASSED ✅");
        }
        else {
            System.out.println("test3Backslash: FAILED ❌");
        }
    }

    /*

    Percolation. Given a composite systems comprised of randomly distributed insulating and metallic materials: what fraction of the materials need to be metallic so that the composite system is an electrical conductor? Given a porous landscape with water on the surface (or oil below), under what conditions will the water be able to drain through to the bottom (or the oil to gush through to the surface)? Scientists have defined an abstract process known as percolation to model such situations.

The model. We model a percolation system using an n-by-n grid of sites. Each site is either open or blocked. A full site is an open site that can be connected to an open site in the top row via a chain of neighboring (left, right, up, down) open sites. We say the system percolates if there is a full site in the bottom row. In other words, a system percolates if we fill all open sites connected to the top row and that process fills some open site on the bottom row. (For the insulating/metallic materials example, the open sites correspond to metallic materials, so that a system that percolates has a metallic path from top to bottom, with full sites conducting. For the porous substance example, the open sites correspond to empty space through which water might flow, so that a system that percolates lets water fill open sites, flowing from top to bottom.)
    *
    * ********************************************************************************
*  TESTING CORRECTNESS
********************************************************************************

Testing correctness of Percolation
*-----------------------------------------------------------
Running 21 total tests.

Tests 1 through 7 create a Percolation object using your code, then repeatedly
open sites by calling open(). After each call to open(), it checks the return
values of isOpen(), percolates(), numberOfOpenSites(), and isFull() in that order.
Tests 12 through 15 create a Percolation object using your code, then repeatedly
call the methods open(), isOpen(), isFull(), percolates(), and, numberOfOpenSites()
in random order with probabilities p = (p1, p2, p3, p4, p5). The tests stop
immediately after the system percolates.

Tests 18 through 21 test backwash.

Except as noted, a site is opened at most once.

Test 1: open predetermined list of sites using file inputs
  * filename = input6.txt
    - isFull() and isOpen() are inconsistent after 0 sites opened
    - student isFull(1, 1) = true
    - student isOpen(1, 1) = false
    - by definition, a full site is open
  * filename = input8.txt
    - isFull() and isOpen() are inconsistent after 0 sites opened
    - student isFull(1, 1) = true
    - student isOpen(1, 1) = false
    - by definition, a full site is open
  * filename = input8-no.txt
    - isFull() and isOpen() are inconsistent after 0 sites opened
    - student isFull(1, 1) = true
    - student isOpen(1, 1) = false
    - by definition, a full site is open
  * filename = input10-no.txt
    - isFull() and isOpen() are inconsistent after 0 sites opened
    - student isFull(1, 1) = true
    - student isOpen(1, 1) = false
    - by definition, a full site is open
  * filename = greeting57.txt
    - isFull() and isOpen() are inconsistent after 0 sites opened
    - student isFull(1, 1) = true
    - student isOpen(1, 1) = false
    - by definition, a full site is open
  * filename = heart25.txt
    - isFull() and isOpen() are inconsistent after 0 sites opened
    - student isFull(1, 1) = true
    - student isOpen(1, 1) = false
    - by definition, a full site is open
==> FAILED
    * */

    // Extensive test cases with emojis and prints
    private void extensiveTesting() {
        System.out.println("🧪 Starting extensive testing...");

        // Test case 1: Check initial state of all sites
        Percolation percolation = new Percolation(10);
        boolean passed = true;
        for (int row = 1; row <= 10; row++) {
            for (int col = 1; col <= 10; col++) {
                if (percolation.isFull(row, col) || percolation.isOpen(row, col)) {
                    System.out.println("❌ Test failed: Initial state of site (" + row + ", " + col
                                               + ") is incorrect.");
                    passed = false;
                }
            }
        }
        if (passed) {
            System.out.println("✅ All sites are initially blocked and not full.");
        }

        // Test case 2: Open a site and check if isFull and isOpen are consistent
        percolation.open(1, 1);
        if (percolation.isFull(1, 1) && percolation.isOpen(1, 1)) {
            System.out.println("✅ Site (1, 1) is correctly open and full.");
        }
        else {
            System.out.println("❌ Test failed: Site (1, 1) is not correctly open and full.");
        }

        // Test case 3: Open more sites and check if the system percolates
        for (int row = 1; row <= 10; row++) {
            percolation.open(row, 1);
        }
        if (percolation.percolates()) {
            System.out.println("✅ System percolates as expected when leftmost column is open.");
        }
        else {
            System.out.println(
                    "❌ Test failed: System does not percolate as expected when leftmost column is open.");
        }

        // Test case 4: Check number of open sites
        int expectedOpenSites = 10; // Only leftmost column is open
        if (percolation.numberOfOpenSites() == expectedOpenSites) {
            System.out.println("✅ Number of open sites is correct: " + expectedOpenSites);
        }
        else {
            System.out.println("❌ Test failed: Number of open sites is incorrect. Expected: "
                                       + expectedOpenSites + ", Got: "
                                       + percolation.numberOfOpenSites());
        }

        System.out.println("🧪 Extensive testing completed.");
    }
}
