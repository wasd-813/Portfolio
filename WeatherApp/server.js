// Import required modules
const express = require('express');
const dotenv = require('dotenv');

// set-up .env access
dotenv.config();
const WEATHER_API_KEY = process.env.WEATHER_API_KEY;
const GEOCODING_API_KEY = process.env.GEOCODING_API_KET;

// Create an Express application
const app = express();

// Static files
app.use(express.static('public'));
app.use('/css', express.static(__dirname + 'public/css'));
app.use('/js', express.static(__dirname + 'public/js'));

// Set views
app.set('views', './views');
app.set('view engine', 'ejs');

// Render .ejs page
app.get('/', (req, res) => {
    res.render('index');
});

// provide a different endpoint to fetch data from the weather api
app.get('/return', async (req, res) => {
    // extract location data based on fetch request
    var location = req.query.location;

    // use geocoding API to get lat long of natural language location
    // basic hard error checking for fetch && API server side errors -> crash
    try{
        var geo_data = await fetch(`https://api.positionstack.com/v1/forward?access_key=${GEOCODING_API_KEY}&query=${location}`)
    } 
    catch (err){throw new Error(err);}

    try{
        geo_data = await geo_data.json()
    } 
    catch (err){throw new Error(err);}

    // check geocoding API has not returned an error object
    if(geo_data.error){
        raiseError(1, "API returned error object", res);
        return;
    }

    // ensure geocoding API has meaningful results to return
    if(typeof geo_data.data[0] === 'undefined'){
        raiseError(2, "API returned no meaningful data", res);
        return;
    }

    // extract lat longs from geocoding json
    // data[0] is accessed as this will be the most popular result matching the given input string
    // E.g. London UK Capital will be returned instead of London USA
    var lat = geo_data.data[0].latitude;
    var lon = geo_data.data[0].longitude;

    // process weather request and return data to frontend
    getWeather(lat, lon)
        .then(data => res.send(data));
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

function raiseError(internalErrCode, errMsg, res){
    console.log("Error: " + internalErrCode + " - " + errMsg);
    res.status(400);
    res.send("Error");
}

// call weather API for data
async function getWeather(latitude, longitude){
    return fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${WEATHER_API_KEY}&units=metric`)
        .then(response => response.json());
}