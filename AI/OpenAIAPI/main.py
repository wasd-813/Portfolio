# https://platform.openai.com/docs/overview
# This is a simple python script I have used to explore the use of OpenAI's API for Chat Completion

from dotenv import load_dotenv
from openai import OpenAI
import os
import base64
import requests

# allow script to acces .env for api key
load_dotenv()
# instantiate openai object
client = OpenAI()


def show_basic_queries():
    # list of basic queries
    basic_queries = ["Hi ChatGPT. Say hi back!",
                     "Sort these numbers in ascending order: 4, 2, 6, 9, 1, 3",
                    ]

    # go through all the basic queries
    for query in basic_queries:
        # parse the query
        parsed_query = {"role": "user", "content": query}
        # get a response from OpenAI
        response = client.chat.completions.create(model = "gpt-4o-mini", messages = [parsed_query])
        # print it
        print(f"Q: {query}")
        print(f"A: {response.choices[0].message.content}\n")  


def handle_user_queries():
    print("Once you're done asking questions, type: 'q'")
    while True:
        query = input("Q: ")

        if query == 'q':
            return

        parsed_query = {"role": "user", "content": query}
        response = client.chat.completions.create(model = "gpt-4o-mini", messages = [parsed_query])
        print(f"A: {response.choices[0].message.content}\n")  


# Function to encode the image
# taken from https://platform.openai.com/docs/guides/vision
def encode_image(image_path):
  with open(image_path, "rb") as image_file:
    return base64.b64encode(image_file.read()).decode('utf-8')
  

def handle_image_analysis():
    # interact with os to get image path parsed based on the image the user wishes to process
    cwd = os.getcwd()
    user_input = input("Enter the name of an image in this directory to load: ")
    image_path = f"{cwd}/{user_input}"
    b64_img = encode_image(image_path)

    # pass the encoded image data with a basic image query to the AI
    response = client.chat.completions.create(
        model = "gpt-4o-mini", 
        messages = [{
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": "What is in this image?",
                },
                {
                    "type": "image_url",
                    "image_url": 
                    {
                        "url": f"data:image/jpeg;base64,{b64_img}"
                    }
                }
            ]
        }],
        max_tokens = 500
    )

    # print responses
    print(f"Q: What is in this image?")
    print(f"A: {response.choices[0].message.content}\n")  

# this is a bit of a hack as I'm parsing the data of the txt file as a string in python and then passing this to the AI
# from a quick look online, the best way to handle a comparable task entirely using the AI would be to set-up an OpenAI Assistant
# not just use the chat completion feature like I'm using now.
# https://community.openai.com/t/send-files-to-completion-api/575385
def handle_file_data():
    print("This is a simple process to count the number of ones found in the data.txt file in this directory")
    cwd = os.getcwd()
    file_path = f"{cwd}/data.txt"
 
    with open(file_path, 'r') as file:
        file_content = file.read()

    response = client.chat.completions.create(model = "gpt-4o-mini", messages = [{"role": "user", "content": f"How many ones are in this string?: {file_content}"}])

    print(f"Q: How many ones are in the data.txt file?")
    print(f"A: {response.choices[0].message.content}\n")  


def print_menu():
    print("There are a few things you can do here:\
            \n\t- print some basic example queries (1)\
            \n\t- ask it some of your own questions? (2)\
            \n\t- get it to analyse an image (3)\
            \n\t- get it to handle some file data (4)\
            \n\t- Quit (Q)\n")


def main():
    # intro
    print("\nWelcome to my simple python script demonstrating interfacing with the OpenAI API")
    print_menu()

    while True:
        user_input = input()

        match user_input:
            case '1':
                show_basic_queries()
            case '2':
                handle_user_queries()
            case '3':
                handle_image_analysis()
            case '4':
                handle_file_data()

            case 'Q':
                return
            case _:
                print("ERR: Invalid input, try again")
            
        print_menu()


main()