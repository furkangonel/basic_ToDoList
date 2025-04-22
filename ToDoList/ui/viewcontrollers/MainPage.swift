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
    var mainViewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        _ = mainViewModel.toDosList.subscribe(onNext: { list in
            
            self.toDosList = list
            self.tableView.reloadData()
        })
    }


    override func viewWillAppear(_ animated: Bool) {
        
        mainViewModel.fetch()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Geçiş yapıldı!")
        if segue.identifier == "toDetailVC" {
            if let toDo = sender as? ToDos {
                print("Veri: \(toDo.name!)")
                let toVC = segue.destination as! DetailVC
                
                toVC.toDo = toDo
            }
        }
    }
    
    
    
}


extension MainPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainViewModel.search(searchText: searchText)
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
                self.mainViewModel.remove(id: toDo.id!)
            }
            
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    
}

