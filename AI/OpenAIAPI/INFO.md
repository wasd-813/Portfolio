# OpenAIAPI

## What did I do?
Created a simple python script that uses CLI to demonstrate basic processes and tasks which can be completed by using the OpenAI API. I've passed it some images and the model accurately 

## What did I learn?
- It's slow, very slow.
- String manipulation is key here. I gather the API uses JSONs to communicate across the various coding languages it supports and so ensuring these strings (in JSON format) are correct is important other the model will throw an error or be unable to do what is requested
- There's huge potential for scalability. Whilst I didn't delve into file manipulation and data analysis, I could see how this could be a useful tool to a team needing to complete some basic tasks on large volumes of data. 

Summary: The model largely benefits from its ability for us devs to abstract away from web-surfing to collate a world-knowledge-base. When the model must build/collate this KB to answer a query, it's slow. It seems good at handling and processes raw data in a variety of formats, but in this case why not use a .sh script?

## EBI
- I only used the Chat Completion aspect of the API, there is an Assistant feature that allows for greater data manipulation. Experimenting with this Assistant feature would be good. (However, currently I am not interested in doing so)
- Using the Chat Completion feature, I only used one stream of messages i.e. a Q&A format. I did not implement a dialogue between the user and model and hence the model does not remember any previous queries raised by the user in the session. Implementing a multi-stream chat feature and or a basic implementation of memory for the model would be useful. Of course the OpenAI model has this feature in place, I just did not utilise it.