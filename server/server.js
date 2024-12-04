const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());

let dataStore = [];

// Read data
app.get('/data', (req, res) => {
    res.json({ data: dataStore });
});

// Write data
app.post('/data', (req, res) => {
    const { newData } = req.body;
    dataStore.push(newData);
    res.json({ message: 'Data added successfully', data: dataStore });
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
