import constants as con

class snake:
    elems = []
    velX = 0
    velY = 0

    def __init__(self) -> None:
        self.velX = 1
        self.velY = 0

        # starting snake
        self.elems.append([13,10])
        self.elems.append([12,10])
        self.elems.append([11,10])
        self.elems.append([10,10])
    
    # helper functions to set movement direction of snake
    def setVelN(self):
        self.velX = 0
        self.velY = -1
    
    def setVelS(self):
        self.velX = 0
        self.velY = 1

    def setVelE(self):
        self.velX = 1
        self.velY = 0

    def setVelW(self):
        self.velX = -1
        self.velY = 0
    
    def move(self):
        # calculate where the next head will be
        nextHeadX = self.elems[0][0] + self.velX
        nextHeadY = self.elems[0][1] + self.velY

        # Error checking for end of game
        if nextHeadX > con.numSq or nextHeadX < 0:
            raise Exception("Moved out of Bounds")
        
        if nextHeadY > con.numSq or nextHeadY < 0:
            raise Exception("Moved out of Bounds")
        
        for i in range(len(self.elems)):
            if nextHeadX == self.elems[i][0] and nextHeadY == self.elems[i][1]:
                raise Exception("Ran into itself")

        # prepend elems list with new head and pop last element
        self.elems.insert(0, [nextHeadX, nextHeadY])
        self.elems.pop(-1)


    