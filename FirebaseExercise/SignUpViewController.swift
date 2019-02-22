//
//  SignUpViewController.swift
//  FirebaseExercise
//
//  Created by YU on 2019/2/21.
//  Copyright © 2019 ameyo. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exitBarButton()
    }
    
    func exitBarButton() {
        let cannel = UIButton(type: .system)
        cannel.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        cannel.tintColor = .white
        cannel.setImage(UIImage(named: "icon-cross"), for: .normal)
        cannel.addTarget(self, action: #selector(SignUpViewController.onClose)
            , for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cannel)
    }
    
    @objc func onClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        //輸入驗證
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let mail = emailTextField.text,
            let password = passwordTextField.text,
            firstName.count > 0, lastName.count > 0,
            mail.count > 0, password.count > 0
            else {
            
            let alert = UIAlertController(title: "Sign In Failed", message: "請輸入完整資訊", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //Firebase註冊建立帳號
        Auth.auth().createUser(withEmail: mail, password: password, completion: { firuser, error in
            
            if error == nil {
                Auth.auth().signIn(withEmail: mail, password: password)
                print("登入成功!")
                if let articles = self.storyboard?.instantiateViewController(withIdentifier: "ArticlesTableViewController") {
                    self.present(articles, animated: true, completion: nil)
                }
                
            }
            if error != nil {
                let alert = UIAlertController(title: "註冊失敗", message: error?.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                print("註冊失敗",error?.localizedDescription as Any)
                
            }
            let newUser = User.init(uid: (firuser?.user.uid)!,email: self.emailTextField.text!, firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!)
            newUser.save()
//            let usersRef : DatabaseReference = Database.database().reference().child("User").childByAutoId()
//            var userDataRemote: [String : AnyObject] = [String : AnyObject]()
//            userDataRemote["userId"] as? AnyObject
//            userDataRemote["usedEmail"] as? AnyObject
//            userDataRemote["firstName"] as? AnyObject
//            
//            usersRef.setValue(userDataRemote) { (err, ref) in
//                if err != nil {
//                    print("err： \(err!)")
//                    return
//                }
//                print("DDDDDDDD")
//                print(ref.description())
//            }
            
        })
        
        
        
        
        
        
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
