//
//  ArticlesTableViewCell.swift
//  FirebaseExercise
//
//  Created by YU on 2019/2/21.
//  Copyright © 2019 ameyo. All rights reserved.
//

import UIKit
import Firebase

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    
    
    var like: [Articles] = []
    
    @IBAction func likePressed(_ sender: Any) {

        let ref = Database.database().reference()
        let keyToPost = ref.child("posts").childByAutoId().key
        
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
