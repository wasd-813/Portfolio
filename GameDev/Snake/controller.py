import constants as con

class controller:
    contents = [] # stores 0 for nothing, 1 for snake, 2 for apple

    def __init__(self) -> None:
        # populate game contents with 0s
        for i in range(0, con.numSq):
            self.contents.append([])
            for _ in range(0, con.numSq):
                self.contents[i].append(0)
        
    def updateContents(self, snake, apple):
        # updates controller contents with snake elements
        for i in range(0, con.numSq):
            for j in range(0, con.numSq):
                self.contents[i][j] = 0

        for i in range(len(snake.elems)):
            x = snake.elems[i][0]
            y = snake.elems[i][1]
            self.contents[x][y] = 1
        
        self.contents[apple.xPos][apple.yPos] = 2
    
    def moveSnake(self, snake, apple):
        # calculate where the next head will be
        nextHeadX = snake.elems[0][0] + snake.velX
        nextHeadY = snake.elems[0][1] + snake.velY

        # Error checking for end of game
        if nextHeadX > con.numSq or nextHeadX < 0:
            raise Exception("Moved out of Bounds")
        
        if nextHeadY > con.numSq or nextHeadY < 0:
            raise Exception("Moved out of Bounds")
        
        for i in range(len(snake.elems)):
            if nextHeadX == snake.elems[i][0] and nextHeadY == snake.elems[i][1]:
                raise Exception("Ran into itself")
            
        # prepend elems list with new head
        snake.elems.insert(0, [nextHeadX, nextHeadY])

        # if next elem is not an apple, remove the tail of elem
        if self.contents[nextHeadX][nextHeadY] == 2:
            apple.spawnNew()
        else:
            snake.elems.pop(-1)
