# Pong
Developing Retro Type Pong Game Using LÖVE framework. 
<br>
LÖVE is a framework for making 2D games in the Lua programming language.


![](https://img.shields.io/badge/L%C3%96VE2D%20-v11.1-%23ea316e?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAntJREFUOI11kktsTVEUhr+9z76P0keqmiiirZDShhhhQpCQtATpQEQY1EQiEpEgRGlNPGJiaCAkIp4RiUdIkxoYMfIYlBBplHJxtdrbc59n72Vw7r3R4k/2ZK3/X49/bcUUyLzTsKzpzFiQXV0Tn1aFiEIYR9RTXgwcUUMnJ/HVJPGWGz1pKXT7NmsArDgAtFIoFFWmIh8Xc1bd236ipNF/iC+NWL93PEgbK64sBnAiWHH8KvhRP/Xr+KOHcmFSAdl0bc+o9bvyLigpIGNBCF/GghNifp5baxe7dpfcs7hfDgNoab0IUe9sriiWVADiEeloRj7mkY95Ih3NeAV42TaH3UsW6JZsBplI9gIY5k/fm8ynagBIWyLtjcw8uhGAoGsCAFNXCQfhYf+wmGSg0IAtVLQ+kQMaT60RkXDy9znqDraXdzd1laG4iDNrZ6kgZ4umOWzq53o9UpiYHwbAxTQqUvb1Lxjtgc3iSvxcpkEbpYPSQQWHnxj9b4EvoylwoEvXV8rq6kjF2xIh2hzn07kH/y3Q3fee+qrKsL1SqHh8SJN3tz0Vji0xTc2zFG8OX4GiLyXsu/mcy7aWGSqMK8/g6+l3FYB03nz3LTu2UBC8wJGoqpSlHW0MbmpSiLDizgDfa+fSYrywu9YobYbfdjbMNQBk7UqjvZ8uCEhHNKu2rVaztKb5/lcIAprqG2kp/yqF9gypifShonXFq2y+viNR8K/u2rlOvY4aaiXcM0wWx9YeaE1Ox44Nbq07NakAAH3SODPz43G9yCKxQbFjSFOewdngw9jn4X2J/csfU878A3OeyLz4SKLHxKKzHUAulxivbjj/bYN6NZX7G9C2GGiy4k2BAAAAAElFTkSuQmCC)
![](https://img.shields.io/badge/Lua-v5.4-%23000080?style=for-the-badge&logo=lua)

## Table of contents
* [Introduction](#introduction)
* [Technologies](#technologies)
* [Setup](#setup)
* [Launch](#launch)
* [Illustrations](#illustrations)
* [Examples](#example)
* [Status](#status)
* [Sources](#sources)
* [Other](#other)


## Introduction
Aim of this project is to make a basic retro game **Pong** from scratch using Love2d framework and Lua language.<br>
Some Questions that I have tried my best to answer :-

1) **How this game is different from others?**<br>
No, it is not different from other games. I see this game as a first step towards my interest in game development.

2) **How this game is different from the Tutorial Pong Game?**<br>
I have tried including my own ideas in this project. Some of those ideas are :-
    * Whole idea regarding Menu and interface using Gamestates.
    * Volume adjustments for SFX as well as Music.
    * Difficulty levels which alters ball speed, paddle speed as well as paddle length
    * In **Vs Computer** Mode also, speed of paddle changes according to difficulty level selected.
    * In **Hard Difficulty**, Computer Controlled paddle will rarely miss the ball. While in **Easy Difficulty** Computer Controlled paddle will miss the ball more often.
    * You can change targets varying from **1** to **19**.

3) **What I have learned from this project?**<br>
I learned how game generally works. All those constantly running cycles of updates and renders is all that occurs behind the scenes. I also learned how frameworks are important for abstractions.

4) **How your game works??** <br>
I have used simple approach of change in game states.These are the states that are present in my game and their main function :-
    Game State                        | Main Function
    --------------------------------- | -------------------------
    START                             | To show Game Intro Screen.
    MAIN_MENU                         | Show Main Menu.
    MODE_MENU                         | If **Play** is selected in Menu show different modes availaible that are :- <br> Vs Compter & Vs Player.
    SETTINGS_MENU                     | If **Settings** is selected in Menu show volume adjustments that can be made.
    CREDITS                           | If **Credits** is selected in Menu show credits.
    QUIT_CONF_0                       | Player has chosen exit from **Main Menu** which quits the game.
    QUIT_CONF_1                       | Player has chosen exit from **Paused Game** which brings player back to **Main Menu**.
    VS_COMP_MENU and VS_PLAYER_MENU   | These are two different modes in which player can chose difficulty levels and target.
    COMPUTER_MODE                     | Player will play against computer controlled paddle.
    PLAY                              | Player will play against other player.
    PAUSE                             | It brings **Pause Menu**.
    PAUSE_TO_PLAY                     | If **Resume** is selected from **Pause Menu** it starts a countdown and player can go back playing.
    P1_WINNER or P2_WINNER            | If **Target** reaches selected target than winner s announced and respective message is shown.

5) **Future plans regarding this project??**
I have started work on New Mode which is superior and more fun than this one.


## Features:
  1. **Different Game Modes :-**
    This game provides 2 different game modes that are **Vs Computer** and **Vs Player**.
  2. **Different Difficulties :-**
    Each mode has 3 different difficulty levels that has different ball speed and different paddle size to make games more dynamic.
  3. **Adjust Volume Of Music And SFX :-**
    Don't like music?? You can turn it down or even turn it off from settings.
  4. **AI implementation according to difficulty :-**
    All 3 different difficulty levels have different AI Paddle implemented.
  5. **New Mode Coming Soon :-**
    New Mode is under development which is superior and more fun than this one. Stay Tuned!!


## Technologies
  #### Software Used :
  * VS Code : 1.58.2
  #### Languages Used :
  * Lua
  #### Frameworks Used :
  * Love2d : 11.1


## Setup
First you must have these softwares and languages installed on your system -
  * [Lua](https://www.lua.org/download.html)
  * [Love2d : 11.1](https://love2d.org/)


## Launch
Just run this command where Folder **Game** is located.
```
$ love Game
```
A window will pop up and you are good to go.


## Illustrations
### Game State FlowChart
<p align="left">
  <img src="Game/Git Files/Game State FlowChart.jpg" width=100% title="Game State FlowChart">
</p>

## Examples
<img src="Game/Git Files/The_Pong_Game.gif" alt="GIF">


## Project status
  ***Completed***


## Sources
  * [**Love2d Documentation**](https://love2d.org/wiki/Main_Page)
  * [**dafont(Fonts)**](https://www.dafont.com/)
  * [**jsfxr(Sound Effects)**](https://sfxr.me/)

Audio File **music.mp3** taken from [Fesliyan Studios Website](https://www.fesliyanstudios.com/royalty-free-music/download/8-bit-menu/287)
  

## Other
  This Project was created under course "**CS50's Introduction to Computer Science**" presented by **HarvardX - CS50** via platform **edX**.
