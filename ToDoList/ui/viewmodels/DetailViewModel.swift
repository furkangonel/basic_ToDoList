//
//  DetailViewModel.swift
//  ToDoList
//
//  Created by Furkan Gönel on 23.04.2025.
//

import Foundation



class DetailViewModel {
    
    var toDosRepository = ToDosRepository()
    
    
    func update(id: Int, name: String) {
        toDosRepository.update(id: id, name: name)
    }
    
}
