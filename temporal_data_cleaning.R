##############################################
# Code author/compiiler: Erin Stearns
# Code objective: Functions for transforming time-related components of data
# Date: 8.24.17
#############################################



# --------------------------------- Functions inherited from Lola ------------------------------------------
#Use plyr package to apply "approx" function to subgroups
#Source: https://stackoverflow.com/questions/23326186/interpolation-within-groups

# Notes from source:
# time_interpolate is a helper function for TimeInterpolateByGroup
# that operates on each of the groups. In the input to this function,
# the GroupingVariable column of the data frame should be single-valued.
# The function returns a (probably longer) data frame, with estimated
# values for the times specified in the output_times array.
time_interpolate <- function(data_frame,
                             GroupingVariable,
                             time_var,
                             output_times) {
  input_times <- data_frame[, time_var]
  exclude_vars <- c(time_var, GroupingVariable)
  value_vars <- setdiff(colnames(data_frame), exclude_vars)
  output_df <- data.frame(rep(data_frame[1,GroupingVariable], length(output_times)), output_times)
  colnames(output_df) <- c(GroupingVariable, time_var)
  for (value_var in value_vars) {
    output_df[,value_var] <- approx(input_times, data_frame[, value_var], output_times)$y
  }
  return(output_df)
}

TimeInterpolateByGroup <- function(DataFrame, 
                                   GroupingVariable, 
                                   TimeVariable,
                                   TimeInterval){
  min_time <- min(DataFrame[, TimeVariable])
  max_time <- max(DataFrame[, TimeVariable])
  output_times <- seq(from=min_time, to=max_time, by=TimeInterval)
  ddply(DataFrame,
        GroupingVariable,
        time_interpolate,
        GroupingVariable=GroupingVariable,
        time_var=TimeVariable,
        output_times=output_times)
}

# ------------------------------------------------------------------------------------------------------------