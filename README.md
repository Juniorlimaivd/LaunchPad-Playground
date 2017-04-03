## LaunchPad Playground

### Description

LaunchPad playground is a environment that aims to create a closer experience to a real LaunchPad where you can experiment different sounds and animations with more freedom and less costs than other platforms. As a musician, i always wanted a Launch Pad to experiment new ways of making music, but here in Brazil it is too expensive and goes out of my budget. So, Launch Pad is firstly a environment where music lovers with similar conditions to mine can develop your talents with as few obstacles as possible ,but is also a place where you can develop yourself as a programmer. The code structure was made in a form that even people with little experience with programming can use this playground, and as they wan't to go further with your experiences, they can use the playground to make more complicated animations and add new features to your digital Launch Pad.  It's all about giving tools to people to do what they have passion for.


### How to use

First of all, make a instance of ``PadViewController``, that is where your LaunchPad is built. A PadView Controller instance creates for you a Launch Pad 4 x 4 no sound attached. The button's numerations goes from **0 to 15** , counting from left to right, up to down.

```swift

let pad = PadViewController()

```

#### Adding Sound
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

 ```swift

pad.addSound(buttonPosition: 1, fileName: "Chord2", lightColor: "Pink", shouldLoop: false)

 ```

 #### Adding Animations

 To add Animation when a button you need to call the function `addAnimation`
 from PadViewController.

 **`addAnimation` Parameters**

 * **buttonPosition** : A integer from 0 to 15 representing the position of the button.
 * **steps** : A **Array of Animation Steps** that represents the animation itself. Each step will be performed synchronously. Only after the step before finish, the next step will start.

 #### AnimationStep

 AnimationStep is a struct with a action and a list of buttons that you want to perform the action of that step. The type of **action** is a `AnimationAction` enum that  have the following possible values :

 * **.LightUp** : Is equivalent to turn the light of the button on.
 * **.LightDown** : Is equivalent to turn the light of the button off.
 * **.None** : Is equivalent to do nothing with the button.

 The default action of all buttons is a **.None** action

 The parameters buttons of AnimationStep constructor is a array with the button numbers you want to perform that keep in mind that all buttons listed on the array will be lighted up together. If you want to make a progressive Animation, you need to pass more than one step to `addAnimation` function, each one with a tick of your animation. You can see one example bellow.


```swift

pad.addAnimation(buttonPosition: 1,
                 steps: [AnimationStep(action: .LightUp, buttons: [1]),
                         AnimationStep(action: .LightDown, buttons: [1])])

```
