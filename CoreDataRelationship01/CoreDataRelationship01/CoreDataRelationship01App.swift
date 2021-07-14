//
//  CoreDataRelationship01App.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import SwiftUI

@main
struct CoreDataRelationship01App: App {
    
    let persistentController = PersistentController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentController.viewContect)
        }
    }
}
