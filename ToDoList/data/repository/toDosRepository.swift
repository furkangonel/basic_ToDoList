//
//  toDosRepository.swift
//  ToDoList
//
//  Created by Furkan Gönel on 23.04.2025.
//

import Foundation
import RxSwift
import FMDB


class ToDosRepository {
    
    var toDosList = BehaviorSubject<[ToDos]>(value: [ToDos]())
    
    let db : FMDatabase?
    
    
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databasePath = URL(fileURLWithPath: targetPath).appendingPathComponent("todo_app.splite")
        db = FMDatabase(path: databasePath.path)
    }
    
    
    func save(name: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERt INTO toDos (name) VALUES (?)", values: [name])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    
    func update(id: Int, name: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE toDos SET name=? WHERE id=?", values: [name, id])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    func search(searchText: String) {
        db?.open()
        
        do {
            var list = [ToDos]()
            
            let result = try db!.executeQuery("SELECT * FROM toDos WHERE name LIKE '%\(searchText)%'", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id")!)!
                let name = result.string(forColumn: "name")!
                
                let toDo = ToDos(id: id, name: name)
                
                list.append(toDo)
            }
            
            toDosList.onNext(list) // Tetikleme
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    func remove(id: Int) {
        
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM toDos WHERE id=?", values: [id])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    func fetchToDos() {
        db?.open()
        
        do {
            var list = [ToDos]()
            
            let result = try db!.executeQuery("SELECT * FROM toDos", values: nil)
            
            while result.next() {
                let id = Int(result.string(forColumn: "id")!)!
                let name = result.string(forColumn: "name")!
                
                let toDo = ToDos(id: id, name: name)
                
                list.append(toDo)
            }
            
            toDosList.onNext(list) // Tetikleme
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
}
