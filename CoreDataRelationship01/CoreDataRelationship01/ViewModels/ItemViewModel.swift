//
//  ItemViewModel.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import SwiftUI
import CoreData

class ItemViewModel: ObservableObject {
    
    let viewContext = PersistentController.shared.viewContect
    
    @Published var selectedObjectId: NSManagedObjectID?
    
    func save() {
        do{
            try viewContext.save()
        }catch{
            viewContext.rollback()
        }
    }
    
    func add(category: FetchedResults<Category>.Element?) {
        let item = Item(context: viewContext)
        item.name = "Item: \(Date())"
        item.toCategory = category
        save()
    }
    
    func update() {
        
    }
    
    func delete(indexSet: IndexSet, items: FetchedResults<Item>) {
        withAnimation {
            indexSet.map({items[$0]}).forEach(viewContext.delete)
            save()
        }
    }
    
}
