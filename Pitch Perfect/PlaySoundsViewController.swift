//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Eddie Groberski on 8/24/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

import UIKit
import AVFoundation


/*
* View Controller used to play recorded audio with several effects
*/
class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    @IBOutlet weak var stopButton: UIButton!
    
    
    /*
    * Audio button restoration ids
    */
    enum AudioButtons: String {
        case Snail = "snailButton"
        case Rabbit = "rabbitButton"
        case Chipmunk = "chipmunkButton"
        case Darth = "darthVaderButton"
    }
    
    
    /*
    * View has been loaded
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide stop button
        stopButton.hidden = true
        
        //Create audio player from recorded file
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl, error:&error)
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
        
        //Create audio engine
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        //Set delegate to hide stop button once audio has been played
        audioPlayer.delegate = self
    }
    
    
    // MARK: Sound Button Actions
    
    
    /*
    * Play audio based on button pressed
    */
    @IBAction func playAudio(sender: UIButton) {
        if let restId = sender.restorationIdentifier {
            switch restId {
            case AudioButtons.Snail.rawValue:
                changeAudioRate(0.5)
            case AudioButtons.Rabbit.rawValue:
                changeAudioRate(1.5)
            case AudioButtons.Chipmunk.rawValue:
                playAudioWithVariablePitch(1000)
            case AudioButtons.Darth.rawValue:
                playAudioWithVariablePitch(-1000)
            default:
                println("Could not find audio button!")
                break;
            }
        }
    }
    
    
    /*
    * Stop audio
    */
    @IBAction func stopAudio(sender: UIButton) {
        resetAudioPlayer()
        stopButton.hidden = true
    }
    
    
    // MARK: Audio Controls
    
    
    /*
    * Play audio with pitch changed
    */
    func changeAudioRate(rate: Float) {
        resetAudioPlayer()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    
    /*
    * Play audio with pitch changed
    */
    func playAudioWithVariablePitch(pitch: Float){
        //Reset player
        resetAudioPlayer()
        
        //Create player node
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        //Create pitch effect
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        //Connect node and pitch to audio engine
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        //Schedule playing of audio from file
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: ({self.stopButton.hidden = true}))
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    /*
    * Reset Audio Player and Audio Engine
    */
    func resetAudioPlayer() {
        // Stop and reset time of player
        audioPlayer.stop()
        audioPlayer.currentTime = NSTimeInterval(0)
        
        // Stop and reset engine
        audioEngine.stop()
        audioEngine.reset()
        
        //Show stop button
        stopButton.hidden = false
    }
    
    
    // MARK: Audio Player Delegate
    
    
    /*
    * Hide stop button once audio is done playing
    */
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        stopButton.hidden = true
    }
}
