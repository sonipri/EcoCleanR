#' Calculate Harversine distance
#'
#' @param df df is a dataframe with spatial attributes - Latitude and Logitude
#' @param k k is number of cluster required for the data set you have. Normally visual inspection can give a sense on number of clusters. Cautious to have more than expected clusters to fit all data points, as overfitting can end up inluding bad data points in the analysis. e.g. k = 3
#'
#' @return its a dataframe with a new column call
#' @importFrom geosphere distm
#' @importFrom geosphere distHaversine
#'
#' @export
#'
#' @examples
#' data_x <- data.frame(
#'   scientificName = "Mexacanthina lugubris",
#'   decimalLongitude = c(-117, -117.8, -116.9),
#'   decimalLatitude = c(32.9, 33.5, 31.9),
#'   BO_sstmean = c(12, 13, 14),
#'   BO_sstmin = c(9, 6, 10),
#'   BO_sstmax = c(14, 16, 18)
#' )
#' df <- data_x[, c("decimalLatitude", "decimalLongitude")] # selection of spatial attribute in df
#' result <- haversine_kmeans(df, k = 3)
#'
haversine_kmeans <- function(df, k) {
  # Step 1: Randomly select k initial centroids from data points
  initial_idx <- sample(1:nrow(df), k) # Ensure randomness
  centroids <- df[initial_idx, c("decimalLongitude", "decimalLatitude")]

  # Step 2: Compute distances and assign clusters
  dist_matrix <- distm(df[, c("decimalLongitude", "decimalLatitude")], centroids, fun = distHaversine)
  cluster_assignment <- apply(dist_matrix, 1, which.min) # Assign to nearest centroid

  # Step 3: Recompute centroids
  new_centroids <- do.call(rbind, lapply(1:k, function(i) {
    cluster_points <- df[cluster_assignment == i, c("decimalLongitude", "decimalLatitude"), drop = FALSE]
    if (nrow(cluster_points) > 0) colMeans(cluster_points) else centroids[i, ] # Prevent empty clusters
  }))

  # Return both clustered data and centroids
  df$cluster <- cluster_assignment
  return(list(clusters = df, centroids = as.data.frame(new_centroids)))
}
