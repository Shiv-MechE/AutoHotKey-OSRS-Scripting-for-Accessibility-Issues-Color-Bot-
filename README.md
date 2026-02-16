# Shiv's AutoHotKey Scripting Project Description
#### https://github.com/Shiv-MechE 

## Videos of the Scripts in Action:
* Fishing Script Youtube: https://youtu.be/Yd7HCKFWxRY
  * [<img src="https://img.youtube.com/vi/Yd7HCKFWxRY/hqdefault.jpg" width="200" height="200"/>](https://www.youtube.com/embed/Yd7HCKFWxRY)
* Woodcutter Script Youtube: https://youtu.be/RZnMRl5EcEo
  * [<img src="https://img.youtube.com/vi/RZnMRl5EcEo/hqdefault.jpg" width="200" height="200"/>](https://www.youtube.com/embed/RZnMRl5EcEo)
* Fighter Script Youtube: https://youtu.be/yDFZfMQruyk
  * [<img src="https://img.youtube.com/vi/yDFZfMQruyk/hqdefault.jpg" width="200" height="200"/>](https://www.youtube.com/embed/yDFZfMQruyk)
* Cooker Script Youtube: https://youtu.be/5bvKuFkD314
  * [<img src="https://img.youtube.com/vi/5bvKuFkD314/hqdefault.jpg" width="200" height="200"/>](https://www.youtube.com/embed/5bvKuFkD314)

## The Project
Automate gameplay, and, mimic human like gameplay in the MMORPG titled “Oldschool Runescape (OSRS)”.  This game is played by performing repetitive actions, thus, an opportunity for automation is born. However, the environment within the game is dynamic and therefore scripts must be robust in order to adapt.

## Requirements:
The automation MUST mimic human-like behavior, otherwise, unrealistic achievements within the game and robot-like behavior would be noticed by the game developers who would then place restrictions on the player/account. Measures to achieve this are outlined herein.

## In a Nutshell: How These AutoHotKey (AHK) Scripts Work:
At its heart, my project utilizes the color detection capabilities within AutoHotKey to scan the gameplay application for certain objects/entities/interfaces/targets. Scanning is done pixel by pixel within a specified box. Then, depending on the results of scanning for all of the various things within the dynamic environment of the game, an action is taken. To re-iterate, the action taken MUST be done in a way that mimics human like gameplay.

“AutoHotkey is … primarily designed to provide easy keyboard shortcuts or hotkeys, fast macro-creation and software automation to allow users of most computer skill levels to automate repetitive tasks in any Windows application.”

## Measures to Mimic Human-Like Behavior:
* __Entity clicking:__ Entities are simply things we want to mouse click on. Entities have clickable zones that are irregular “2D blobs”. The script scans the screen pixel by pixel, row by row (or column by column) until the entity’s border’s color is detected. This detected pixel is at the edge/border of the “2D blob”. Clicking the edge of the blobs every-time is not human like. This detected pixel was made the center and a pixel XY away from the center was picked. This picked pixel was then confirmed if it lay within the border of the entity. If yes, this is a clickable zone, and an action was taken to click the pixel.
* __Gaussian Target Clicking:__ Humans generally do not click targets within a random Length x Width box. Humans click the near the center of the box/target more than the outsides. Therefore, whenever clicking a target, a gaussian distribution click box was created. Furthermore, humans every now and then don’t click exactly where they intended to (“mis-click”). By design, the script may “mis-click” but then almost instantly correct itself as a human would.
* __Left/Right Click Depress Lengths:__ When humans click on the mouse there is a down stroke and a lift stroke. In between the mouse is held in the down position for some number of milliseconds. http://instantclick.io/click-test was used to find out how long this is for me using multiple click samples. This was then implemented into the project with a +/- buffer for randomization, that is, humans don’t click down for EXACTLY 112ms every time.
* __Breaks, Slow Mouse Movements, Intentionally mis-clicking:__ Usually people click and begin an action in the game and then do something else if that action takes time to finish. Humanoid actions aren’t performed at peak efficiency, back to back. People also take breaks for a few minutes and sit idle in the game. People also log out of the game for seconds/minutes/hours before coming back online. All this must be considered and implemented. 
* __Mouse Cursor Movement:__ AutoHotKey instantly clicks a pixel or instantly moves the mouse cursor to a specified position. The mouse movement speed can be slowed. Although, for this script a random Bezier function was utilized that moves the mouse cursor from point A to B in a random “squiggly” path. This random Bezier function was not created by me.
* __Event Detector:__ As mentioned before, the environment in the game is dynamic. Doors to buildings randomly close, targets/entities are moving, etc. These things need to be detected and then navigated. Otherwise, the script will break and obviously show bot like behavior. E.g., if a building door is closed then the obvious human action is to open the door, a broken robot would just run around and around the building trying to get inside.
* __Disconnect Detect:__ The game often disconnects while still displaying a frozen version of your gameplay on the screen. That is, it is displaying the same unchanging video frame. The script can often run indefinitely because the screen is frozen and the script is still detecting colors. There is a box that appears when the game has disconnected which can be used to end the script, otherwise, there is obvious robot like behavior.
* __Run/Walk:__ In the game you walk around the world. You can run if you have “energy”. If you don’t, you must walk until your energy slowly regenerates. The project will toggle the run feature at random times. It is actually human like to click the run feature even if you don’t have energy (like an “OCD Tick” phenomenon amongst people).
* __Fileappend:__ AutoHotKey has a “fileappend” command that can be used to write text into a text file. Throughout script development, this was used as an indicator of where the script may be breaking. Essentially “if the desired action was not performed, then fileappend xyz”. This allowed me to read through the text file and see exactly where an action “struggled”. Once the script was tested to be robust, the fileappend lines were made into comments to save computing power.
* __Abort:__ Scattered throughout the project are commands to stop the script if unanticipated things are occurring or being detected. This prevents the script from entering a sort of feedback loop of illogical actions being performed that are bot-like and not human like.
* __Other features:__

## Purpose and/or Applications:
This project helps promote accessibility to those that may be disabled in some capacity. These scripts allow those types of players to make progress and achievements on the game. Howver, there is a stigma in the player-base that these kinds of scripts allow for unfair advantages when abused. Hence, the game developers may or may not put restrictions on players/accounts using these types of scripts.

## Result:
Complex scripts were successfully created and performed their jobs robustly, that is, without breaking/getting stuck within this dynamic environment. The measures that were employed extended the “life” of the project significantly. Although, eventually unrealistic achievements and bot-like behaviors were detected and restrictions were placed.

## end
