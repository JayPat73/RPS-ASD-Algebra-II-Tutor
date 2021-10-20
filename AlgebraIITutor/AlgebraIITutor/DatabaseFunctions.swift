//
//  DatabaseFunctions.swift
//  AlgebraIITutor
//
//  Created by Jack on 4/8/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.

import UIKit
import Firebase
import FirebaseDatabase
class DatabaseFunctions: NSObject
{
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    let dataman = DataMan.sharedInstance
    let manager = PListManager.sharedInstance

    //this version is without timestamp*
    //for explanations of I and J, see dataman
    public func askQuestion(_ question: Question)
    {
        if(Reachability.isConnectedToNetwork())//use online database
        {
            self.ref = Database.database().reference()
            self.ref?.observeSingleEvent(of: .value, with: { snapshot in
                if !snapshot.exists() { return }
            let dict = snapshot.value! as! NSDictionary
                
                self.dataman.newestNum = dict.object(forKey: "newestNum") as! Int//get newest number of question id
                self.dataman.I = dict.object(forKey: "numberOfNewQuestion") as! Int//get I
            // print(dict.object(forKey: "newestNum") as! Int)

            
            let QuestionID = question.userID2! + "_" + String(self.dataman.newestNum)
                self.ref?.child(QuestionID).setValue(["question":question.question!, "topic":question.topic!,"numberOfAnswers":0] as NSDictionary)//update
            
            //update numbers
            self.ref?.child("newestNum").setValue(self.dataman.newestNum+1)
            self.ref?.child("numberOfNewQuestion").setValue(self.dataman.I+1)
            //update plist
                self.manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: QuestionID, data: ["question":question.question!, "topic":question.topic!,"numberOfAnswers":0])
                self.manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: "newestNum", data: ["temp":self.dataman.newestNum+1])
                self.manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: "numberOfNewQuestion", data: ["temp":self.dataman.I+1])
            
            })
        }
        else//use plist
        {
            //get data
            let tmp = manager.readFromDocumentsDirectoryPlist(namePlist: "dat", key: "newestNum") as! NSDictionary
            self.dataman.newestNum = tmp.object(forKey: "temp") as! Int
            
            let tmp2 = manager.readFromDocumentsDirectoryPlist(namePlist: "dat", key: "numberOfNewQuestion") as! NSDictionary
            self.dataman.I = tmp2.object(forKey: "temp") as! Int
            
            //update plist
            let QuestionID = question.userID2! + "_" + String(self.dataman.newestNum)
            
            manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: QuestionID, data: ["question":question.question!, "topic":question.topic!,"numberOfAnswers":0])
            manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: "newestNum", data: ["temp":self.dataman.newestNum+1])
            manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: "numberOfNewQuestion", data: ["temp":self.dataman.I+1])
        }
                
    }

    public func answerQuestion(_ answer: Answer)
    {
        if(Reachability.isConnectedToNetwork())//use online database
        {
            self.ref = Database.database().reference()
            self.ref?.observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            let dict = snapshot.value! as! NSDictionary
            let dict2 = dict.object(forKey: answer.QuestionID!) as! NSDictionary
            //get J
            self.dataman.J = dict2.object(forKey: "numberOfAnswers") as! Int
            
            let AnswerID = answer.userID2! + "_" + String(self.dataman.J+1)
            for(key, _) in dict//if the question id corresponding to the answer exists in database, update
            {
                if(key as! String == answer.QuestionID!)
                {
                    //update numbers
                    self.ref?.child(answer.QuestionID!).updateChildValues(([AnswerID:answer.answer!,"numberOfAnswers":self.dataman.J+1] as NSDictionary) as! [AnyHashable : Any])
                    
                    //update plist
                    self.manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: answer.QuestionID!, data:[AnswerID:answer.answer!,"numberOfAnswers":self.dataman.J+1])
                    break
                }
            }
            })
        }
        else//use plist
        {
            //get J from plist
            let tmp = manager.readFromDocumentsDirectoryPlist(namePlist: "dat", key: answer.QuestionID!) as! NSDictionary
            self.dataman.J = tmp.object(forKey: "numberOfAnswers") as! Int
            
            let AnswerID = answer.userID2! + "_" + String(self.dataman.J+1)
            //same as above
            for(key, _) in manager.readMainBundlePList(namePList: "dat")//if the question id corresponding to the answer exists in plist
            {
                if(key as! String == answer.QuestionID!)
                {
                    manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: answer.QuestionID!, data:[AnswerID:answer.answer!,"numberOfAnswers":self.dataman.J+1])
                    break
                }
            }
            
        
        }
        
    }
    //load from database
    public func loadHelper(completion: @escaping([Question]) ->())
    {
            self.ref = Database.database().reference()
            var arrayOfQuestions:[Question] = []
            self.ref?.observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }
                
            let dictt = snapshot.value! as! NSDictionary
            
            self.dataman.I = dictt.object(forKey: "numberOfNewQuestion") as! Int
                
            if(self.dataman.I > 0)//if the database is not empty
            {
                
                for (k1, _) in dictt
                {
                    //get the question ids in order
                    if(k1 as! String == "numberOfNewQuestion" || k1 as! String == "newestNum")
                    { continue }
                    
                    //initialize everything
                    
                    let QuestionID = k1 as! String
                    
                    let dict2 = dictt.object(forKey: QuestionID) as! NSDictionary
                    
                    let numberOfAnswers = dict2.object(forKey: "numberOfAnswers") as! Int
                    let question = dict2.object(forKey: "question") as! String
                    let topic = dict2.object(forKey: "topic") as! String
                    
                    var temp:[(String,String)] = []
                    if(numberOfAnswers > 0)//has at least 1 answer
                    {
                        
                        for(key, value) in dict2
                        {
                            if((key as! String).last?.isNumber == true)//if keys are answers
                            {
//                                print(key as! String)
//                                print(value as! String)
                                temp.append((key as! String, value as! String))
                            }
                        }
                    }
                    //create the question class and store questions in dataman.
                    //we don't need an array of answers because they can be found in corresponding questions
                    
                    arrayOfQuestions.append(Question(questionID:QuestionID, question:question, topic:topic, arrayOfTuple: temp))
                    
                }
                completion(arrayOfQuestions)
            }
        })
    }
    public func loadFromPlist()
    {
        self.dataman.I = manager.readFromDocumentsDirectoryPlist(namePlist: "dat", key: "numberOfNewQuestion") as! Int
        let dict = manager.readMainBundlePList(namePList: "dat") as NSDictionary
        if(dict.count > 1)//if plist is not empty, read from it
        {
            // the same method as above
            if(self.dataman.I > 0)
            {
                for (k1, _) in dict
                {
                    //get the question ids in order
                    if(k1 as! String == "numberOfNewQuestion")
                    { continue }
                    
                    //initialize everything
                    let QuestionID = dict.object(forKey: k1 as! String) as! String
                    
                    let dict2 = dict.object(forKey: QuestionID) as! NSDictionary
                    
                    let numberOfAnswers = dict2.object(forKey: "numberOfAnswers") as! Int
                    let question = dict2.object(forKey: "question") as! String
                    let topic = dict2.object(forKey: "topic") as! String
                    
                    var temp:[(String,String)] = []
                    if(numberOfAnswers > 0)//has at least 1 answer
                    {
                        for(key, value) in dict2
                        {
                            if((key as! String).last?.isNumber == true)//if keys are answers
                            {
                                temp.append((key as! String, value as! String))
                            }
                        }
                    }
                    //create the question class and store questions in dataman.
                    //we don't need an array of answers because they can be found in corresponding questions
                     self.dataman.arrayOfQuestions.append(Question(questionID:QuestionID, question:question, topic:topic, arrayOfTuple: temp))
                    
                }
        }
        }
            
    }
    //sync firebase with plist.
    
    public func syncc()
    {
        self.ref = Database.database().reference()
        var I = 0
        for(key,value) in manager.readMainBundlePList(namePList: "dat")
        {
            self.ref?.child(key as! String).setValue((key as! String,value as! NSDictionary))//sync
        }
        self.ref?.observeSingleEvent(of: .value, with: { snapshot in
        
            let dict = snapshot.value! as! NSDictionary
            I = dict.count - 2
            self.ref?.child("numberOfNewQuestion").setValue(I)//sync
            for(key,value) in dict
            {
                self.manager.writeToDocumentsDirectoryPlist(namePlist: "dat", key: key as! String, data: value as? NSMutableDictionary ?? ["":""])
            }
            
        })
    }

}

