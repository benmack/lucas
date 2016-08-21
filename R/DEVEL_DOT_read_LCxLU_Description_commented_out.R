# fn <- system.file("data/LCxLU_raw.txt", package="lucas")
# raw <- scan(fn, "chracter")
# 
# LCxLU_description <- data.frame("LC"="", "LU"="", "Description"="", stringsAsFactors=F)
# LCxLU_description <- LCxLU_description[-1, , drop=F]
# 
# i = 1 # element in raw
# j = 1 # row in LCxLU_description
# end_of_vector = FALSE
# while (!end_of_vector) {
#   LCxLU_description[j, ] <- ""
#   LCxLU_description$LC[j] <- raw[i]
#   i = i + 1
#   if (raw[i] != "?") {
#     stop(paste0("\"?\" expected. Got \"", raw[i], "\""))
#   } else {
#     i = i+1
#   }
#   LCxLU_description$LU[j] <- raw[i]
#   i = i+1
#   description <- c()
#   while(raw[i] != "?") {
#     description <- c(description, raw[i])
#     i = i+1
#     if (i > length(raw)) {
#       end_of_vector <- TRUE
#       break
#     }
#   }
#   # Delete the last one. This is the LU of the next category.
#   description <- description[1:(length(description)-1)]
#   LCxLU_description$Description[j] <- paste(description, collapse=" ")
#   i = i-1
#   j = j+1
# }
# 
# ans <- c(paste0(paste0("B", 1), 1:9),
#          paste0(paste0("B", 2, 1:3)),
#          paste0(paste0("B", 3, 1:7)),
#          paste0(paste0("B", 4, 1:5)),
#          paste0(paste0("B", 5, 1:5)),
#          paste0(paste0("B", 7, 1:7)),
#          paste0(paste0("B", 8, 1:4)))