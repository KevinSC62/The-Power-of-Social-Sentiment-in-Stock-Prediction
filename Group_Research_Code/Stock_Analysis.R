rm(list = ls())

library(quantmod)
library(forecast)
library(ggplot2)
library(readxl)

getSymbols("AAPL")
getSymbols("GOOG")
getSymbols("AAPL")
getSymbols("META")
getSymbols("INTC")
getSymbols("TMUS")
getSymbols("AMZN")
getSymbols("DJI")

start = "2020-04-19"
end = "2020-06-09"
apple = window(AAPL$AAPL.Adjusted, start = start, end = end)
google = window(GOOG$GOOG.Adjusted, start = start, end = end)
apple = window(AAPL$AAPL.Adjusted, start = start, end = end)
facebook = window(META$META.Adjusted, start = start, end = end)
intel = window(INTC$INTC.Adjusted, start = start, end = end)
tmo = window(TMUS$TMUS.Adjusted, start = start, end = end)
amazon = window(AMZN$AMZN.Adjusted, start = start, end = end)
djia = window(DJI$DJI.Adjusted, start = start, end = end)

apple.pdiff = apple
for (i in 2:length(apple))
  apple.pdiff[i] = (as.numeric(apple[i]) - as.numeric(apple[i-1])) / as.numeric(apple[i-1])
apple.pdiff = window(apple.pdiff, start = time(apple.pdiff[2]))

google.pdiff = google
for (i in 2:length(google))
  google.pdiff[i] = (as.numeric(google[i]) - as.numeric(google[i-1])) / as.numeric(google[i-1])
google.pdiff = window(google.pdiff, start = time(google.pdiff[2]))

apple.pdiff = apple
for (i in 2:length(apple))
  apple.pdiff[i] = (as.numeric(apple[i]) - as.numeric(apple[i-1])) / as.numeric(apple[i-1])
apple.pdiff = window(apple.pdiff, start = time(apple.pdiff[2]))

facebook.pdiff = facebook
for (i in 2:length(facebook))
  facebook.pdiff[i] = (as.numeric(facebook[i]) - as.numeric(facebook[i-1])) / as.numeric(facebook[i-1])
facebook.pdiff = window(facebook.pdiff, start = time(facebook.pdiff[2]))

intel.pdiff = intel
for (i in 2:length(intel))
  intel.pdiff[i] = (as.numeric(intel[i]) - as.numeric(intel[i-1])) / as.numeric(intel[i-1])
intel.pdiff = window(intel.pdiff, start = time(intel.pdiff[2]))

tmo.pdiff = tmo
for (i in 2:length(tmo))
  tmo.pdiff[i] = (as.numeric(tmo[i]) - as.numeric(tmo[i-1])) / as.numeric(tmo[i-1])
tmo.pdiff = window(tmo.pdiff, start = time(tmo.pdiff[2]))

amazon.pdiff = amazon
for (i in 2:length(amazon))
  amazon.pdiff[i] = (as.numeric(amazon[i]) - as.numeric(amazon[i-1])) / as.numeric(amazon[i-1])
amazon.pdiff = window(amazon.pdiff, start = time(amazon.pdiff[2]))

djia.pdiff = djia
for (i in 2:length(djia))
  djia.pdiff[i] = (as.numeric(djia[i]) - as.numeric(djia[i-1])) / as.numeric(djia[i-1])
djia.pdiff = window(djia.pdiff, start = time(djia.pdiff[2]))

apple.pdiff.corrected = apple.pdiff - djia.pdiff
google.pdiff.corrected = google.pdiff - djia.pdiff
apple.pdiff.corrected = apple.pdiff - djia.pdiff
facebook.pdiff.corrected = facebook.pdiff - djia.pdiff
intel.pdiff.corrected = intel.pdiff - djia.pdiff
tmo.pdiff.corrected = tmo.pdiff - djia.pdiff
amazon.pdiff.corrected = amazon.pdiff - djia.pdiff

dat = cbind(apple.pdiff, google.pdiff, apple.pdiff, facebook.pdiff, intel.pdiff, tmo.pdiff, amazon.pdiff, djia.pdiff)
colnames(dat) = c("Apple", "Google", "Tesla", "Facebook", "Intel", "T-Mobile", "Amazon", "DJIA")

autoplot(dat)
autoplot(cbind(apple.pdiff.corrected, google.pdiff.corrected, apple.pdiff.corrected, facebook.pdiff.corrected, intel.pdiff.corrected, tmo.pdiff.corrected, amazon.pdiff.corrected))

