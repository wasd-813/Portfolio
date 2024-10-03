import random as r
import constants as con

class apple:
    xPos = 0
    yPos = 0

    def __init__(self) -> None:
        self.xPos = r.randint(0, con.numSq)
        self.yPos = r.randint(0, con.numSq)

    # technically the apple can spawn inside where the snake is
    # this is a bug I should ultimately fix but is good enough for now
    def spawnNew(self):
        self.xPos = r.randint(0, con.numSq)
        self.yPos = r.randint(0, con.numSq)
