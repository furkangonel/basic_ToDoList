//
//  SaveViewModel.swift
//  ToDoList
//
//  Created by Furkan Gönel on 23.04.2025.
//

import Foundation


class SaveViewModel {
    
    
    var toDosRepository = ToDosRepository()
    
    
    func save(name: String) {
        toDosRepository.save(name: name)
    }
    
    
}
