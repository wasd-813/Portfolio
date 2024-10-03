# Weather App
This directory serves as a home to all files related to the Weather App I made.

## What did I do
Used a weather info API [OpenWeather](https://openweathermap.org), and a geocoding API [PositionStack](https://positionstack.com) in order to parse natural language location data provided by a user, and then collect current weather data on that location. The infomation is then provided to the user on a basic html page. Thereby, I have created an interface for the weather API

### Further details:
- Provided dynamic HTML styling based upon screen size
- Dynamic HTML styling based upon the timezone of the location for which the user has requested weather data on, I.e. a daytime/nighttime styling
- Produced an Express JS server, combined with a JS frontend to provide client/server interaction. This allowed me to create a basic webpage with dynamic JS functionality (frontend, e.g. text boxes, buttons), based upon HTTP backend server requests.
- I ensured API keys were secured and not accessible from the client-side (only available from the backend)
- Attempted to handle and catch all API accessing error on the backend and return to the frontend succinctly to the frontend without the server and webpage crashing

## What did I learn?
There is so much I learnt whilst making this basic app. I remember hearing somewhere that writing server/client software in a given language, is a good way to familiarise yourself with the syntax, libraries/packages and capabilities of a language. Having done exactly that with this project I would have to agree. I feel much more confident in JavaScript and frameworks surrounding the Language.

Aside from the JS and server aspects, I re-familiarised myself with some basic HTML and CSS.

### Further Details
I learned:
- Basic JS syntax e.g. equivalent to f-strings, dynamic typing, lambda functions, etc.
- What Node JS is and how to differs to browser-based JS
- About the extent of JS packages
- What Express JS is and how to implement an elementary Express JS server
- How to use basic HTTP requests and routing to pass data between the frontend and backend
- How to handle asynchronous requests and promises
- How to implement basic error checking and handling to asynchronous functions
- How to interact and use JSON data
- Dynamic HTML styling based upon screen size e.g. scaling text size

## EBI?
- I later learnt the weather API provided it's own in-house geocoding support. It would have been wise to use this if I realised sooner
- As always, the app could be expanded with greater functionality e.g. forecasts, weather warnings, etc.; unfortunately, a lot of this data is hidden behind a paywall when using these weather APIs