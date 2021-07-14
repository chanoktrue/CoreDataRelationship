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
                                                           .foregroundColor(.white)
                                                           .font(.title)
                                                           .fontWeight(.bold)
                                                   )
                            .shadow(color: Color.gray.opacity(0.3), radius: 15, x: 0, y: 10.0)
                            .padding()
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

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView(category: FetchedResults<Category>.Element())
//    }
//}
