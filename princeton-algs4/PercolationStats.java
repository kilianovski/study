import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;

import java.util.ArrayList;
import java.util.List;

public class PercolationStats {
    private double mean;
    private double stddev;
    private double confTerm;

    // perform independent trials on an n-by-n grid
    public PercolationStats(int n, int trials) {


        //
        // Monte Carlo simulation. To estimate the percolation threshold, consider the following computational experiment:
        //
        // 0. Initialize all sites to be blocked.
        // 1. Repeat the following until the system percolates:
        // 1.1. Choose a site uniformly at random among all blocked sites.
        // 1.2. Open the site.
        // The fraction of sites that are opened when the system percolates provides an estimate of the percolation threshold.

        double[] fracs = new double[trials];
        int totalSites = n * n;
        for (int i = 0; i < trials; i++) {
            Percolation percolation = new Percolation(n);

            List<int[]> closedSites = new ArrayList<>();
            for (int row = 1; row <= n; row++) {
                for (int col = 1; col <= n; col++) {
                    closedSites.add(new int[] { row, col });
                }
            }

            while (!percolation.percolates() && !closedSites.isEmpty()) {
                int randomIndex = StdRandom.uniform(closedSites.size());
                int[] site = closedSites.remove(randomIndex);
                percolation.open(site[0], site[1]);
            }
            fracs[i] = (double) percolation.numberOfOpenSites() / totalSites;
        }

        mean = StdStats.mean(fracs);
        stddev = StdStats.stddev(fracs);
        confTerm = (1.96 * stddev) / Math.sqrt(trials);
    }

    // sample mean of percolation threshold
    public double mean() {
        return mean;
    }

    // sample standard deviation of percolation threshold
    public double stddev() {
        return confTerm;
    }

    // low endpoint of 95% confidence interval
    public double confidenceLo() {
        return mean - confTerm;
    }

    // high endpoint of 95% confidence interval
    public double confidenceHi() {
        return mean + confTerm;
    }

    // test client (see below)
    public static void main(String[] args) {
        // main() method that takes two command-line arguments n and T,
        // performs T independent computational experiments (discussed above) on an n-by-n grid,
        // and prints the
        // sample mean,
        // sample standard deviation,
        // and the 95% confidence interval for the percolation threshold
        if (args.length != 2) {
            args = new String[] { "20", "20" };
            // throw new IllegalArgumentException("Two integer arguments required: n and T");
        }
        int n = Integer.parseInt(args[0]);
        int T = Integer.parseInt(args[1]);

        PercolationStats stats = new PercolationStats(n, T);

        System.out.println("Mean                    = " + stats.mean());
        System.out.println("StdDev                  = " + stats.stddev());
        System.out.println(
                "95% confidence interval = [" + stats.confidenceLo() + ", " + stats.confidenceHi()
                        + "]");
    }

}
