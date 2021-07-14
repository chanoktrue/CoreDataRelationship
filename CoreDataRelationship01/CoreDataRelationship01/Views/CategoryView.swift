//
//  CategoryView.swift
//  CoreDataRelationship01
//
//  Created by Thongchai Subsaidee on 14/7/2564 BE.
//

import SwiftUI

struct CategoryView: View {
    
    @StateObject var categoryVM = CategoryViewModel()
    
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
    )
    var categorys: FetchedResults<Category>
    
    var body: some View {
        VStack {
            List {
                ForEach(categorys) { category in                    
                    NavigationLink(destination: ItemView(category: category)) {
                        Text(category.name ?? "")
                    }
                }
                .onDelete(perform: { indexSet in
                    categoryVM.delete(indexSet: indexSet, categorys: categorys)
                })
            }
            
            Spacer()
            
            HStack{
                TextField("Enter category", text: $categoryVM.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                Button(action: {
                    categoryVM.add()
                }, label: {
                    Text("Save")
                })
            }
            .padding(.horizontal, 10)
        }
        .navigationBarTitle(Text("Category"))
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
