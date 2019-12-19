#' Map Factors Based on Pareto Arguments
#' @param factor1 A factor.
#' @param factor2 A factor.
#' @param pareto A vector of 2 numbers.
#' @return A dataframe with factor 1 and factor 2 as columns. Based on the pareto arguments passed, the column factor 1 is mapped to factor 2.
buildPareto <- function(factor1, factor2, pareto)
{
  #Exception handling.
  paretoTotal <- (pareto[1]+pareto[2]);
  if(paretoTotal != 100)
  {
    stop("Pareto values must add up to 100. For example, pareto = c(80,20)");
  }

  #randomise the sequence of the factors
  factor1Shuffled <- sample(factor1);
  factor2Shuffled <- sample(factor2);

  #format the split thresholds
  split1 <- pareto[1]*0.01;
  split2 <- pareto[2]*0.01;

  #split factor1 by the given split
  factor1sample1 <- sample.int(n = length(factor1Shuffled), size = floor(split1*length(factor1Shuffled)), replace = F);
  factor1p1 <- factor1Shuffled[factor1sample1];
  factor1p2 <- factor1Shuffled[-factor1sample1];

  #split factor2 by the given split
  factor2sample1 <- sample.int(n = length(factor2Shuffled), size = floor(split1*length(factor2Shuffled)), replace = F);
  factor2p1 <- factor2Shuffled[factor2sample1];
  factor2p2 <- factor2Shuffled[-factor2sample1];

  #map the factors based on the thresholds. map 80 to 20 and then 20 to 80
  map1 <- sample(factor1p2, size = length(factor2p1), replace = TRUE,prob = NULL);
  dfMap1 <- data.frame(factor2p1, map1);
  names(dfMap1) <- c("factor2","factor1")

  map2 <- sample(factor1p1, size = length(factor2p2), replace = TRUE,prob = NULL);
  dfMap2 <- data.frame(factor2p2, map2);
  names(dfMap2) <- c("factor2","factor1")

  #build the final dataframe
  dfMapFinal <- rbind(dfMap1, dfMap2);

  return(dfMapFinal)
}