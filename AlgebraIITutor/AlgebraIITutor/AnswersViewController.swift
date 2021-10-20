//
//  AnswersViewController.swift
//  AlgebraIITutor
//
//  Created by Aniket Nedunuri on 4/20/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import FirebaseDatabase


class AnswersViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate
{
   //test - let names = ["Joe", "Bob", "Bill"]
    let dataMan = DataMan.dataSharedInstance
    let manager = PListManager.sharedInstance
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    let databaseFunctions = DatabaseFunctions()
    let answer1 = Answer(answer:"6", answerID:"bib_gmail_com_1", QuestionID:"bob_gmail_com_1")
    let answer2 = Answer(answer:"9", answerID:"bib_gmail_com_2", QuestionID:"bob_gmail_com_2")
    var arrayOfAnswers: [Answer]? = nil

    var question: Question?
    var currentIndex = 0
   
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var swipeRight: UISwipeGestureRecognizer!
    @IBOutlet weak var swipeLeft: UISwipeGestureRecognizer!
    @IBOutlet weak var nameAnswerTextView: UITextView!
    override func viewDidLoad()
        {
            super.viewDidLoad()
    //        print(question?.topic)
    //        print(question?.question)
                    topicLabel.text = question?.topic
            QuestionLabel.text = question?.question
            if question?.answers != []
            {
                self.swipeRight.delegate = self
                self.swipeRight.addTarget(self, action: #selector(self.swipe(_:)))
                self.swipeLeft.delegate = self
                self.swipeLeft.addTarget(self, action: #selector(self.swipe(_:)))
                if let name = question?.answers[0].userID, let answer = question?.answers[0].answer
                {
                    nameAnswerTextView.text = (name + "\n\n" + answer)
                }
                
            }
            
            
            
    //        extractQuestion()
    //        extractTopic()
            
            

            // Do any additional setup after loading the view.
        }
        @objc public func swipe(_ sender: UISwipeGestureRecognizer)
        {
            if sender.direction == .left
            {
                if currentIndex < question?.answers.count as! Int - 1
                {
                    currentIndex+=1
                }
                else
                {
                    currentIndex = 0
                    

                }
            }
            else if sender.direction == .right
            {
                if currentIndex > 0
                {
                    currentIndex-=1

                }
                else
                {
                    currentIndex = question?.answers.count as! Int - 1

                }
            }
            
            if let name = question?.answers[currentIndex].userID, let answer = question?.answers[currentIndex].answer
            {
                nameAnswerTextView.text = (name + "\n\n" + answer)
            }
        }
       
        

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }
