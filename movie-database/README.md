Movie Rental Database Project

Project Overview

This project simulates a movie rental system and focuses on managing and analyzing data in MongoDB. The system includes three main collections:
- Movies: Stores movie details such as title, genre, release year, and director.
- Customers: Contains customer information like name, email, phone number, and address.
- Rentals: Records rental transactions, including movie titles, customer details, rental dates, and fees.

---

Data Description

Data Files
- `movies_data.csv`: Contains information about 50 movies.
- `customers_data1.csv` and `customers_data2.csv`: Contains information about 100 customers in total.
- `rentals_segment1.csv`, `rentals_segment2.csv`, and `rentals_segment3.csv`: Three segments of rental history, totaling 150 records.

---

How to Use

1. Set up MongoDB Atlas and Shell:

- Link to sign up / log into MongoDB Atlas: account.mongodb.com/account/login
- Link to install MongoDB Shell if you don't already have it: mongodb.com/try/download/shell

2. Setup the database: 

To set up the database, first you must connect your MongoDB Shell by logging into MongoDBAtlas to obtain the connection link to your project, then pasting it into MongoDBShell. Once you input the connection link, you will be prompted for your username password. The username and password is the same as in your Atlas account. Ensure your user has admin access. You can check this in MongoDBAtlas. 

Then, to create a new database you can input in the MongoDBShell command line "use movie_rental_database" - as it doesn't already exist, it will create it for you.

3. Import Data into MongoDB

To create collections and import the CSV file data, using MongoDB Shell input the following commands:

Import the movies data into the "movies" collection
mongoimport --db movie_rental --collection movies --type csv --headerline --file <path_to_file>/movies_data.csv

Import the customers data into the "customers" collection
mongoimport --db movie_rental --collection customers --type csv --headerline --file <path_to_file>/customers_data1.csv
mongoimport --db movie_rental --collection customers --type csv --headerline --file <path_to_file>/customers_data2.csv

Import rental data segments into the "rentals" collection
mongoimport --db movie_rental --collection rentals --type csv --headerline --file <path_to_file>/rentals_segment1.csv
mongoimport --db movie_rental --collection rentals --type csv --headerline --file <path_to_file>/rentals_segment2.csv
mongoimport --db movie_rental --collection rentals --type csv --headerline --file <path_to_file>/rentals_segment3.csv

Alternatively, you can insert the data from the JSON files.

In MongoDBShell, insert the following commands to import the data via JSON inserts:

db.movies.insertMany([paste json inserts from movies_data.json here]);
db.customers.insertMany([paste json inserts from customers_data1.json here]); 
db.customers.insertMany([paste json inserts from customers_data2.json here]); 
db.rentals.insertMany([paste json inserts from rentals_segment1.json here]); 
db.rentals.insertMany([paste json inserts from rentals_segment2.json here]); 
db.rentals.insertMany([paste json inserts from rentals_segment3.json here]); 

These commands will automatically create the collections while inserting the data for movies, customers, and rentals, with the applicable schemas.

4. Query Examples

Once your database is populated with info, use MongoDBShell for queries. Examples below:

Find all movies in a specific genre (Sci-Fi):
db.movies.find({ genre: "Sci-Fi" }).pretty();

Find the total rental fees collected from a specific customer. 
  db.rentals.aggregate([
    { $match: { customer_email: "user12@example.com" } },
    { $group: { _id: "$customer_email", total_rental_fees: { $sum: "$rental_fee" } } }
  ]);


Additional queries are included in the accompanying queries.js file.

---

Additional Notes
1. Ensure the file paths in the `mongoimport` commands point to the correct location of your CSV files.
2. Use proper MongoDB connection strings if working with remote databases or specific environments.

---

File Structure
- README.md: Overview, setup, and usage instructions.
- queries.js: Script containing pre-defined MongoDB queries used in the project.
- data/: Directory containing all CSV and JSON data files.
- CSV Files: Data files for movies, customers, and rentals in CSV format.
- JSON files: Data files for movies, customers, and rentals in JSON format

---

Authors

Xuyao Ross Cheng, Olivia Costantino
Email: xcheng37@myseneca.ca, ocostantino1@myseneca.ca