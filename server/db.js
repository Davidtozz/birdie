const mysql = require("mysql");


const db = mysql.createConnection({
    host: "birdie-database.cqetlhwo4cwr.eu-central-1.rds.amazonaws.com",
    user: "root",
    port: "3306",
    password: "",
    database: "birdie-database",
  });
  
  // connect to database
  db.connect((err) => {
    if (err) {
      throw err;
    }
    console.log("Database connection successful");
  });