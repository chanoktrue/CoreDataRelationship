//
//  ItemView.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import SwiftUI

struct ItemView: View {
    
    @StateObject var itemVM = ItemViewModel()
    var category: FetchedResults<Category>.Element?
    
    @FetchRequest
    var items: FetchedResults<Item>
    
    init(category: FetchedResults<Category>.Element?) {
        self.category = category
        self._items = FetchRequest(
            entity: Item.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K == %@", #keyPath(Item.toCategory.name), category?.name ?? "")
        )
    }
    
    var body: some View {
        List {
            ForEach(items) { item in
                HStack {
                    Text(item.name ?? "")
                    Spacer()
                    Text(item.toCategory?.name ?? "Unknow")
                }
            }
            .onDelete { indexSet in
                itemVM.delete(indexSet: indexSet, items: items)
            }
        }
        .navigationBarTitle(Text("\(category?.name ?? "") >> Item"))
        
        .navigationBarItems(trailing: Button(action: {
            itemVM.add(category: category)
        }, label: {
            Text("Add")
        }))
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView(category: FetchedResults<Category>.Element())
//    }
//}
