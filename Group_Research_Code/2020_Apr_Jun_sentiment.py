
from textblob import TextBlob
import pandas as pd
import re

def cleanText(text):
    if not isinstance(text, str):
        return ''  # Return empty string or some placeholder for non-string inputs
    str2 = re.split('RT @\w+: ', text)
    return ' '.join(str2)

def getSentimentPolarity(text):
    testimonial = TextBlob(text)
    return testimonial.sentiment.polarity

def getSentimentSubjectivity(text):
    testimonial = TextBlob(text)
    return testimonial.sentiment.subjectivity



# Replace the file path with the path to your input CSV file
input_csv_path = "c:\\Users\\a9106\\Desktop\\research_paper_code\\Covid-19 Twitter Dataset (Apr-Jun 2020).csv"


# Read the CSV file
df = pd.read_csv('C:\\Users\\a9106\\Desktop\\research_paper_code\\Covid-19 Twitter Dataset (Apr-Jun 2020).csv', encoding='ISO-8859-1', dtype={12: str}, low_memory=False)

df['text'] = df['text'].fillna('')

# Assuming the columns are named 'created_at' and 'text'
df['cleaned_text'] = df['text'].apply(cleanText)
df['Polarity'] = df['cleaned_text'].apply(getSentimentPolarity)
df['Subjectivity'] = df['cleaned_text'].apply(getSentimentSubjectivity)
df['Aggregate Score'] = (df['Polarity'] + df['Subjectivity']) / 2

# Define the output CSV file name
output_csv_path = "2020_Apr_Jun_sentiment.csv"

# Save the dataframe to a new CSV file
df.to_csv("c:\\Users\\a9106\\Desktop\\research_paper_code\\2020_Apr_Jun_sentiment.csv", index=False)

print(df["Polarity"].mean())
print(df["Subjectivity"].mean())
print(df["Aggregate Score"].mean())

print("Sentiment analysis completed")
