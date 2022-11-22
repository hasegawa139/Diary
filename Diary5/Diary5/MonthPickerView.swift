//
//  MonthPickerView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct MonthPickerView: View {
    @ObservedObject var selectedItem: SelectedItem
    @Binding var extractedDiaryList: [DiaryItem]
    
    @State private var diariesMonthList: [String] = []
    
    var body: some View {
        Picker("月", selection: $selectedItem.selectedMonth) {
            Text("選択しない").tag(String?.none)
            ForEach(diariesMonthList, id: \.self) { month in
                Text(month).tag(String?.some(month))
            }
        }
        .pickerStyle(.wheel)
        .onAppear {
            extractDiariesMonth()
        }
        .onChange(of: extractedDiaryList) {_ in
            extractDiariesMonth()
        }
    }
    
    func extractDiariesMonth() {
        for diary in extractedDiaryList {
            diariesMonthList.append(diary.date.formatDateForMonth())
        }
        diariesMonthList = Set(diariesMonthList).sorted()
    }
}

struct MonthPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MonthPickerView(selectedItem: SelectedItem(), extractedDiaryList: .constant(UserData.test().diaries))
    }
}
