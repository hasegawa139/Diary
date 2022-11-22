//
//  DecorationPickerView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DecorationPickerView: View {
    @ObservedObject var selectedItem: SelectedItem
    @Binding var extractedDiaryList: [DiaryItem]
    
    @State private var diariesDecorationList: [DiaryItem.Decoration] = []
    
    var body: some View {
        Picker("アイコン", selection: $selectedItem.selectedDecoration) {
            Text("選択しない").tag(DiaryItem.Decoration?.none)
            ForEach(diariesDecorationList, id: \.self) { decoration in
                Image(systemName: decoration.icon).tag(DiaryItem.Decoration?.some(decoration))
            }
        }
        .pickerStyle(.wheel)
        .onAppear {
            extractDiariesDecoration()
        }
        .onChange(of: extractedDiaryList) {_ in
            extractDiariesDecoration()
        }
    }
    
    func extractDiariesDecoration() {
        for diary in extractedDiaryList {
            diariesDecorationList.append(diary.decoration)
        }
        diariesDecorationList = Set(diariesDecorationList).sorted(by: { (a, b) -> Bool in
            return a.rawValue < b.rawValue
        })
    }
}

struct DecorationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DecorationPickerView(selectedItem: SelectedItem(), extractedDiaryList: .constant(UserData.test().diaries))
    }
}
