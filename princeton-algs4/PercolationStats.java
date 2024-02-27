public class PercolationStats {

    // perform independent trials on an n-by-n grid
    public PercolationStats(int n, int trials) {
        // TODO: implement this constructor
    }

    // sample mean of percolation threshold
    public double mean() {
        // TODO: implement this method
        return 0.0; // dummy output
    }

    // sample standard deviation of percolation threshold
    public double stddev() {
        // TODO: implement this method
        return 0.0; // dummy output
    }

    // low endpoint of 95% confidence interval
    public double confidenceLo() {
        // TODO: implement this method
        return 0.0; // dummy output
    }

    // high endpoint of 95% confidence interval
    public double confidenceHi() {
        // TODO: implement this method
        return 0.0; // dummy output
    }

    // test client (see below)
    public static void main(String[] args) {
        // TODO: implement this test client
        int n = 3; // example grid size
        int trials = 10; // example number of trials

        PercolationStats stats = new PercolationStats(n, trials);
        System.out.println("Mean of percolation threshold: " + stats.mean());
        System.out.println("Standard deviation of percolation threshold: " + stats.stddev());
        System.out.println("Low endpoint of 95% confidence interval: " + stats.confidenceLo());
        System.out.println("High endpoint of 95% confidence interval: " + stats.confidenceHi());
    }

}
