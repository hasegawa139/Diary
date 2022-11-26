//
//  DiaryListFormView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DiaryListFormView: View {
    @EnvironmentObject var userData: UserData
    
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
                DiaryView(diary: diary, diaryIndex: userData.diaries.firstIndex(of: diary))
					.environmentObject(userData)
            }
        }
    }
}

struct DiaryListFormView_Previews: PreviewProvider {
    static var previews: some View {
		let userData = UserData.test()
        DiaryListFormView(diaries: .constant(UserData.test().diaries))
			.environmentObject(userData)
    }
}
