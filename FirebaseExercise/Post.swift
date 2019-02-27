//
//  Post.swift
//  
//
//  Created by YU on 2019/2/21.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    let uuid: String
    let email: String
    let firstName: String
    let lastName: String
    let userRef: DatabaseReference?
    
    init(uuid: String, email: String, firstName: String, lastName: String) {
        
        self.uuid = uuid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
       
        userRef = Database.database().reference().child("users").child(uuid)
    }
    
    init?(snapshot: DataSnapshot) {
//        if let value:[String : Any] = snapshot.value as? [String : Any] {
//            print(value)
//        } else {
//            print("error value")
//        }
//        if let value: [String : Any] = snapshot.value as? [String : Any ] {
//            print(value)
//            if let email = value["email"] as? String {
//                if let firstName = value["firstName"] as? String {
//                    if let lastName = value["lastName"] as? String {
//                        if let uuid = value["uuid"] as? String {
//
//                            self.userRef = snapshot.ref
//                            self.email = email
//                            self.firstName = firstName
//                            self.lastName = lastName
//                            self.uuid = uuid
//
//                        } else {
//                            print("error uuid")
//                        }
//                    } else {
//                        print("error lastName")
//                    }
//                } else {
//                    print("error firstName")
//                }
//            } else {
//                print("error email")
//            }
//        } else {
//            print("error value")
//        }
        
        guard let value = snapshot.value as? [String : Any] else { print("value error"); return nil }
        guard let email = value["email"] as? String else { print("email error"); return nil }
        guard let firstName = value["firstName"] as? String else { print("firstName error"); return nil }
        guard let lastName = value["lastName"] as? String else { print("lastName error"); return nil }
        guard let uuid = value["uuid"] as? String else { print("uuid error"); return nil }

        //print("value,email,firstName,lastName,uuid",value,email,firstName,lastName,uuid)
        
        self.userRef = snapshot.ref
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.uuid = uuid

    }
    
    func save() {
        userRef?.setValue(toAnyObject())
    }

    func toAnyObject()->[String : Any] {
        return [
            "uuid" : uuid,
            "email" : email,
            "firstName" : firstName,
            "lastName" : lastName,
        ]
    }
    
}

struct Articles {
    
    let title: String
    let context: String
    let creatdate: String
    var like = 0
    let ref: DatabaseReference?
    let uuid: String
    var fullName: String?

    init(title: String, context: String, creatdate: String, uuid: String) {
        
        self.title = title
        self.context = context
        self.creatdate = creatdate
        self.uuid = uuid
        
        ref = Database.database().reference().child("posts").childByAutoId()
    }
    
    init?(snapshot: DataSnapshot) {

        guard let value = snapshot.value as? [String : Any] else { return nil }
        guard let title = value["title"] as? String else { return nil }
        guard let context = value["context"] as? String else  { return nil}
        guard let creatdate = value["creatdate"] as? String else { return nil }
        guard let like = value["numberOflike"] as? Int else { return nil }
        guard let uuid = value["uuid"] as? String else { return nil }
        
        self.ref = snapshot.ref
        self.title = title
        self.context = context
        self.creatdate = creatdate
        self.uuid = uuid
        self.like = like
        
    }
    
    func save() {
        ref?.setValue(toAnyObject())
    }
    //回傳到firebase上
    func toAnyObject() -> [String : Any]
    {
        return [
            "title" : title,
            "context" : context,
            "creatdate" : creatdate,
            "numberOflike" : like,
            "uuid" : uuid
        ]
    }
    
}


