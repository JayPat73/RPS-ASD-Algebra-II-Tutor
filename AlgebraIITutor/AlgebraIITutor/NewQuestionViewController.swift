//
//  NewQuestionViewController.swift
//  AlgebraIITutor
//
//  Created by Sid Bose on 5/7/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit

class NewQuestionViewController: UIViewController
{
    let dataman = DataMan.sharedInstance
    let databaseFunctions = DatabaseFunctions()
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var questionTitle: UITextField!
    
    @IBOutlet weak var question: UITextView!
    
    @IBAction func submit(_ sender: Any)
    {
        if(questionTitle.text! != "" && question.text! != "")
        {
            let temp: [Answer] = []
            print("YESSSSSSSSSSSSS")
//            print(self.dataman.id)
            databaseFunctions.askQuestion(Question(questionID: self.dataman.id+"_0", question:question.text!, topic:questionTitle.text!, answers: temp))
        }
        else
        {
            let alertController = UIAlertController(title: "Not Enough Information", message:
                "Please make sure you entered all the information.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func cancel(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
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


