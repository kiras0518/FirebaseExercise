//
//  Post.swift
//  
//
//  Created by YU on 2019/2/21.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Post {
    
    var postId: String
    var user: User
    var author: Author
    
    init(postId: String, author: Author, user: User) {
        //self.ref = nil
        self.postId = postId
        self.author = author
        self.user = user
        
        //ref = Database.database().reference().child("post").childByAutoId()
    }

}



struct User {
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}

struct Author {
    
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
}

struct Articles {
    
    let title: String
    let context: String
    let author: String
    let creatdate: String
    let like = 0
    let ref: DatabaseReference?
    
    init(title: String, context: String, author: String, creatdate: String) {
        self.title = title
        self.context = context
        self.author = author
        self.creatdate = creatdate
        ref = Database.database().reference().child("Articles").childByAutoId()
    }
    
    init?(snapshot: DataSnapshot) {

        guard let value = snapshot.value as? [String : Any],
           let title = value["title"] as? String,
           let context = value["context"] as? String,
           let author = value["author"] as? String,
           let creatdate = value["creatdate"] as? String,
           let like = value["like"] as? String else {

            return nil
        }

        self.ref = snapshot.ref
        self.title = title
        self.context = context
        self.author = author
        self.creatdate = creatdate

    }
    
    
    func save() {
        ref?.setValue(toAnyObject())
    }
    
    func toAnyObject() -> [String : Any]
    {
        return [
            "title" : title,
            "context" : context,
            "author" : author,
            "creatdata" : creatdate,
            "like" : like
        ]
    }
    
}


