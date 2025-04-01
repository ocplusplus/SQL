// MongoDB Queries for Movie Rental Database

//Quering Data
// a. Find all movies in a specific genre. - Sci-Fi
db.movies.find({ genre: "Sci-Fi" }).pretty();

// b. Find all movies in a specific year or range of years.
db.movies.find({ release_year: { $gte: 2000, $lte: 2010 } }).pretty();

// c. Find all customers who have rented a movie of a specific genre. 
db.rentals.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_title",
      foreignField: "movie_title",
      as: "movie_details"
    }
  },
  { $unwind: "$movie_details" },
  { $match: { "movie_details.genre": "Action" } },
  { $group: { _id: "$customer_email" } }
]);


// d. Find the total rental fees collected from a specific customer. 
db.rentals.aggregate([
  { $match: { customer_email: "user12@example.com" } },
  { $group: { _id: "$customer_email", total_rental_fees: { $sum: "$rental_fee" } } }
]);


// e. Find the most popular movie(s) based on the number of rentals.
db.rentals.aggregate([
  { $group: { _id: "$movie_title", rental_count: { $sum: 1 } } },
  { $sort: { rental_count: -1 } },
  { $limit: 5 }
]);

//Data Aggregation
// a. Calculate the average rental fee by genre. 
db.rentals.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_title",
      foreignField: "movie_title",
      as: "movie_details"
    }
  },
  { $unwind: "$movie_details" },
  { $group: { _id: "$movie_details.genre", avg_fee: { $avg: "$rental_fee" } } },
  {
    $project: {
      _id: 1,
      avg_fee: { $round: ["$avg_fee", 2] }
    }
  }
]);

// b. Calculate total revenue by month.
db.rentals.aggregate([
  {
    $group: {
      _id: { $month: { $dateFromString: { dateString: "$rental_date" } } },
      total_revenue: { $sum: "$rental_fee" }
    }
  },
  {
    $project: {
      month: {
        $toString: {
          $cond: {
            if: { $lt: ["$_id", 10] },
            then: { $concat: ["0", { $toString: "$_id" }] },
            else: { $toString: "$_id" }
          }
        }
      },
      total_revenue: { $round: ["$total_revenue", 2] }
    }
  },
  { $sort: { month: 1 } }
]);



// c. Find the top 3 most popular genres among customers.
db.rentals.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_title",
      foreignField: "movie_title",
      as: "movie_details"
    }
  },
  { $unwind: "$movie_details" },
  { $group: { _id: "$movie_details.genre", rental_count: { $sum: 1 } } },
  { $sort: { rental_count: -1 } },
  { $limit: 3 }
]);

//Data Update (CRUD)
// a. Update the rental fee for all movies in a specific genre. 
db.movies.updateMany(
  { genre: "Drama" },
  { $set: { rental_fee: 5 } }
);

// b. Update the contact information (phone number and address) for a specific customer.
db.customers.updateOne(
  { customer_email: "user21@example.com" },
  {
    $set: {
      phone: "518-432-4021",
      "address.0.street": "123 Fake Street"
    }
  }
);


