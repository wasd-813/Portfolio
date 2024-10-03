import apple as a 
import snake as s
import controller as c
import constants as con
import pygame as g

# initialise pygame stuff
g.init()
screen = g.display.set_mode((con.winSize, con.winSize))
clock = g.time.Clock()
running = True

# init controller
controller = c.controller()
snake = s.snake()
apple = a.apple()

# functions
def refresh(cont, surf, snak, app):
    cont.moveSnake(snak, app)
    cont.updateContents(snak, app)

    for i in range(0, con.numSq):
        for j in range(0, con.numSq):
            match cont.contents[i][j]:
                case 0:
                    left = i * con.numSqDiv
                    top = j * con.numSqDiv
                    width = con.numSqDiv
                    height = con.numSqDiv
                    g.draw.rect(surf, con.black, g.Rect(left, top, width, height))
                case 1:
                    left = i * con.numSqDiv
                    top = j * con.numSqDiv
                    width = con.numSqDiv
                    height = con.numSqDiv
                    g.draw.rect(surf, con.white, g.Rect(left, top, width, height))
                case 2:
                    left = i * con.numSqDiv + con.appleOffset / 2
                    top = j * con.numSqDiv + con.appleOffset / 2
                    width = con.numSqDiv - con.appleOffset 
                    height = con.numSqDiv - con.appleOffset
                    g.draw.rect(surf, con.red, g.Rect(left, top, width, height))
                case _:
                    pass

    g.display.flip()
                


while running:
    refresh(controller, screen, snake, apple)

    for event in g.event.get():
        if event.type == g.QUIT:
            running = False
        if event.type == g.KEYDOWN:
            match event.key:
                case g.K_w:
                    snake.setVelN()
                case g.K_a:
                    snake.setVelW()
                case g.K_s:
                    snake.setVelS()
                case g.K_d:
                    snake.setVelE()

    clock.tick(con.framerate)

g.quit()