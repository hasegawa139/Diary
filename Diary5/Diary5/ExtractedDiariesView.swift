//
//  ExtractedDiariesView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct ExtractedDiariesView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userData: UserData
    @ObservedObject var selectedItem: SelectedItem
    
    @Binding var extractedDiaryList: [DiaryItem]
    
    var body: some View {
        NavigationView {
            VStack {
                DiaryListFormView(userData: userData, diaries: $extractedDiaryList)
                
                Text("\(extractedDiaryList.count)件")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ExtractedDiariesView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractedDiariesView(userData: UserData.test(), selectedItem: SelectedItem(), extractedDiaryList: .constant(UserData.test().diaries))
    }
}
