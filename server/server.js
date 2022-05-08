const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");

const app = express();
app.use(bodyParser.json());
//Create Connections

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "birdie",
});


// connect to database
db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log("Database connection successful");
});

app.post("/messages", (req, res) => {

  //  let message = req.body;
   console.log(req.body.message);

   let sql = "INSERT INTO user_messages VALUES ('"+req.body.message +"');"
   db.query( sql, (err, result) => {
      if (err) {
          throw err;
        }
        console.log(result);
   })
  //  console.log(message);

})


app.get("/getmessages", (req, res) => {
  let sql = "SELECT * FROM user_messages";
  db.query(sql, (err, result) => {
    if (err) {
      throw err;
    }
    // console.log(result)
    console.log('messages sent')
    res.send(result);
  })
})


app.post("/addcontact", (req, res) => {
  let contact = req.body;
  // console.log(contact);
  let sql = "INSERT INTO contacts VALUES ('"+contact.name+"','"+contact.number+"');" // ! sql injection issue 
  db.query( sql, (err, result) => {
    if (err) {
      throw err;
  }

  console.log('contact added ' + contact.name)

  res.send(result);

})})

app.get("/getcontacts", (req, res) => {

  let sql = "SELECT * FROM contacts";
  db.query(sql, (err,result) => {

    if (err) {
      throw err
    }

    console.log('contacts sent:')
    res.send(result);

  })


});

app.listen("3000", () => {
  console.log("Server is successfully running on port 3000");
});