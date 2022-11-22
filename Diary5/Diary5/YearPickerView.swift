//
//  YearPickerView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct YearPickerView: View {
    @ObservedObject var selectedItem: SelectedItem
    @Binding var extractedDiaryList: [DiaryItem]
    
    @State private var diariesYearList: [String] = []
    
    var body: some View {
        Picker("年", selection: $selectedItem.selectedYear) {
            Text("選択しない").tag(String?.none)
            ForEach(diariesYearList, id: \.self) { year in
                Text(year).tag(String?.some(year))
            }
        }
        .pickerStyle(.wheel)
        .onAppear {
            extractDiariesYear()
        }
        .onChange(of: extractedDiaryList) {_ in
            extractDiariesYear()
        }
    }
    
    func extractDiariesYear() {
        for diary in extractedDiaryList {
            diariesYearList.append(diary.date.formatDateForYear())
        }
        diariesYearList = Set(diariesYearList).sorted()
    }
}

struct YearPickerView_Previews: PreviewProvider {
    static var previews: some View {
        YearPickerView(selectedItem: SelectedItem(), extractedDiaryList: .constant(UserData.test().diaries))
    }
}
