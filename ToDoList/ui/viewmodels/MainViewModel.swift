//
//  MainViewModel.swift
//  ToDoList
//
//  Created by Furkan Gönel on 23.04.2025.
//

import Foundation
import RxSwift


class MainViewModel {
    
    var toDosRepository = ToDosRepository()
    var toDosList = BehaviorSubject<[ToDos]>(value: [ToDos]())
    
    
    init() {
        toDosList = toDosRepository.toDosList // Connection
    }
    
    
    func search(searchText: String) {
        toDosRepository.search(searchText: searchText)
    }
    
    
    func remove(id: Int) {
        toDosRepository.remove(id: id)
        fetch()
    }
    
    func fetch() {
        toDosRepository.fetchToDos()
    }
    
}
