//
//  NewAnswerViewController.swift
//  AlgebraIITutor
//
//  Created by Neha Panduri on 5/27/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit

class NewAnswerViewController: UIViewController
{
    
    let dataman = DataMan.sharedInstance
    let databaseFunctions = DatabaseFunctions()
    @IBOutlet weak var answerTitle: UITextField!
    
    
    @IBOutlet weak var answer: UITextView!
    
    
    @IBAction func submit(_ sender: Any)
    {
         if(answerTitle.text! != "" && answer.text! != "")
        {
            print("YESSSSSSSSSSSSS")
            print(self.dataman.currentQuestionID)
            databaseFunctions.answerQuestion(Answer(answer:answer.text!, answerID:self.dataman.id+"_0", QuestionID: self.dataman.currentQuestionID))
        }
        else
        {
            let alertController = UIAlertController(title: "Not Enough Information", message:
                "Please make sure you entered all the information.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancel(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
