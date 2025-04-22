//
//  SaveVC.swift
//  ToDoList
//
//  Created by Furkan Gönel on 19.04.2025.
//

import UIKit

class SaveVC: UIViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    var saveViewModel = SaveViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if let name = nameText.text {
            
            saveViewModel.save(name: name)
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    



}
