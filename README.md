# Pinball Game 
## Table of Contents
Within my pinball game I chose to feature I chose to implement the following features:

- [Basic Pinball Dynamics](#basic-pinball-dynamics)
- [Multiple Balls Interacting](#multiple-balls-interacting)
- [Circular Obstacles](#circular-obstacles)
- [Line-Segment/Polygonal Obstacles](#line-segmentpolygonal-obstacles)
- [Plunger/Launcher](#plungerlauncher)
- [Textured Background](#textured-background)
- [Reactive Obstacles](#reactive-obstacles)
- [Load Scenes From Files](#load-scenes-from-files)
- [User-Interactive Flippers](#user-interactive-flippers)

## Basic Pinball Dynamics
The program simulates basic pinball dynamic through an inclusion of an acceleration vector that is used when calculating the velocity and ball position vector. This can be seen when the ball arcs as it moves and slightly accelerates as it moves down the screen. It also has elastic collisions with obstacles and other balls in it's pathways which updates the position and velocity of the ball accordingly.

## Multiple Balls Interacting
Once more balls are triggered, the new balls follow the same pinball dynamics as the original ball while in motion. Likewise, it follows the same physics of acceleration and using it to calculate updated velocity and position of the ball. When colliding with another ball in motion there is an elastic collision as they fall.

## Circular Obstacles
Circles are one of the shapes that the ball can bounce off of. In order to replicate the ball's natural collision with a circle, the direction of the velocity vector is reversed.

## Line-Segment/Polygonal Obstacles
The other two obstacles the ball can bounce off of are lines and boxes. For the line, the line is normalized then projected to find the closest point. This is then used to calculate the new positions and velocity. For the boxes, it utilizes the line check on all the lines of the box.

## Plunger/Launcher
The original ball begins in the bottom-right corner of the screen. It is launched when the user presses the space button on the keyboard.

## Textured Background
The game has two imported backgrounds. The first has a blue background and a turtle in the middle of the screen. The second background is of a pink screen with the carat/Seventeen logo in the middle.

## Reactive Obstacles
The game utilizes two collision reactive obstacles. The first occurs right after the ball is launched. Once it collides with the first line (also call the "curve") the line shifts to block the launch channel. The other reactive obstacle is the circle obstacle. When a ball collides with it, it triggers another ball to randomly fall from the top of the screen. This can happen a maximum of two times (i.e. up to three balls on the screen).

## Load Scenes From Files
There are three preset file scenes created for the game. Each of them have information for the scene's background, stroke color, fill color, obstacles, and obstacle's locations. The three files are layout1.txt, turtle.txt, and carat.txt. If the file says none for background then the scene will automatically have a plain color background. If the file says image then it utilizes a picture address.

## User-Interactive Flippers
The game has two user-interactive flippers. The basic code is from Dr. Guy's given code. The flipper moves when the user holds down on the appropriate arrow key. For example, to move the right flipper then the right arrow key must be held down. The flippers utlize the ball line collision algorithm. If it hits the ball while moving then it calculates related angular properties to update the ball's features.
