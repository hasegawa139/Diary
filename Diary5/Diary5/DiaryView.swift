//
//  DiaryView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DiaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    
    @State var diary: DiaryItem
    let diaryIndex: Int?
    
    @State private var showingModifyDiaryView = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: diary.decoration.icon)
                        Text(diary.date.formatDateForDiary())
                    }
                    
                    Divider()
                    
                    Text(diary.text1)
                    
                    Divider()
                    
                    Text(diary.text2)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray))
                .padding()
                
                Spacer()
                
                Button(action: {
                    showingModifyDiaryView = true
                }) {
                    Text("日記を編集")
                }
                .sheet(isPresented: $showingModifyDiaryView) {
                    ModifyDiaryView(diary: $diary, diaryIndex: diaryIndex)
                }
                .padding()
                
                Button(action: {
                    showingAlert = true
                }) {
                    Text("日記を削除")
                }
                .alert("確認", isPresented: $showingAlert) {
                    Button("削除", role: .destructive) {
                        removeDiary()
                        dismiss()
                    }
                    
                    Button("キャンセル", role: .cancel) { }
                } message: {
                    Text("この日記を削除しますか？")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("閉じる")
                    }
                }
            }
        }
    }
    
    func removeDiary() {
        if let index = diaryIndex {
            userData.changedDiary = userData.diaries.remove(at: index)
            print(userData.diaries)
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
		let userData = UserData.test()
        DiaryView(diary: UserData.test().diaries.first!, diaryIndex: 0)
			.environmentObject(userData)
    }
}
