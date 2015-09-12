//
//  RecordAudio.swift
//  Pitch Perfect
//
//  Created by Eddie Groberski on 8/25/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

import Foundation


/*
* Recorded audio from microphone
*/
class RecordedAudio: NSObject{
    let filePathUrl: NSURL!
    let title: String!
    
    /*
    * Init RecordedAudio with file path and title
    */
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}