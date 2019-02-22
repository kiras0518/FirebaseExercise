//
//  compose1ViewController.swift
//  FirebaseExercise
//
//  Created by YU on 2019/2/21.
//  Copyright © 2019 ameyo. All rights reserved.
//

import UIKit
import Firebase

class ComposeViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exitBarButton()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func postTouch(_ sender: Any) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let today = dateFormatter.string(from: date)
        
        let title = titleTextField.text
        let context = contentTextView.text
        
        if title?.isEmpty == false {
            
            let newStory = Articles(title: title!, context: context!, author: "我是誰", creatdate: today)
            newStory.save()
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
   
    
    
    func exitBarButton() {
        
        let cannel = UIButton(type: .system)
        cannel.frame = CGRect(x: 0, y: 30, width: 50, height: 50)
        cannel.tintColor = .white
        cannel.setImage(UIImage(named: "icon-cross"), for: .normal)
        cannel.addTarget(self, action: #selector(ComposeViewController.onClose)
            , for: .touchUpInside)
      
        self.view.addSubview(cannel)
    }
    
    @objc func onClose() {
        dismiss(animated: true, completion: nil)
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
