//
//  ContentView.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)])
    var categorys: FetchedResults<Category>
    
    var body: some View {
        NavigationView {
            CategoryView()
            ItemView(category: categorys.count > 0 ? categorys[0] : nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
