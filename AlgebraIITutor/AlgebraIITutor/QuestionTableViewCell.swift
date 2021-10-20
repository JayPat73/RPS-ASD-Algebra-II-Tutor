//
//  QuestionTableViewCell.swift
//  AlgebraIITutor
//
//  Created by Jay Patel on 4/8/20.
//  Copyright © 2020 Rahil Shah. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell
{
    let dataman = DataMan.sharedInstance
    let databaseFunctions = DatabaseFunctions()
    var delegate: QuestionTableViewController?
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var topicText: UILabel!
    @IBOutlet weak var authorText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    
    var question: Question!
    var currentUserEmail: String!
    var QID: String!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

//        print(QID)
        // Configure the view for the selected state
    }

}
