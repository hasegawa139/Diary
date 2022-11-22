//
//  AddDiaryView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct AddDiaryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userData: UserData
    @Binding var dateComponent: DateComponents
    
    @State private var decoration = DiaryItem.Decoration.circle
    @State private var date = Date()
    @State private var text1 = ""
    @State private var text2 = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    DiaryFormView(decoration: $decoration, date: $date, text1: $text1, text2: $text2, totalChars1: text1.count, totalChars2: text1.count)
                        .onAppear {
                            if let selectedDate = dateComponent.date {
                                date = selectedDate
                            }
                        }
                    
                    Button(action: {
                        appendDiary()
                        dismiss()
                    }) {
                        Text("登録")
                            .font(.title2)
                    }
                    .disabled(text1.isEmpty || text2.isEmpty)
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("キャンセル")
                        }
                    }
                }
            }
        }
    }
    
    func appendDiary() {
        userData.diaries.append(DiaryItem(decoration: decoration, date: date, text1: text1, text2: text2))
        userData.changedDiary = DiaryItem(decoration: decoration, date: date, text1: text1, text2: text2)
        print(userData.diaries)
    }
}

struct AddDiaryView_Previews: PreviewProvider {
    static var dateComponent: DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    
    static var previews: some View {
        AddDiaryView(userData: UserData.test(), dateComponent: .constant(dateComponent))
    }
}
