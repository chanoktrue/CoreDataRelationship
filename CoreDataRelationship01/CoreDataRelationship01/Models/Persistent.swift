//
//  Persistent.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import CoreData

class PersistentController {
    
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    let viewContect: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable load coredate with error: \(error.localizedDescription)")
            }
        }
        viewContect = container.viewContext
    }
    
}
