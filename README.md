# The-Power-of-Public-Sentiment-in-Stock-Prediction
## This project research content 3 major parent paper's code and 1 research project code file:
## 1. Resaerch code
### This file include all the code for the research paper

## 2. Effectiveness of Artificial Intelligence in Stock Market Prediction based on Machine Learning
### This paper tries to address the problem of stock market prediction leveraging artificial intelligence (AI) strategies. The stock market prediction can be modeled based on two principal analyses called technical and fundamental. In the technical analysis approach, the regression machine learning (ML) algorithms are employed to predict the stock price trend at the end of a business day based on the historical price data. In contrast, in the fundamental analysis, the classification ML algorithms are applied to classify the public sentiment based on news and social media. In the technical analysis, the historical price data is exploited from Yahoo Finance, and in fundamental analysis, public tweets on Twitter associated with the stock market are investigated to assess the impact of sentiments on the stock market's forecast. The results show a median performance, implying that with the current technology of AI, it is too soon to claim AI can beat the stock markets.


## 3. A Word is Worth A Thousand Dollars: Adversarial Attack on Tweets Fools Stock Predictions
### More and more investors and machine learning models rely on social media (e.g., Twitter and Reddit) to gather real-time information and sentiment to predict stock price movements. Although text-based models are known to be vulnerable to adversarial attacks, whether stock prediction models have similar vulnerability is underexplored. In this paper, we experiment with a variety of adversarial attack configurations to fool three stock prediction victim models. We address the task of adversarial generation by solving combinatorial optimization problems with semantics and budget constraints. Our results show that the proposed attack method can achieve consistent success rates and cause significant monetary loss in trading simulation by simply concatenating a perturbed but semantically similar tweet.

## 4.Taureau: A Stock Market Movement Inference Framework Based on Twitter Sentiment Analysis
### With the advent of fast-paced information dissemination and retrieval, it has become inherently important to resort to automated means of predicting stock market prices. In this paper, we propose Taureau, a framework that leverages Twitter sentiment analysis for predicting stock market movement. The aim of our research is to determine whether Twitter, which is assumed to be representative of the general public, can give insight into the public perception of a particular company and has any correlation to that company's stock price movement. We intend to utilize this correlation to predict stock price movement. We first utilize Tweepy and getOldTweets to obtain historical tweets indicating public opinions for a set of top companies during periods of major events. We filter and label the tweets using standard programming libraries. We then vectorize and generate word embedding from the obtained tweets. Afterward, we leverage TextBlob, a state-of-the-art sentiment analytics engine, to assess and quantify the users' moods based on the tweets. Next, we correlate the temporal dimensions of the obtained sentiment scores with monthly stock price movement data. Finally, we design and evaluate a predictive model to forecast stock price movement from lagged sentiment scores. We evaluate our framework using actual stock price movement data to assess its ability to predict movement direction.
