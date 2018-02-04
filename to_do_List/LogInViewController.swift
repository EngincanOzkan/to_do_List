//
//  LogInViewController.swift
//  to_do_List
//
//  Created by Engincan Özkan on 23.11.2017.
//  Copyright © 2017 Engincan Özkan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
   
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "login", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passField.text!){(user,error) in
            if error == nil{
                self.performSegue(withIdentifier: "login", sender: self)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
