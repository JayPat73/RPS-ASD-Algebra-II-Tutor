//
//  QuestionTableViewController.swift
//  AlgebraIITutor
//
//  Created by Jay Patel on 4/8/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class QuestionTableViewController: UITableViewController
{
    @IBAction func addQuestion (_ sender: UIBarButtonItem) {
              let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "NewQuestion")
       
          vc.modalPresentationStyle = .popover
          let popover: UIPopoverPresentationController = vc.popoverPresentationController!
         popover.barButtonItem = sender
           present(vc, animated: true, completion:nil)
             }
      
        
    var questionList: [Question] = []
    
    var currentUserEmail: String = ""
    
    var counter = 0
    
    let dataMan = DataMan.dataSharedInstance
    let manager = PListManager.sharedInstance
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    let databaseFunctions = DatabaseFunctions()
    
    
    override func viewDidLoad()
    {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.tableView.allowsSelection = true
        if(Reachability.isConnectedToNetwork())
        {
            self.databaseFunctions.loadHelper(completion:
            { (QuestionArray) in
            
                self.questionList = QuestionArray
                
                DispatchQueue.main.async
                {
                                     
                    self.tableView.reloadData()
                }
            })
        }
        
        
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = true
        
        //super.viewDidLoad()
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Ammount of questions
        return questionList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //Change if needed
        return 120
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionTableViewCell
        
        cell.delegate = self

        // Configure the cell...
        if questionList != []
        {
      
            cell.question = questionList[indexPath.row]
            cell.QID = questionList[indexPath.row].questionID
            
        cell.currentUserEmail = currentUserEmail
            if let qText = questionList[indexPath.row].question
        {
            cell.questionText.text = qText
        }
            if let topic = questionList[indexPath.row].topic
        {
            cell.topicText.text = topic
        }
            if let author = questionList[indexPath.row].userID
        {
            cell.authorText.text = author
        }
        
        
        //counter += 1
        }
//        print(questionList[indexPath.row].questionID)
        return cell
    }
    
    // not working
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath as IndexPath) as! QuestionTableViewCell
        NSLog("You selected cell number: \(indexPath.row)!")
        self.dataMan.currentQuestionID = questionList[indexPath.row].questionID!
        print("TESTTEST")
        self.performSegue(withIdentifier: "go", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AnswersViewController
        {
            let vc = segue.destination as? AnswersViewController
            if let QuestionIndex = tableView.indexPathForSelectedRow?.row
            {
                vc?.question = questionList[QuestionIndex]
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
