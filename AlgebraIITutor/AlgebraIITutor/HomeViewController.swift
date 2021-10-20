//
//  HomeViewController.swift
//  AlgebraIITutor
//
//  Created by Bhargav on 4/13/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class HomeViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let dataMan = DataMan.dataSharedInstance
    let manager = PListManager.sharedInstance
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    let databaseFunctions = DatabaseFunctions()
    
    var email = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //example of calling the load function
    public func load()
    {
        if(Reachability.isConnectedToNetwork())
        {
            self.databaseFunctions.loadHelper(completion:
            { (QuestionArray) in
                
                print(QuestionArray)
                
            })
        }
        else//read from plist
        {
            self.databaseFunctions.loadFromPlist()
        }
    }
    
    override func viewDidLoad() {
        
        load()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        print(self.dataMan.arrayOfQuestions)


    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(!appDelegate.hasAlreadyLaunched){
            appDelegate.sethasAlreadyLaunched()
            print("Has not launched before")
        }else{
            readFromPlist()
            if email != ""{
                signIn(email: email)
            }
        }
    }
    
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z_]+@[A-Za-z]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func readFromPlist(){
                let tmp = manager.readFromDocumentsDirectoryPlist(namePlist: "Auth", key: "Email") as! NSDictionary
                self.dataMan.email = tmp.object(forKey: "email") as! String
                email = self.dataMan.email
    }
    
    func writeToPlist(){
        manager.writeToDocumentsDirectoryPlist(namePlist: "Auth", key: "Email", data: ["email" : String(email)])
    }
    
    func signIn(email: String){
        print(self.email)
        performSegue(withIdentifier: "signIn", sender: nil)
    }


    @IBAction func signInButton(_ sender: Any) {
        email = emailTextField.text!
        
        if isValidEmail(email: email){
            print(email)
            writeToPlist()
            signIn(email: email)
        }else{
            let alertController = UIAlertController(title: "Invalid Email", message:
                "Please make sure you typed a valid email.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
            emailTextField.text = ""
            email = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionTableViewController
        {
            let vc = segue.destination as? QuestionTableViewController
            
//            let tmp = email.indexOfCharacters(characters: "@")
//            var tmp2 = dataMan.id
            
          
//            dataMan.id = tmp2
            dataMan.id = email.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
//            dataMan.id = email.replacingOccurrences(of: ".", with: "_")
            print("HOMEVIEWCONTROLLER")
            print(dataMan.id)
            
            vc?.currentUserEmail = email
        }
    }
}


