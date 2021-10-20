//
//  DataMan.swift
//  AlgebraIITutor
//
//  Created by 张皓景 on 3/26/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DataMan: NSObject {
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var I: Int = 0//totalNumberOFNewQuestions
    var J: Int = 0//numberOfAnswers under current class
    var newestNum: Int = 0// newest number after underscores of questions
    // var arrayOfAnswers:[Answer] = []
    var arrayOfQuestions:[Question] = []//latest version after reading from database

    var dict: NSDictionary = [:]

    var email: String = ""
    var id:String = ""
    var currentQuestionID: String = ""

    
    public func getName(_ str: String, completion: @escaping(Bool) -> ())
    {
        self.ref = Database.database().reference()
        databaseHandle = ref?.child("").observe(.childAdded, with:
        {(snapshot) in
            let key = snapshot.key
            if key == "name"
            {
                let storedName = snapshot.value! as! String
                if(storedName == "")
                {
                    completion(true)
                }
            }
                
        })
    }
    static var dataSharedInstance = DataMan()
    
    static var sharedInstance: DataMan
    {
        return self.dataSharedInstance
    }

}
