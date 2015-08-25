//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Eddie Groberski on 8/24/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        stopButton.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        recordButton.enabled = false
        stopButton.hidden = false
    }
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true
        recordButton.enabled = true
        stopButton.hidden = true
    }
}

