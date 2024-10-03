// get variables
var searchButton = document.getElementById("searchButton");
var userText = document.getElementById("userText");
var responseField = document.getElementById("responseField");
var temperatureField = document.getElementById("temperature");
var descriptionField = document.getElementById("description");
var image = document.getElementById("img");

// add functionality
searchButton.addEventListener("click", async function() {
    // reset response field text
    responseField.innerHTML = "";
    // get location provided by user
    var location = userText.value.toLowerCase();

    // get return data from server based upon what location was entered into the text field
    try {
        var data = await (await fetch('/return?location=' + location)).json();
    } 
    catch (err){
        responseField.innerHTML = "Error: Unable to find location";
        console.log("Error: " + err);
        return;
    }

    // update all according return fields
    responseField.innerHTML = `Displaying the current weather in: ${capitalizeFirstLetter(location)}`;
    temperatureField.innerHTML = `${data.main.temp}°C`;
    descriptionField.innerHTML = capitalizeFirstLetter(data.weather[0].description);
    image.src = `https://openweathermap.org/img/wn/${data.weather[0].icon}@4x.png`;
    image.style.display = "block";

    // dynamic update text & background style depending upon if its nighttime or not
    if(data.weather[0].icon[2] === 'n'){
        document.body.style.backgroundColor = "#7393B3";
        document.body.style.color = "#E5E4E2";
    } 
    else{
        document.body.style.backgroundColor = "#F0FFFF";
        document.body.style.color = "black";
    }
});

function capitalizeFirstLetter(string) {
    return string[0].toUpperCase() + string.slice(1);
}
