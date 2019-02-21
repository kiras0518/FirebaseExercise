//
//  ViewController.swift
//  FirebaseExercise
//
//  Created by YU on 2019/2/20.
//  Copyright © 2019 ameyo. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func loginTouch(_ sender: Any) {
        
        //輸入驗證
        guard let email = loginEmail.text, let password = loginPassword.text, email.count > 0, password.count > 0 else {
            
            let alert = UIAlertController(title: "Sign In Failed", message: "請輸入帳號密碼", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default));
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func createTouch(_ sender: Any) {
        
        if let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") {
            self.present(signUpViewController, animated: true, completion: nil)
            
        }
//        if let signUpViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//        let mailField = loginEmail.text!
//        let passwordField = loginPassword.text!
//
//        let alert = UIAlertController(title: "Register", message: "🖖", preferredStyle: .alert)
//
//        let saveAction = UIAlertAction(title: "註冊", style: .default) { _ in
//
//            let mailField = alert.textFields![0]
//            let passwordField = alert.textFields![1]
//
//            //Firebase註冊建立帳號
//            Auth.auth().createUser(withEmail: mailField.text!, password: passwordField.text!, completion: { user, error in
//
//                if error == nil {
//
//                    Auth.auth().signIn(withEmail: mailField.text!, password: passwordField.text!)
//                    print("登入成功!")
//                }
//                if error != nil {
//                    print("註冊失敗",error?.localizedDescription)
//
//                }
//
//            })
//
//        }


//        alert.addTextField { textEmail in
//            textEmail.placeholder = "Enter your email"
//        }
//
//        alert.addTextField { textPassword in
//            textPassword.isSecureTextEntry = true
//            textPassword.placeholder = "Enter your password"
//        }
//
//        alert.addAction(saveAction)
//        alert.addAction(UIAlertAction(title: "取消", style: .destructive))

        //self.present(alert, animated: true, completion: nil) ;
        
    }
    
}

//extension ViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == loginEmail {
//            loginPassword.becomeFirstResponder()
//        }
//        if textField == loginPassword {
//            textField.resignFirstResponder()
//        }
//        return true
//    }
//}
