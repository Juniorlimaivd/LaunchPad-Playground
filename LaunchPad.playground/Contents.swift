/*:
 ## LaunchPad Sandbox
 This playground uses **UIKit and AVFoundation** to simulate a LaunchPad and create for other musicians and programmers a sandbox where they can experiment combinations of samples and animations with lower cost. Plus, you keep some of your coding skills up :D
 
The interface was made to be simple to add sounds or animations, so let's
    get started!!
 
 */

import UIKit
import PlaygroundSupport

/*:
First of all, make a instance of **PadViewController**, that is where your LaunchPad is built. A PadView Controller instance creates for you a Launch Pad 4 x 4 no sound attached. The button's numerations goes from **0 to 15** , counting from left to right, up to down.
 
*/
let pad = PadViewController()

/*:
 ### Adding Sound
  To attach a sound to a button, you just need to call `addSound` from the PadViewController you want to attach. Don't forget to add the sound file in **aif** format before run. 
 
**`addSound` Parameters**
* **buttonPosition** : A integer from 0 to 15 representing the position of the button.
 * **filename** : A String represeting the name of sound file. It's supposed that the file is aif format, so you don't need to put the extension.
 * **lightColor**: Represent the color that the button will blink. Actually there are four possible colors to use. There are :
    * Blue - default color , is attached to buttons even with you don't attach any sound.
    * Yellow 
    * Pink
    * Orange
 * **shouldLoop**: Boolean to points if you wan't the sound to play in loop when the button is tapped. When this option is enabled, after tap the button once, the second tap will not restart the sound, but stop it. Tap the button a third time will play the sound in loop again.
 
 You need to pass the string exactly as it is above to work properly. You have some examples bellow.
 
 */
pad.addSound(buttonPosition: 1, fileName: "Chord2", lightColor: "Pink", shouldLoop: false)

/*:
 ### Adding Animations

 To add Animation when a button you need to call the function `addAnimation`
 from PadViewController. 
 
 **`addAnimation` Parameters**
 
 * **buttonPosition** : A integer from 0 to 15 representing the position of the button.
 * **steps** : A **Array of Animation Steps** that represents the animation itset. Each step will be peformed synchronously. Only after the step before finish, the next step will start.
 
 #### AnimationStep
 
 AnimationStep is a struct with a action and a list of buttons that you want to perform the action of that step. The type of **action** is a `AnimationAction` enum that  have the following possible values :
 
 * **.LightUp** : Is equivalent to turn the light of the button on.
 * **.LightDown** : Is equivalent to turn the light of the button off.
 * **.None** : Is equivalent to do notthing with the button.
 
 The default action of all buttons is a **.None** action
 
 The parameters buttons of AnimationStep constructor is a array with the button numers you want to perform that keep in mind that all buttons listed on the array will be lighted up together. If you want to make a progressive Animation, you need to pass more than one step to `addAnimation` function, each one with a tick of your animation. You can see some examples bellow.
 */
pad.addAnimation(buttonPosition: 1,
                 steps: [AnimationStep(action: .LightUp, buttons: [1]),
                         AnimationStep(action: .LightDown, buttons: [1])])

pad.addSound(buttonPosition: 0, fileName: "Chord1", lightColor: "Blue", shouldLoop: false)
pad.addAnimation(buttonPosition: 0,
                 steps: [AnimationStep(action: .LightUp, buttons: [0,1,2,3]),
                         AnimationStep(action: .LightDown, buttons: [0,1,2,3])])



pad.addSound(buttonPosition: 5, fileName: "Chord4", lightColor: "Yellow", shouldLoop: false)
pad.addAnimation(buttonPosition: 5,
                 steps: [AnimationStep(action: .LightUp, buttons: [5]),
                         AnimationStep(action: .LightDown, buttons: [5])])
pad.addSound(buttonPosition: 4, fileName: "Chord3", lightColor: "Orange", shouldLoop: false)
pad.addAnimation(buttonPosition: 4,
                 steps: [AnimationStep(action: .LightUp, buttons: [4,5,6,7]),
                         AnimationStep(action: .LightDown, buttons: [4,5,6,7])])

pad.addSound(buttonPosition: 15, fileName: "REC-1", lightColor: "Blue", shouldLoop: false)
pad.addAnimation(buttonPosition: 15,
                 steps: [AnimationStep(action: .LightUp, buttons: [15]),
                         AnimationStep(action: .LightDown, buttons: [15])])

pad.addSound(buttonPosition: 14, fileName: "REC-2", lightColor: "Yellow", shouldLoop: false)
pad.addAnimation(buttonPosition: 14,
                 steps: [AnimationStep(action: .LightUp, buttons: [14]),
                         AnimationStep(action: .LightDown, buttons: [14])])

pad.addSound(buttonPosition: 13, fileName: "REC", lightColor: "Orange", shouldLoop: false)
pad.addAnimation(buttonPosition: 13,
                 steps: [AnimationStep(action: .LightUp, buttons: [13]),
                         AnimationStep(action: .LightDown, buttons: [13])])

pad.addSound(buttonPosition: 10, fileName: "Effect", lightColor: "Orange", shouldLoop: false)
pad.addAnimation(buttonPosition: 10,
                 steps: [AnimationStep(action: .LightUp, buttons: [10]),
                         AnimationStep(action: .LightDown, buttons: [10])])

pad.addSound(buttonPosition: 9, fileName: "Effect2", lightColor: "Yellow", shouldLoop: false)
pad.addAnimation(buttonPosition: 9,
                 steps: [AnimationStep(action: .LightUp, buttons: [9]),
                         AnimationStep(action: .LightDown, buttons: [9])])

pad.addSound(buttonPosition: 11, fileName: "Big kick", lightColor: "Blue", shouldLoop: true)
pad.addAnimation(buttonPosition: 11,
                 steps: [AnimationStep(action: .LightUp, buttons: [11]),
                         AnimationStep(action: .LightDown, buttons: [11])])

pad.addAnimation(buttonPosition: 1, steps: [
                                            AnimationStep(action: .LightUp, buttons: [3]),
                                            AnimationStep(action: .LightUp, buttons: [7]),
                                            AnimationStep(action: .LightUp, buttons: [11]),
                                            AnimationStep(action: .LightDown, buttons: [3,7,11])])

//: To init the program you need to pass the view of your PadViewController to the PlaygroundPage with the command bellow.

PlaygroundPage.current.liveView = pad.view

