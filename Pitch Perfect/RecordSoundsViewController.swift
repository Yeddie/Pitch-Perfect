//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Eddie Groberski on 8/24/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

import UIKit
import AVFoundation


/*
* View Controller to record audio from microphone
*/
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var paused: Bool = false
    
    
    // MARK: UIViewController methods
    
    
    /*
    * View did load
    */
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    /*
    * View will appear
    */
    override func viewWillAppear(animated: Bool) {
        self.pauseButton.setImage(UIImage(named: "pause.png"), forState: .Normal)
        changeButtonStates(true)
    }
    
    
    /*
    * Transition to PlaySoundViewController
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    
    // MARK: Sound Button Actions
    
    
    /*
    * Record audio from microphone
    */
    @IBAction func recordAudio(sender: UIButton) {
            //Change button visibility
            changeButtonStates(false)
            
            //Create file path of file
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            let recordingName = "my_audio.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            
            var session = AVAudioSession.sharedInstance()
            session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            
            //Create audio recorder
            audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
    }
    

    /*
    * Stop recording audio
    */
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        changeButtonStates(true)
    }
    
    
    /*
    * Resume / Pause recording audio
    */
    @IBAction func resumePauseRecording(sender: UIButton) {
        var recordText: String
        var imageName: String
        
        if audioRecorder.recording {
            recordText = "Paused!"
            imageName = "resume.png"
            audioRecorder.pause()
        } else {
            recordText = "Recording..."
            imageName = "pause.png"
            audioRecorder.record()
        }
        recordingInProgress.text = recordText
        self.pauseButton.setImage(UIImage(named: imageName), forState: .Normal)
    }
    
    
    // MARK: Update View
    
    
    /*
    * Change visibility UI elements
    */
    func changeButtonStates(doneRecording: Bool){
        recordingInProgress.text = doneRecording ? "Tap to record!" : "Recording..."
        recordButton.enabled = doneRecording
        stopButton.hidden = doneRecording
        pauseButton.hidden = doneRecording
    }
    
    
    // MARK: Audio Player Delegate
    
    
    /*
    * Audio has finished recording
    */
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            // Audio recorded successfully
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            //Transition to PlaySoundsViewController
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("recording was not successful")
            changeButtonStates(true)
        }
    }
    

}