autoplot(apple.pdiff)
autoplot(cbind(apple.pdiff, djia.pdiff))
autoplot(apple.pdiff.corrected)

#########################
# Import sentiment scores
#########################

apple.sent = read_excel("C:/Users/a9106/Desktop/grouped_2020_Apr_Jun_sentiment.xlsx")
apple.sent$Date = as.Date(apple.sent$Date)
apple.sent = xts(x = cbind(apple.sent$Polarity, apple.sent$Subjectivity, apple.sent$`Aggregate Score`), order.by = apple.sent$Date)
colnames(apple.sent) = c("Polarity", "Subjectivity", "Aggregate.Score")

# Plot
autoplot(cbind(scale(apple.pdiff.corrected), scale(apple.sent)))

df = cbind(scale(apple.pdiff.corrected), scale(apple.sent$Aggregate.Score))
colnames(df) = c("Tesla Stock Movement", "Aggregate Score")
autoplot(df)
df = cbind(scale(apple.pdiff.corrected), -scale(apple.sent$Polarity))
colnames(df) = c("Tesla Stock Movement", "Polarity")
autoplot(df)
df = cbind(scale(apple.pdiff.corrected), scale(apple.sent$Subjectivity))
colnames(df) = c("Tesla Stock Movement", "Subjectivity")
autoplot(df)

# Fit models

acc = function(dat)
{
  sum = 0
  
  for (i in 1:length(dat[,1]))
  {
    if (dat$pred.move[i] == -1)
      if (dat$truth[i] <= -0.005)
        sum = sum + 1
    if (dat$pred.move[i] == 1)
      if (dat$truth[i] >= 0.005)
        sum = sum + 1
    if (dat$pred.move[i] == 0)
      if (-0.01 <= dat$truth[i] & dat$truth[i] <= 0.01)
        sum = sum + 1
  }
  
  return(sum / length(dat[,1]))
}

apple.comb = cbind(apple.pdiff.corrected, apple.sent)
colnames(apple.comb)[1] = "index"
cor(apple.comb$index, apple.comb$Polarity, use = "pairwise.complete.obs")
cor(apple.comb$index, apple.comb$Subjectivity, use = "pairwise.complete.obs")
cor(apple.comb$index, apple.comb$Aggregate.Score, use = "pairwise.complete.obs")
apple.matrix = data.frame(apple.comb)
colnames(apple.matrix) = c("index", "Polarity", "Subjectivity", "Aggregate.Score")
days = nrow(apple.matrix)
Polarity.1 = c(NA, as.vector(apple.comb$Polarity[1:(days-1)]))
Polarity.2 = c(NA, NA, as.vector(apple.comb$Polarity[1:(days-2)]))
Polarity.3 = c(NA, NA, NA, as.vector(apple.comb$Polarity[1:(days-3)]))
Subjectivity.1 = c(NA, as.vector(apple.comb$Subjectivity[1:(days-1)]))
Subjectivity.2 = c(NA, NA, as.vector(apple.comb$Subjectivity[1:(days-2)]))
Subjectivity.3 = c(NA, NA, NA, as.vector(apple.comb$Subjectivity[1:(days-3)]))
apple.matrix = cbind(apple.matrix, Polarity.1, Polarity.2, Polarity.3, Subjectivity.1, Subjectivity.2, Subjectivity.3)
apple.train = window(xts(apple.matrix, order.by = as.Date(rownames(apple.matrix))), end = "2020-4-10")
apple.test = window(xts(apple.matrix, order.by = as.Date(rownames(apple.matrix))), start = "2020-4-11")
apple.lm = lm(index ~ Polarity + Subjectivity, data = apple.matrix)
summary(apple.lm)
apple.lm = lm(index ~ Polarity.1 + Polarity.2 + Polarity.3 + Subjectivity.1 + Subjectivity.2 + Subjectivity.3, data = apple.train)
summary(apple.lm)
df = cbind(xts(predict(apple.lm, newdata = apple.train), order.by = time(apple.train)), window(apple.pdiff.corrected, end = "2020-4-10"))
colnames(df) = c("Predicted Stock Movement", "Actual Stock Movement")
autoplot(df) + ggtitle("Training Data")
pred = predict(apple.lm, newdata = apple.test)
df = cbind(xts(predict(apple.lm, newdata = apple.test), order.by = time(apple.test)), window(apple.pdiff.corrected, start = "2020-4-11"))
colnames(df) = c("Predicted Stock Movement", "Actual Stock Movement")
autoplot(df) + ggtitle("Test Data")
pred.move = ifelse(pred >= 0.005, yes = 1, no = ifelse(pred <= -0.005, yes = -1, no = 0))
pred.move = xts(pred.move, order.by = as.Date(names(pred.move)))
test = cbind(pred.move, window(apple.pdiff.corrected, start = "2020-4-11"))
test = na.omit(test)
colnames(test) = c("pred.move", "truth")
print(acc(test))
pred = predict(apple.lm, newdata = apple.matrix)
df = cbind(xts(pred, order.by = as.Date(rownames(apple.matrix))), apple.pdiff.corrected)
colnames(df) = c("Predicted Stock Movement", "Actual Stock Movement")
autoplot(df) + ggtitle("All Data")
pred.move = ifelse(pred >= 0.005, yes = 1, no = ifelse(pred <= -0.005, yes = -1, no = 0))
pred.move = xts(pred.move, order.by = as.Date(names(pred.move)))
test = cbind(pred.move, apple.pdiff.corrected)
test = na.omit(test)
colnames(test) = c("pred.move", "truth")
print(acc(test))

