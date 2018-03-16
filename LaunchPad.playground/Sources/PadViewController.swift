import Foundation
import UIKit
import AVFoundation

public enum AnimationAction : String {
    case LightUp = "lightUp"
    case LightDown = "lightDown"
    case None = ""
}

public struct AnimationStep {
    public let action : AnimationAction
    public let buttons : [Int]
    public init(action:AnimationAction, buttons:[Int]) {
        self.action = action
        self.buttons = buttons
    }
}



public class PadViewController : UIViewController,AVAudioPlayerDelegate, CAAnimationDelegate{
    let borderDistance = 30
    let buttonDistance = 10
    var buttonWidth = 0
    var buttonVector : [MusicButton] = []
    var audioPlayers = [AVAudioPlayer](repeating: AVAudioPlayer(), count: 16)
    var soundsNames  = [String](repeating: "", count: 16)
    var colorsVector = [[UIColor]](repeating: [UIColor(red: 81.0/255.0, green: 167.0/255.0, blue: 249.0/255.0, alpha: 1.0),
                                              UIColor(red: 3.0/255.0, green: 101.0/255.0, blue: 101.0/255.0, alpha: 1.0)],
                                  count: 16)
    var animations = [[AnimationStep]](repeating:[AnimationStep(action: .None, buttons: [0])], count: 16)
    var animationIndex = [Int](repeating: 0, count: 16)
    var shouldLoop = [Bool](repeating: false, count: 16)
    var isPlaying = [Bool](repeating: false, count: 16)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        self.view.backgroundColor = UIColor.lightGray
        buttonWidth = (Int(self.view.frame.width) - 2*borderDistance - 3*buttonDistance)/4
        
        for i in 0..<16 {
            
            let button = MusicButton(frame:
                CGRect(x: borderDistance + (i%4)*(buttonDistance+buttonWidth),
                       y: borderDistance + (i/4)*(buttonDistance+buttonWidth),
                       width: buttonWidth,
                       height: buttonWidth))
            button.target(forAction: #selector(buttonTapped(sender:)), withSender: self)
            
            button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: UIControlEvents.touchDown)
            button.backgroundColor = UIColor.darkGray
            button.position = i
            button.layer.cornerRadius = 5.0
            
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 3, height: 3)
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 0.3
            buttonVector.append(button)
            self.view.addSubview(button)
           
