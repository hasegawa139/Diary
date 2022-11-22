//
//  DiaryListRowView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DiaryListRowView: View {
    let diary: DiaryItem
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: diary.decoration.icon)
                    Text(diary.date.formatDateForDiary())
                }
                
                Divider()
                
                Text(diary.text1)
                    .lineLimit(1)
                
                Divider()
                
                Text(diary.text2)
                    .lineLimit(1)
            }
        }
    }
}

struct DiaryListRowView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListRowView(diary: UserData.test().diaries.first!)
    }
}
