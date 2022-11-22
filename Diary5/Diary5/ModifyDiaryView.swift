//
//  ModifyDiaryView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct ModifyDiaryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userData: UserData
    
    @Binding var diary: DiaryItem
    let diaryIndex: Int?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    DiaryFormView(decoration: $diary.decoration, date: $diary.date, text1: $diary.text1, text2: $diary.text2, totalChars1: diary.text1.count, totalChars2: diary.text2.count)
                    
                    Button(action: {
                        updateDiary()
                        dismiss()
                    }) {
                        Text("更新")
                            .font(.title2)
                    }
                    .disabled(diary.text1.isEmpty || diary.text2.isEmpty)
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            undoDiaryUpdate()
                            dismiss()
                        }) {
                            Text("キャンセル")
                        }
                    }
                }
            }
        }
    }
    
    func updateDiary() {
        if let index = diaryIndex {
            print(index)
            userData.diaries[index] = diary
            userData.changedDiary = diary
            print(userData.diaries)
        }
    }
    
    func undoDiaryUpdate() {
        if let index = diaryIndex {
            diary = userData.diaries[index]
        }
    }
}

struct ModifyDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyDiaryView(userData: UserData.test(), diary: .constant(UserData.test().diaries.first!), diaryIndex: 0)
    }
}
