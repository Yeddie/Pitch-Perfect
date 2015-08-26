//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Eddie Groberski on 8/24/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    let slowRate: Float = 0.5
    let fastRate: Float = 1.5
    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.hidden = true
//        if var soundPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!) {
//            var error:NSError?
//            audioPlayer = AVAudioPlayer(contentsOfURL:soundPath, error:&error)
//            
//        } else {
//            println("Could not find audio file path")
//        }
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl, error:&error)
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
    }
    
    @IBAction func slowAudio(sender: UIButton) {
        changeAudioRate(slowRate)
    }

    @IBAction func fastAudio(sender: UIButton) {
        changeAudioRate(fastRate)
    }
    
    func changeAudioRate(rate: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = NSTimeInterval(0)
        audioPlayer.rate = rate
        audioPlayer.play()
        stopButton.hidden = false
    }
    
    @IBAction func chipmunkAudio(sender: UIButton) {

    }
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = NSTimeInterval(0)
        stopButton.hidden = true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
