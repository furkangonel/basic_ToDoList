//
//  DetailVC.swift
//  ToDoList
//
//  Created by Furkan Gönel on 19.04.2025.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var nameText: UITextField!
    
    var toDo: ToDos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tempToDo = toDo {
            nameText.text = tempToDo.name
        }
    }
    
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if let name = nameText.text, let tempToDo = toDo {
                update(name: name)
        }
    }
    
    
    func update(name: String) {
        print("Update todo: \(name)")
    }
    

}