for (window in 1 + 2*(0:4))
{
  apple.comb.swa = apple.comb
  for (i in floor(window/2):(length(apple.comb.swa$Polarity)-floor(window/2)))
  {
    apple.comb.swa$Polarity[i] = mean(apple.comb$Polarity[(i-floor(window/2)):(i+floor(window/2))])
    apple.comb.swa$Subjectivity[i] = mean(apple.comb$Subjectivity[(i-floor(window/2)):(i+floor(window/2))])
    apple.comb.swa$Aggregate.Score[i] = mean(apple.comb$Aggregate.Score[(i-floor(window/2)):(i+floor(window/2))])
  }
  print(cor(apple.comb.swa$index, apple.comb.swa$Polarity, use = "pairwise.complete.obs"))
  print(cor(apple.comb.swa$index, apple.comb.swa$Subjectivity, use = "pairwise.complete.obs"))
  print(cor(apple.comb.swa$index, apple.comb.swa$Aggregate.Score, use = "pairwise.complete.obs"))
}

# Try with uncorrected stock movement

apple.comb = cbind(apple.pdiff, apple.sent)
colnames(apple.comb)[1] = "index"
window = 3
apple.comb.swa = apple.comb
for (i in floor(window/2):(length(apple.comb.swa$Polarity)-floor(window/2)))
{
  apple.comb.swa$Polarity[i] = mean(apple.comb$Polarity[(i-floor(window/2)):(i+floor(window/2))])
  apple.comb.swa$Subjectivity[i] = mean(apple.comb$Subjectivity[(i-floor(window/2)):(i+floor(window/2))])
  apple.comb.swa$Aggregate.Score[i] = mean(apple.comb$Aggregate.Score[(i-floor(window/2)):(i+floor(window/2))])
}
print(cor(apple.comb.swa$index, apple.comb.swa$Polarity, use = "pairwise.complete.obs"))
print(cor(apple.comb.swa$index, apple.comb.swa$Subjectivity, use = "pairwise.complete.obs"))
print(cor(apple.comb.swa$index, apple.comb.swa$Aggregate.Score, use = "pairwise.complete.obs"))


# Plot

  # Plotting negative because the correlation is negative
df = cbind(scale(apple.pdiff.corrected), -scale(apple.comb.swa$Aggregate.Score))
colnames(df) = c("Tesla Stock Movement", "-Aggregate Score")
autoplot(df)
df = cbind(scale(apple.pdiff.corrected), -scale(apple.comb.swa$Polarity))
colnames(df) = c("Tesla Stock Movement", "-Polarity")
autoplot(df)
df = cbind(scale(apple.pdiff.corrected), -scale(apple.comb.swa$Subjectivity))
colnames(df) = c("Tesla Stock Movement", "-Subjectivity")
autoplot(df)

# Output predictions to file

pred = predict(apple.lm, newdata = apple.matrix)
dat = cbind(pred, ifelse(pred >= 0.005, yes = 1, no = ifelse(pred <= -0.005, yes = -1, no = 0)))
dat = na.omit(dat)
  write.table(x = dat, sep = " ", file = "AAPL-predict.txt")






