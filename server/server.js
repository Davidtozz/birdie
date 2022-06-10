const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const socketio = require("socket.io");
const crypt = require("bcrypt")

const app = express();
app.use(bodyParser.json());
//Create Connections

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "birdie",
});

// const db = mysql.createConnection({
//   host: "birdie-database.cqetlhwo4cwr.eu-central-1.rds.amazonaws.com",
//   user: "root",
//   port: "3306",
//   password: "!Satsuma._.2003!",
//   database: "birdie",
// });

// connect to database
db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log("Database connection successful");
});

app.post("/api/register", (req, res) => {


  const { username, email, psw  } = req.body;
  let sql =  `INSERT INTO user (username, email, psw) VALUES ('${username}', '${email}', '${psw}')`;

  db.query(sql, (err, result) => {

    if (err) {
      res.status(500).send(err);
    } else {
      console.log(`User created: ${username}`);
      console.log(req.body)
      res.status(200).send(result);
    }
  })
 
})



app.post("/messages", (req, res) => {

  //  let message = req.body;
   console.log(req.body.message);

   let sql = "INSERT INTO message (content) VALUES ('"+req.body.message +"');"
   db.query( sql, (err, result) => {
      if (err) {
          throw err;
        }
        console.log(result);
   })
})


app.get("/getmessages", (req, res) => {
  let sql = "SELECT content FROM message";
  db.query(sql, (err, result) => {
    if (err) {
      throw err;
    }

    console.log("\nCurrent chat messages: ", result);
  
    
    // console.log('messages sent: '+element)
    res.send(result);
  })
})


app.post("/addcontact", (req, res) => {
  let contact = req.body;
  console.log(contact);
  
  let sql = "INSERT INTO contact (name) VALUES ('"+contact.name+"');" // ! sql injection issue 
  db.query( sql, (err, result) => {
    if (err) {
      throw err;
  }

  console.log('contact added ' + contact.name)
  res.send(result);

})})

app.get("/getcontacts", (req, res) => {

  let sql = "SELECT name FROM contact";
  db.query(sql, (err,result) => {

    if (err) {
      throw err
    }

    console.log('contacts sent: '+result[0].name)
    res.send(result);

  })
});


app.delete("/deletecontact", (req, res) => {

  let sql = "DELETE FROM contact WHERE name = '"+req.body['name']+"'";
  db.query(sql, (err,result) => {
      
      if (err) {
        throw err
      }
      console.log('Deleted contact: ' + req.body['name'])

      res.send(result);

  })

})


app.listen("3000", () => {
  console.log("Server is successfully running on port 3000");
});