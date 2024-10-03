# Note: this script is intended to be run via the terminal

import cv2

# displays image and waits for user to close it by pressing any key
def display_img(img):
    print("\nPress any button to close\n")

    # display the image
    cv2.imshow("image", img)

    # pressing any key will close the image
    cv2.waitKey(0)

    # closes everything
    cv2.destroyAllWindows()


# handles user input of which image to process
def select_img():
    user_input = input("\nSelect an image from this directory to load, otherwise type: 'd' for a default image\n")

    match user_input:
        case 'd':
            return "img.jpeg"
        case _:
            return user_input


# handles user input for how they would like to resize an image, returns the updated image
def resize_image(img):
    print("\nYou can choose a new return size for the image, and also scale the image e.g. make it twice as big as before.\
          We will always look to maintain the aspect ratio")
    
    while(True):
        size_or_scale = input("\nWould you like to resize (1) the image or rescale (2) it?\n")

        match size_or_scale:
            case '1':
                new_w = int(input("\nPlease enter a new Width, we will then scale the height accordingly:\n"))

                # Get the original dimensions
                (h, w) = img.shape[:2]
                # calc aspect ratio
                aspect_ratio = h / w
                # calc new_h
                new_h = int(new_w * aspect_ratio)

                return cv2.resize(img, (new_w, new_h))
            case '2':
                scale = input("\nPlease enter a Scale Factor:\n")

                return cv2.resize(img, (0, 0), fx = float(scale), fy = float(scale))
            
            case _:
                continue
    

def rotate_image(img):
    # default center of rotation is center of image
    # Note: '//' python3 integer division
    center = (img.shape[1] // 2, img.shape[0] // 2)
    # keep img same size
    scale = 1

    # fetch rotation angle from user
    print("\nEnter how much you would like to rotate the image by, valid range between 0-360 degrees:")
    while(True):
        angle = int(input())
        if(angle < 360 and angle > 0):
            break
        print("Invalid Input, try again:")
    
    # return the transformed (rotated image)
    # warpAffine processes the transformation. Using cv2.getRoatationMatrix2D we can define a rotation matrix
    # from the default values and angle provided by the user
    return cv2.warpAffine(img, cv2.getRotationMatrix2D(center, angle, scale), (img.shape[1], img.shape[0]))
        



# prints what options we currently support for processing the images
def print_img_processing_options():
    print("- Quit (Q)\
          \n- resize (r)\
          \n- greyscale (g)\
          \n- blur image (b)\
          \n- rotate (R)\
          \n- erosion (e)")


# handles user input for what they want to do to the image, processes this and returns the update image
def process_img(img):
    # using while loops instead of recursion for better use of stack space
    while(True):
        Y_N = input("\nWould you like to alter the image at all? (y/n)\n")

        match Y_N:
            case 'y':
                # if 'yes' break loop and continue processing image
                print("\nWonderful!")
                break
            case 'n':
                # if 'no' exit function and return img unchanged
                print("\nNo Problem")
                return img
            case _:
                continue


    # user wants to process image. Provide them a list of what we can do to alter the image
    print("You many alter the image as many times as you like. Once you're done, just type: 'Q' for Quit and we'll show you the result.\
          \nYour options are below.\n")
    print_img_processing_options()

    while(True):
        user_input = input()

        match user_input:
            case 'Q':
                return img
            case 'r':
                img = resize_image(img)
                print("\nResizing Complete\n")
            case 'g':
                img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
                print("\nGreyscale Complete\n")
            case 'b':
                # uses Gaussian blurring, note there are other blurring options that apply different processes to images.
                # see https://www.geeksforgeeks.org/python-image-blurring-using-opencv/ for further info
                # default values: a 5x5 kernel, standard deviation of 3 (both x, y)
                img = cv2.GaussianBlur(img, (5, 5), 3)
                print("\nBlurring Complete")
            case "R":
                img = rotate_image(img)
                print("\nRotating Complete\n")
            case 'e':
                # uses default erosion of 5 iterations based on a 5, 5 kernel
                # kernel is constructed with cv2.getStructuringElement
                # note: erosion is useful for eliminating image noise
                img = cv2.erode(img, cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5)), iterations = 5)
            case _:
                continue
                
        # remind them of the options
        print_img_processing_options()


def main():
    print("")

    # user chooses image to use
    img_path = select_img()

    # init img variable
    img = cv2.imread(img_path, 1)

    # update image based on what the user wants
    img = process_img(img)

    display_img(img)


main()