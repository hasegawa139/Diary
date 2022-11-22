//
//  SelectedItem.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

class SelectedItem: ObservableObject {
    @Published var selectedYear: String?
    @Published var selectedMonth: String?
    @Published var selectedDecoration: DiaryItem.Decoration?
    
    func showSelectedItem() -> some View {
        HStack {
            Text("選択条件")
            Text("年: \(selectedYear ?? "-"), 月: \(selectedMonth ?? "-"), アイコン:")
            if let decoration = selectedDecoration {
                Image(systemName: decoration.icon)
            } else {
                Text("-")
            }
        }
        .foregroundColor(.gray)
    }
}
