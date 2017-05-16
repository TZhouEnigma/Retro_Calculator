//
//  ViewController.swift
//  RetroCalculator
//
//  Created by chuxiang zhou on 5/12/17.
//  Copyright © 2017 chuxiang zhou. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var OutputLabel: UILabel!
    
    var currentOperation = Operation.Empty
    var leftValString = ""
    var rightValString = ""
    var runningNumber = ""
    var result = ""
    var btnSound: AVAudioPlayer!
    
    enum Operation: String{
    case Divide = "/"
    case Multiply = "*"
    case Subtract = "-"
    case Add = "+"
    case Empty =  "Empty"
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
       OutputLabel.text = "0"
    }
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        OutputLabel.text = runningNumber
    }
    @IBAction func onDividePressed(sender: AnyObject){
    processOperation(operation: .Divide)
    
    }
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
        
    }
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
        
    }
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
        
    }
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
        
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        
        playSound()
        leftValString = ""
        rightValString = ""
        currentOperation = .Empty
        runningNumber = "0"
        result = "0"
        OutputLabel.text = result
    
        
    }
    
    func playSound(){
        if btnSound.isPlaying{
        btnSound.stop()
        }
       btnSound.play()
    }
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            
            //user selected an operator
            if runningNumber != ""{
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                }
                else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                }
                else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                leftValString = result
                OutputLabel.text = result
            }
            
            currentOperation = operation
        }else{
        
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

