//
//  Polls.swift
//  Yreply
//
//  Created by Akshat Jagga on 02/06/19.
//  Copyright © 2019 Akshat Jagga. All rights reserved.
//

import Foundation
class Polls {
    var pollId: String
    var question: String
    var choices: NSArray
    var timeStamp: Int64
    
    
    init(id : String, q : String, choices: NSArray, time: Int64) {
        self.pollId = id
        self.question = q
        self.choices = choices
        self.timeStamp = time
    }
}
