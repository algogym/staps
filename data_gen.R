ambig <- rep(1:3, each=30)

all <- c(NULL)

for(x in 1:40){
    all <- c(all, ambig[sample(1:90)])
}



cond <- factor(all, labels = c("ambig", "eindeutig", "filler"))
               
rt1 <- ifelse(cond == "ambig", rnorm(1200, 400, 75), rnorm(2400, 150, 40 ))
rt2 <- ifelse(cond == "ambig", rnorm(1200, 200, 75), rnorm(2400, 150, 40 ))
rt3 <- ifelse(cond == "ambig", rnorm(1200, 200, 30), rnorm(2400, 200, 30 ))


DT <- data.table(subject = rep(1:20, each=90), phase = rep(1:2, each=1800), cond, rt1, rt2, rt3)

DT[phase == 2, c("rt1","rt2","rt3") := lapply(.SD, function(x) x-rnorm(1800, 25, 2)), .SDcols = c("rt1","rt2","rt3")]

DT[, trial := 1:90]
DT[sample(1:nrow(DT), 20), rt1 := NA]
DT[sample(1:nrow(DT), 14), rt2 := NA]
DT[sample(1:nrow(DT), 17), rt3 := NA]

write.csv(x = DT, file = "test_data.csv", row.names = FALSE)
