//
//  Answer.swift
//  AlgebraIITutor
//
//  Created by Minhal Vakil on 4/5/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit

class Answer: NSObject {
    
    var answer:String?
    
    var answerNumber:Int?
    
    var userID:String?
    
    var QuestionID:String?
    var userID2: String?//userid on database
    
    
    init(answer:String, answerID:String, QuestionID:String)
    {
        self.answer = answer
        self.QuestionID = QuestionID
        let arrayOfUnderscores = answerID.findAllCharacters(char: "_")
        let answerNum = answerID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-1]+1, answerID.count)
        let UserID = answerID.getSubString(0, arrayOfUnderscores[arrayOfUnderscores.count-3]) + "@" + answerID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-3]+1, arrayOfUnderscores[arrayOfUnderscores.count-2]) + "." + answerID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-2]+1, arrayOfUnderscores[arrayOfUnderscores.count-1])
        userID = UserID
        userID2 = answerID.getSubString(0, arrayOfUnderscores[arrayOfUnderscores.count-1])
//        answerNumber = Int(answerNum)
        answerNumber = Int(answerNum)
        
    }
        
        
        
    }


