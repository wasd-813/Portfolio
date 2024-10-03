# workingWithImgs

## What did I make?
The intent of this directory was to experiment with cv2's library and experiment with basic image manipulation, as well as strengthen my knowledge and understanding of python's syntax and uses.

[main.py](main.py) was create as a simple interface for the cv2 library, such that basic image processing can be completed from the command line. Only one default image has been provided, however the user can processes other images by adding them to the directory

## What was the point? What did I learn?
I experimented with python3's version of switch statements (match/case), and whilst working on this project uncovered some interesting details regarding integer division in python: in python3 '/' denotes division and will return floats, where as in prior python versions '/' was more in-line with other languages such as C where integer division would be applied when needed. As a result, if you wish for specific integer division in python3 '//' must be used.

I managed to get a basic understanding of how to interface with the cv2 library as well as a grasp on the mathematics behind image process. Namely whilst implementing the Gaussian blurring and image erosion I had to research into the processes by which these are conducted and the matrix maths behind such.

I commented plenty along the way so feel free to check out the script.

## EBI
The project can be expanded if I wish. At a later date if I were to resume with this topic, I advise referring to: [GeeksForGeeks](https://www.geeksforgeeks.org/opencv-python-tutorial/) for further ideas on what to implement, namely:
- thresholding
- converting images to other colour spaces
- filtering