            let gradient = RadialGradientLayer(center: button.center,
                                               radius: button.frame.width/2 + 20,
                                               colors: [UIColor.gray.cgColor,UIColor.darkGray.cgColor])
            gradient.frame = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.width)
            gradient.center = CGPoint(x: button.bounds.width/2, y: button.bounds.height/2)
            gradient.bounds = button.bounds

            gradient.setNeedsDisplay()
            
            button.layer.insertSublayer(gradient, at: 0)
            

            
        }
        
        
    }
    
    public func addSound(buttonPosition:Int, fileName:String, lightColor:String,shouldLoop : Bool)
    {
        soundsNames[buttonPosition] = fileName
        self.shouldLoop[buttonPosition] = shouldLoop
        switch lightColor {
        case "Blue":
            colorsVector[buttonPosition] = [UIColor(red: 81.0/255.0, green: 167.0/255.0, blue: 249.0/255.0, alpha: 1.0),
                                            UIColor(red: 3.0/255.0, green: 101.0/255.0, blue: 192.0/255.0, alpha: 1.0)]
            break;
        case "Yellow":
            colorsVector[buttonPosition] = [UIColor(red: 249.0/255.0, green: 81.0/255.0, blue: 84.0/255.0, alpha: 1.0),
                                            UIColor(red: 192/255.0, green: 165.0/255.0, blue: 3.0/255.0, alpha: 1.0)]
            break;
        case "Orange":
            colorsVector[buttonPosition] = [UIColor(red: 255.0/255.0, green: 246.0/255.0, blue: 128.0/255.0, alpha: 1.0),
                                            UIColor(red: 192/255.0, green: 3.0/255.0, blue: 6.0/255.0, alpha: 1.0)]
        case "Pink":
            colorsVector[buttonPosition] = [UIColor(red: 249.0/255.0, green: 81.0/255.0, blue: 188.0/255.0, alpha: 1.0),
                                            UIColor(red: 123.0/255.0, green: 40.0/255.0, blue: 92.0/255.0, alpha: 1.0)]
            break;
        default:
            break;
        }
    }
    
    public func addAnimation(buttonPosition:Int, steps: [AnimationStep]){
        animations[buttonPosition] = steps
    }
    
    public func lightUpButton(buttonPosition : Int,animationIndex : Int){
        
        let sender = buttonVector[buttonPosition]
        let gradient = sender.layer.sublayers?[0] as! RadialGradientLayer
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        animation.fromValue = gradient.colors
        gradient.colors = [colorsVector[sender.position][0].cgColor,colorsVector[sender.position][1].cgColor]
        animation.toValue = [colorsVector[sender.position][0].cgColor,colorsVector[sender.position][1].cgColor]
        animation.duration = 0.2
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        animation.setValue("lightup"+String(animationIndex), forKey: "type")
        gradient.add(animation, forKey:"animateGradient")
        
        
        gradient.bounds = sender.bounds
        gradient.setNeedsDisplay()
        
    }
    
    public func lightDownButton(buttonPosition : Int, animationIndex : Int){
        
        let sender = buttonVector[buttonPosition]
        let gradient = sender.layer.sublayers?[0] as! RadialGradientLayer
        
        let colors = [UIColor.gray,UIColor.darkGray]

        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        animation.fromValue = gradient.colors
        gradient.colors = [colors[0].cgColor,colors[1].cgColor]
        animation.toValue = [colors[0].cgColor,colors[1].cgColor]
        animation.duration = 1.0
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        animation.setValue("lightdown"+String(animationIndex), forKey: "type")
        gradient.add(animation, forKey:"animateGradient")


        gradient.bounds = sender.bounds
        gradient.setNeedsDisplay()
        
    }
    
    @objc func buttonTapped(sender: MusicButton!) {
        
        
        if (sender.position >= 0 && sender.position < 16 && soundsNames[sender.position] != "") {
            
            
            
            if let tapsoundurl = Bundle.main.url(forResource: soundsNames[sender.position], withExtension: "aif") {
                if sender.position < audioPlayers.count && sender.position >= 0 {
                    
                    try! audioPlayers[sender.position] = AVAudioPlayer(contentsOf: tapsoundurl)
                    audioPlayers[sender.position].delegate = self
                    
                    if shouldLoop[sender.position] {
                        audioPlayers[sender.position].numberOfLoops = -1
                    }
                    
                }
                if isPlaying[sender.position] && shouldLoop[sender.position] {
                    isPlaying[sender.position] = false
                } else {
                    audioPlayers[sender.position].prepareToPlay()
                    self.audioPlayers[sender.position].play()
                    isPlaying[sender.position] = true
                    
                    animationIndex[sender.position] = 0
                    
                    if animations[sender.position][animationIndex[sender.position]].action == .LightUp {
                        for position in animations[sender.position][animationIndex[sender.position]].buttons {
                            if position < 16 {
                                lightUpButton(buttonPosition: position, animationIndex: sender.position)
                            }
                            
                        }
                        
                    } else if animations[sender.position][animationIndex[sender.position]].action == .LightDown {
                        for position in self.animations[sender.position][animationIndex[sender.position]].buttons {
                            if position < 16 {
                                self.lightDownButton(buttonPosition: position, animationIndex: sender.position)
                            }
                            
                        }
                    }
                }
                
                
        }
           
            
        
        
        
            
        }
        
        
        
        
        
        
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {

        for i in 0..<16 {
        
            if (anim.value(forKey: "type") as! String == "lightup"+String(i)) {
                
                animationIndex[i] += 1;
                if animationIndex[i] < animations[i].count {
                    
                    if animations[i][animationIndex[i]].action == .LightUp {
                        
                        for position in animations[i][animationIndex[i]].buttons {
                            if position < 16 {
                                lightUpButton(buttonPosition: position, animationIndex: i)
                            }
                            
                        }
                        
                    } else if animations[i][animationIndex[i]].action == .LightDown {
                        for position in self.animations[i][animationIndex[i]].buttons {
                            if position < 16 {
                                self.lightDownButton(buttonPosition: position, animationIndex: i)
                            }
                            
                        }
                    }
                    
                }
                
                
                
                
            } else if (anim.value(forKey: "type") as! String == "lightdown"+String(i)) {
                animationIndex[i] += 1;
                if animationIndex[i] < animations[i].count {
                    
                    if animations[i][animationIndex[i]].action == .LightUp {
                        
                        for position in animations[i][animationIndex[i]].buttons {
                            if position < 16 {
                                lightUpButton(buttonPosition: position, animationIndex: i)
                            }
                            
                        }
                        
                    } else if animations[i][animationIndex[i]].action == .LightDown {
                        for position in self.animations[i][animationIndex[i]].buttons {
                            if position < 16 {
                                self.lightDownButton(buttonPosition: position, animationIndex: i)
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
    }

}
