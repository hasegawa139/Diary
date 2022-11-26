//
//  ExtractedDiariesView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct ExtractedDiariesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var selectedItem: SelectedItem
    
    @Binding var extractedDiaryList: [DiaryItem]
    
    var body: some View {
        NavigationView {
            VStack {
                DiaryListFormView(diaries: $extractedDiaryList)
                
                Text("\(extractedDiaryList.count)件")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ExtractedDiariesView_Previews: PreviewProvider {
    static var previews: some View {
		let userData = UserData.test()
		let selectedItem = SelectedItem()
        ExtractedDiariesView(extractedDiaryList: .constant(UserData.test().diaries))
			.environmentObject(userData)
			.environmentObject(selectedItem)
    }
}
