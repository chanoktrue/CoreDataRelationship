//
//  ItemView.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import SwiftUI
import CoreData

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
//        List {
//            ForEach(items) { item in
//                HStack {
//                    Text(item.name ?? "")
//                    Spacer()
//                    Text(item.toCategory?.name ?? "Unknow")
//                }
//
//            }
//            .onDelete { indexSet in
//                itemVM.delete(indexSet: indexSet, items: items)
//            }
//        }
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.adaptive(minimum: 200))]) {
                    ForEach(items) { item in

                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                                .frame(width: 200, height: 200)
                                .padding(.horizontal, 5)
                                .overlay(
                                    Text(item.name ?? "")
                                        .foregroundColor(itemVM.selectedObjectId  == item.objectID  ? .red : .white)
                                        .font(.title)
                                        .fontWeight(.bold)
                                )
                                .shadow(color: Color.gray.opacity(itemVM.selectedObjectId == item.objectID  ? 0.5 : 0.0), radius: 15, x: 0, y: 10.0)
                                .padding()
                                .onTapGesture {
                                    self.itemVM.selectedObjectId  = item.objectID
                                }

                    }
                    
                }
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
