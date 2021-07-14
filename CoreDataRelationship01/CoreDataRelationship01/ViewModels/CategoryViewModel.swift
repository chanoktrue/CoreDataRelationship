//
//  CategoryViewModel.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import SwiftUI

class CategoryViewModel: ObservableObject {
    
    let viewContext = PersistentController.shared.viewContect
    
    @Published var name: String = ""
    
    func save() {
        do{
            try viewContext.save()
        }catch{
            viewContext.rollback()
        }
    }
    
    func add() {
        withAnimation {
            let category = Category(context: viewContext)
            category.name = name
            save()
            name = ""
        }
    }
    
    func delete(indexSet: IndexSet, categorys: FetchedResults<Category>) {
        withAnimation {
            indexSet.map({categorys[$0]}).forEach(viewContext.delete)
            save()
        }
    }
    
    func update(categry: FetchedResults<Category>.Element?) {
        withAnimation {
            categry?.name = "\(categry?.name ?? "")::\(Date())"
            save()
        }
    }
    
}
