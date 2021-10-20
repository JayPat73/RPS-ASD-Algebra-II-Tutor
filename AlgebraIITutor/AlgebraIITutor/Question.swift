//
//  Question.swift
//  AlgebraIITutor
//
//  Created by Minhal Vakil on 4/5/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit

class Question: NSObject {
    
    var question:String?
    var questionNumber:Int?
    var userID:String?
    var questionID:String?
    var userID2:String?
    var topic: String?
    var answers:[Answer] = []
     init(questionID:String, question:String, topic:String, answers:[Answer])
       {
           self.question = question
           self.questionID = questionID
           self.topic = topic
           self.answers = answers
            let arrayOfUnderscores = questionID.findAllCharacters(char: "_")
           let questionNum = questionID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-1]+1, questionID.count)
                  let UserID = questionID.getSubString(0, arrayOfUnderscores[arrayOfUnderscores.count-3]) + "@" + questionID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-3]+1, arrayOfUnderscores[arrayOfUnderscores.count-2]) + "." + questionID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-2]+1, arrayOfUnderscores[arrayOfUnderscores.count-1])
           questionNumber = Int(questionNum)
           userID = UserID
           userID2 = questionID.getSubString(0, arrayOfUnderscores[arrayOfUnderscores.count-1])
       
           
       }
       //Decided to add another way to create the answers within the Question
       //The tuple should be (answer, answerID)
       init(questionID:String, question:String, topic:String, arrayOfTuple:[(String,String)])
           
       {
           self.question = question

           self.questionID = questionID
           self.topic = topic
           let arrayOfUnderscores = questionID.findAllCharacters(char: "_")
           let questionNum = questionID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-1]+1, questionID.count)
                  let UserID = questionID.getSubString(0, arrayOfUnderscores[arrayOfUnderscores.count-3]) + "@" + questionID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-3]+1, arrayOfUnderscores[arrayOfUnderscores.count-2]) + "." + questionID.getSubString(arrayOfUnderscores[arrayOfUnderscores.count-2]+1, arrayOfUnderscores[arrayOfUnderscores.count-1])
           questionNumber = Int(questionNum)
           userID = UserID
           for answer in arrayOfTuple
           {
//             print(answer.0)
//             print(answer.1)
               answers.append(Answer(answer: answer.1, answerID: answer.0, QuestionID: questionID))
                
           }
       
           
       }
   
//sortQuestionArrayNewest
    static func sortQuestionArrayNewest(array:[Question])->[Question]
    {
        return array.sorted(by: { $0.questionNumber! > $1.questionNumber! })
    }
    static func sortQuestionArrayOldest(array:[Question])->[Question]
    {
           return array.sorted(by: { $0.questionNumber! < $1.questionNumber! })
    }
}
extension String
{
    public func getSubString(_ from : Int, _ to : Int) -> String
    {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: to)
        return String(self[start..<end])
    }
    public func indexOfOneCharacter(character: String)->Int
    {
        let length = self.count
        var i = 0
        while i < length
        {
            let subString = self.getSubString(i, i+1)
            if subString==character
            {
                return i
            }
            i+=1
        }
        return -1
    }
    public func indexOfCharacters(characters: String)->Int
    {
        let length = self.count
        var i = 0
        let charactersLength=characters.count
        while i < length+1-charactersLength
        {
            let subString = self.getSubString(i, i+charactersLength)
            if subString==characters
            {
                return i
            }
            i+=1
        }
        return -1
    }
    public func findAllCharacters(char:String) -> [Int]
    {
        var indices = [Int]()
        
        var searchStartIndex = self.startIndex
        
        
        while searchStartIndex < self.endIndex,let range = self.range(of: char,range: searchStartIndex..<self.endIndex)
        
        {
            let index = self.distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        return indices
        
    }
    
}


