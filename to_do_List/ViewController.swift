//
//  ViewController.swift
//  to_do_List
//
//  Created by Engincan Özkan on 23.11.2017.
//  Copyright © 2017 Engincan Özkan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var todoData = [String]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("data").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            guard let value = snapshot.value as? NSDictionary else{
                print("The user has No data in our database")
                return
            }
            let todoItems = value["todoItem"] as? [String]
            self.todoData = todoItems!
            self.tableView.reloadData()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        self.title = "UITableView"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count; //dizinin adeti kadar cell çağırıyoruz
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell //cell in idsini bizim custom cell idmiz yapıyoruz.
        
        cell.commonInit(todoData[indexPath.row])
        
        return cell
    }//dönen satır kadar çalışır
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be
    }
    
    @IBAction func addItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Add An Item", message: "Please add  a to do item to your list", preferredStyle: .alert)
        
        
        
        let enterAction = UIAlertAction(title: "Enter", style: .default, handler:{(_) in
            
            if let field = alertController.textFields![0] as? UITextField{
               
                self.todoData.append(field.text!)
                self.ref.child("data").child((Auth.auth().currentUser?.uid)!).setValue(["todoItem":self.todoData])
                self.tableView.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:{(_) in})
        
        alertController.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "To-Do item"
        })
        
        alertController.addAction(enterAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            todoData.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.ref.child("data").child((Auth.auth().currentUser?.uid)!).setValue(["todoItem":self.todoData])
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "back", sender: self)
        }catch{
            print("No user is logged in")
        }
    }
    
}

