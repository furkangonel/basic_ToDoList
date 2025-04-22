//
//  toDos.swift
//  ToDoList
//
//  Created by Furkan Gönel on 19.04.2025.
//



class ToDos {
    
    var id: Int?
    var name: String?
    
    
    init () {
    }
    
    init (id: Int, name: String) {
        self.id = id        // Shadowing denilir.
        self.name = name
        
    }
}
