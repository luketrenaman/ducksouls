# Duck Souls
Welcome to **Duck Souls**, a souls-like game built for web. Looking to get killed by a duck that commands pillars of fire? You're in the right place! You can play it on [luketrenaman.com](https://luketrenaman.com/ducksouls) or [itch.io](luketrenaman.itch.io/ducksouls). Move with WASD and go on a walk if you get mad.
## Development Process
This game was produced in a mini game-jam with Gabe Salazar. The rules were as follows:

 - You have unlimited time to plan the game, as well as make sure all of your software works.
 - You have 3 hours and 30 minutes to produce all content and code for the game.
 ## Planning (11:30am-12:30pm)
 Originally titled "Duck Will Destroy You", our concept was to create a boss battle with as many phases as possible. The game would feature a duck, a player, and various attacks that the duck would initiate. After a quick chat on pixel ratios we decided our game would be 200x150, scaled up to 800x600. Gabe quickly renamed the game to "Duck Souls".
 Due to the severe time crunch we would have to develop the game under, we took a fair amount of time considering what order to add features in. Our priorities were as follows:
 
 - Duck and duck attacks (completed)
 - Arena tiles (completed)
 - Player (completed)
 - Titlescreen (completed)
 - Player attacks (sprites completed)
 - Normal/Hardcore difficulties (sprites completed)
 - Tutorial (not completed)
 - Music (not completed)

I planned to crank out as much could while using placeholder sprites, and Gabe could gradually replace them.
## Development (12:30pm-4:00pm)
### 0:00-0:30
Now that we had our priorities straight, it was time to code. For our rough prototype, I made a moving player, and a static duck in the top right corner of the screen. The player was locked to a square grid to make the development easier, and a quick flame placeholder was up. After this, I made the duck lethal although it still didn't move.
### 0:30-1:00
Gabe had created a sprite for the arena, red dangerous tiles, and the duck. I began adding more variations to what flames could be spawned, with methods with beautiful names like `make_flame`, `rand_flame`, `flame_column`, `flame_column_rand`, and more. A system was also being set up for phases, with a timer ticking every tenth of a second, and an array `phase_durations` to determine how many ticks would be in each phase. Every phase was a function that would be ran every tick, and with a quick `match` selector, the game had a beginning, middle, and end. *But we didn't stop there!*
### 1:00-1:30
Gabe had added in an idle animation for the duck, a yellow warning tile, and a beautiful flame animation. Gabe also added sprites for our intrepid protagonist, FRY GUY! I added in all of these sprites, and kept refining the phases. There was still issues with phases not playing for long enough, or flames spawning off of the screen. In this half hour, we also began discussing the idea of menus (we had been procrastinating this). We had a plan to let the player choose between normal and hardcore mode, with normal mode setting the player back to their last phase, and hardcore mode setting them back to the beginning. Lucky for you, we ran out of time before we could add normal mode!
### 1:30-2:00
Gabe added a walk animation for the duck, and an idle animation for fry guy. I worked on   movement patterns for the duck, with beautiful methods like `follow_player`, `snap_to`, `goto`, and `patrol`. I also had to make the duck lethal, so I added some `DangerousTile` scenes to follow the duck around.
### 2:00-2:30
The moment we had been dreading had arrived: menus. I added Gabe's game over screen, a victory screen, buttons to try again and give up. There was also a title screen with a selection between difficulties, with a golden "Duck Souls" beckoning the player.
### 2:30-3:00
Gabe had finished a majority of the art and began reworking some of the menus (per my request) and adding death animations to Fry Guy and the duck. I reworked the player's movement system to be more smooth (before you could only move by mashing the keys) and made sure the timing on the game over animation and victory animations were good, as well as preventing the player from moving once the game finished.
### 3:00-3:20
After getting everything to my satisfaction I realized I hadn't added any phases. Gabe was done drawing so he just watched as I struggled to crank out the last five phases, using all of the methods and animations we had built on. After creating all five phases, I had ten minutes left.
### 3:20-3:30
I have never clicked checkboxes so fast. I imported Gabe's death animations for both the duck and the fry and set all of the phases to 0.1s to quickly test the victory animation and then time was up. Even though the timer had gone off, I quickly fixed this bug, which set stage for a great deal of rationalization and led to...
## Playtesting and debugging (4:00pm-6:00pm)
In a typical game jam, I wouldn't have been able to change anything after the 3 hour and 30 minute cutoff. However, because this dead-line was self imposed, adding additional features to the game was exceptionally tempting. The following bugs were fixed after the deadline:

 - All phases are 0.1s long
 - Duck animation continues infinitely on game end
 - Player animation continues infinitely on game end
 - Play again, give up, and menu buttons can be pressed while playing
 - Hardcore and normal buttons are in the game, even though they do nothing
 - Player can survive flames, as long as they stand on them during the yellow warning phase
 - Player is cannot leave the screen except on the right

I also fine tuned the following:

 - Make phase 4 slightly easier for players who start in a corner
 - Give vertical and horizontal movement individual delays to allow players 

## Conclusion
All-in-all, the game took 6 hours and 30 minutes, but if you squint hard enough, it only took us 3 hours and 30 minutes to make this beautiful work of art: Duck Souls. If you haven't played it already, I highly recommend doing so! To further amplify your experience, play [this music](https://www.youtube.com/watch?v=Z9dNrmGD7mU) as you face the duck. Good luck!