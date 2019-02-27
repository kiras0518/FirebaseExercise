//
//  ArticlesTableViewController.swift
//  FirebaseExercise
//
//  Created by YU on 2019/2/21.
//  Copyright © 2019 ameyo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ArticlesTableViewController: UITableViewController {

    @IBOutlet weak var composeButton: UIBarButtonItem!
    @IBOutlet weak var singOutButton: UIBarButtonItem!

    var articles: [Articles] = []
    var loadNameOfAuthors: [User] = []
    
    let usersRef = Database.database().reference(withPath: "users")
    let articlesRef = Database.database().reference(withPath: "posts")
    
    @IBAction func composeTouch(_ sender: Any) {
        
        if let composeViewController = storyboard?.instantiateViewController(withIdentifier: "ComposeViewController") {
            self.present(composeViewController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func signOutTouch(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            print("登出成功")
        } catch {
            let alert = UIAlertController(title: "Logout", message: "ERROR", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let loginViewController = storyboard?.instantiateViewController(withIdentifier: "loginViewController") {
            self.present(loginViewController, animated: true, completion: nil)
        }
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Get data 欄位傳回View
        articlesRef.observe(.value, with: { snapshot in
            //print(snapshot.value as Any)
            var newArticles: [Articles] = []

            print("snapshot.children", snapshot.childrenCount)

            for child in snapshot.children {

                if let childSnapshot = child as? DataSnapshot {

                    if let articlesItem = Articles(snapshot: childSnapshot){

                       
                        print("@@@articlesItem@@@", articlesItem)
                        //self.articles.append(articlesItem)
                        newArticles.append(articlesItem)
                        
                    } else {
                        print("Error userItem...")
                    }
                } else {
                    print("Error articlesItem")
                }
            }
            self.articles = newArticles
            self.tableView.reloadData()

            var index = 0

            for article in self.articles {

                self.loadName(index: index, uuid: article.uuid)

                index += 1
            }

        })
        
        //self.tableView.estimatedRowHeight = storyboard.
//        self.tableView.rowHeight = UITableView.automaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadName(index: Int, uuid: String) {
        
        self.usersRef.child(uuid).observeSingleEvent(of: .value , with: { snapshot in

            if let userItem = User(snapshot: snapshot) {
                
                self.articles[index].fullName = userItem.firstName + userItem.lastName
                
                let indexPath = IndexPath(row: index, section: 0)
                
                print("@@indexPath@@",indexPath)
                
                self.tableView.reloadRows(at: [indexPath], with: .fade)
                
            } else { print("Error handl...") }
            
        })

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("articles.count", articles.count)
        
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesCell", for: indexPath) as! ArticlesTableViewCell
        
        let articlesItem = articles[indexPath.row]
        //print("@@articlesItem@@",articlesItem)
        
//        if let fullName = articles[indexPath.row].fullName {
//            
//            print("fullNamettttt", fullName)
//        }
        
        cell.titleLabel.text = articlesItem.title
        cell.contentLabel.text = articlesItem.context
        cell.dateLable.text = articlesItem.creatdate
        cell.nameLable.text = articlesItem.fullName
        
        cell.likeButton.layer.cornerRadius = 4
        //cell.likeButton.layer.opacity = 0.2
        cell.likeButton.addTarget(self, action: #selector(clickLike(sender:)), for: .touchUpInside)
        
        
        return cell
    }
 

    @objc func clickLike(sender: UIButton) {
        print("click!")
        //let buttonPoint = sender
        //buttonPoint.setTitleColor(UIColor.white, for: .normal)
        sender.tintColor = UIColor.red
        sender.layer.borderColor = UIColor.red.cgColor
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
