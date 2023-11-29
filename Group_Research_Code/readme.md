# This folder content all the code need for this project
### unzip the data from the zip file, those are the input data for python sentiment code
### For "input_csv_path = "path\\to\\the\\Covid-19 Twitter Dataset (Apr-Jun 2020).csv"", df = pd.read_csv('path\\to\\the\\Covid-19 Twitter Dataset (Apr-Jun 2020).csv', encoding='ISO-8859-1', dtype={12: str}, low_memory=False), repalce those path with the one user download and store the unzip file
### For "output_csv_path = "2020_Apr_Jun_sentiment.csv"", "df.to_csv("path\\to\\your\\2020_Apr_Jun_sentiment.csv", index=False)", user can define the path or file name as you want to store the data output
### The sentiment.py are the code generate the sentiment score, the sentiment clean file contain the require data for the R code sentiment part to run, once download the file, replace it with the correct file path inside R.(apple.sent = read_excel("path/to/the/mean.xlsx/file"))
### For "start_date <- as.Date("2022-01-01") and end_date <- as.Date("2022-12-31")" change the date period base on the data use
