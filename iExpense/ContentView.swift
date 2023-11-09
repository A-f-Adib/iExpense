//
//  ContentView.swift
//  iExpense
//
//  Created by A.f. Adib on 11/5/23.
//

import SwiftUI

struct ExpenseItem:Identifiable , Codable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Int
    
}




class Expenses : ObservableObject {
   @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decoedItems
                return
            }
        }
        items = []
    }
}




struct ContentView: View {
    
    @StateObject private var expenses = Expenses()
    @State private var showSheet = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment : .leading) {
                            
                            Text(item.name)
                                .font(.title)
                            Text(item.type)
                                .font(.subheadline)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "BDT"))
                    }
                   
                }
                .onDelete(perform: removeItem)
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add", action: {
                    showSheet.toggle()
                })
                   
            }
            .sheet(isPresented: $showSheet) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItem(at offsets : IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
