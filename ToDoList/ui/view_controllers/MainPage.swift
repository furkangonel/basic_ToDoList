//
//  ViewController.swift
//  ToDoList
//
//  Created by Furkan Gönel on 19.04.2025.
//

import UIKit

class MainPage: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var toDosList = [ToDos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
        
        let t1 = ToDos(id: 11, name: "Ekmek al.")
        let t2 = ToDos(id: 12, name: "Bootcamp yayına katılmayı unutma!")
        let t3 = ToDos(id: 13, name: "Doğum günü uyarısı!")
        toDosList.append(t1)
        toDosList.append(t2)
        toDosList.append(t3)
        
        tableView.delegate = self
        tableView.dataSource = self
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Geçiş yapıldı!")
        if segue.identifier == "toDetailVC" {
            if let toDo = sender as? ToDos {
                print("Veri: \(toDo.name)")
                let toVC = segue.destination as! DetailVC
                
                
                toVC.toDo = toDo
            }
        }
    }
    
    
    
}


extension MainPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search Todo: \(searchText)")
    }
}

extension MainPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDosCell
        let toDo = toDosList[indexPath.row]
        cell.todoLabel?.text = toDo.name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDosList[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: toDo)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") {
            contextualAction, view, bool in  //closure
            
            let toDo = self.toDosList[indexPath.row]
            
            let alert = UIAlertController(title: "Remove Process", message: "Should the \(toDo.name!) be deleted?", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            let okButton = UIAlertAction(title: "Ok", style: .destructive) { action in
                print("To Do delete: \(toDo.name!)")
            }
            
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    
}

