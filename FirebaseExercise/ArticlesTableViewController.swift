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
    
//    let articlesRef = Database.database().reference().child("Articles")
    var articles: [Articles] = []
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        //super.viewDidAppear(animated)
//
//        //downliad data
////        articlesRef.observe(.value, with: { (snapshot) in
////            self.articles.removeAll()
////            print(snapshot)
////        })
//    }
    
    @IBAction func composeTouch(_ sender: Any) {
        
        if let ComposeViewController = storyboard?.instantiateViewController(withIdentifier: "ComposeViewController") {
            self.present(ComposeViewController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get data
        let articlesRef = Database.database().reference().child("Articles")
        var newArticles: [Articles] = []
        
        articlesRef.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
            
            for child in snapshot.children {
                
                if let childSnapshot = child as? DataSnapshot,
                    let articlesItem = Articles(snapshot: childSnapshot) {
                     newArticles.append(articlesItem)
                }
               
            }
            self.articles = newArticles
            self.tableView.reloadData()
            
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
