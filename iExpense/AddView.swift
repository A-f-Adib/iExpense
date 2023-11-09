//
//  AddView.swift
//  iExpense
//
//  Created by A.f. Adib on 11/10/23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var Name = ""
    @State private var Typee = "Personal"
    @State private var Amount =  0
    
    var expenses : Expenses
    
    let types = ["Personal", "Business", "Family"]
    
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Add name", text: $Name)
                
                Picker("Type", selection: $Typee) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $Amount, format: .currency(code: "BDT"))
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let saveItem = ExpenseItem(name: Name , type: Typee, amount: Amount)
                    expenses.items.append(saveItem)
                    dismiss()
                    
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
