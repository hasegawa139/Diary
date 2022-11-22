//
//  DiaryListFormView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DiaryListFormView: View {
    @ObservedObject var userData: UserData
    
    @State private var selectedDiary: DiaryItem?
    @Binding var diaries: [DiaryItem]
    
    var body: some View {
        List {
            ForEach(diaries) { diary in
                DiaryListRowView(diary: diary)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedDiary = diary
                    }
            }
            .sheet(item: $selectedDiary) { diary in
                DiaryView(userData: userData, diary: diary, diaryIndex: userData.diaries.firstIndex(of: diary))
            }
        }
    }
}

struct DiaryListFormView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListFormView(userData: UserData.test(), diaries: .constant(UserData.test().diaries))
    }
}
