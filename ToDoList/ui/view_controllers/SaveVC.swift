//
//  SaveVC.swift
//  ToDoList
//
//  Created by Furkan Gönel on 19.04.2025.
//

import UIKit

class SaveVC: UIViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if let name = nameText.text {
            save(name: name)
        }
    }
    
    
    func save(name: String) {
        print("Save todo: \(name)")
    }
    


}
