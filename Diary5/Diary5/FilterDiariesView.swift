//
//  FilterDiariesView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct FilterDiariesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var selectedItem: SelectedItem
    
    @Binding var showingExtractedDiariesView: Bool
    @Binding var extractedDiaryList: [DiaryItem]
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationView {
                    Form {
                        NavigationLink {
                            YearPickerView(selectedItem: selectedItem, extractedDiaryList: $extractedDiaryList)
                        } label: {
                            HStack {
                                Text("年")
                                Spacer()
                                Text(selectedItem.selectedYear ?? "選択しない")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        NavigationLink {
                            MonthPickerView(selectedItem: selectedItem, extractedDiaryList: $extractedDiaryList)
                        } label: {
                            HStack {
                                Text("月")
                                Spacer()
                                Text(selectedItem.selectedMonth ?? "選択しない")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        NavigationLink {
                            DecorationPickerView(selectedItem: selectedItem, extractedDiaryList: $extractedDiaryList)
                        } label: {
                            HStack {
                                Text("アイコン")
                                Spacer()
                                Group {
                                    if let decoration = selectedItem.selectedDecoration?.icon {                                Image(systemName: decoration)
                                    } else {
                                        Text("選択しない")
                                    }
                                }
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Button(action: {
                    dismiss()
                    showingExtractedDiariesView = true
                }) {
                    Text("絞り込む")
                }
                .disabled(selectedItem.selectedYear == nil && selectedItem.selectedMonth == nil && selectedItem.selectedDecoration == nil)
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
        .onAppear {
            extractDiaries()
        }
        .onChange(of: selectedItem.selectedYear) {_ in
            extractDiaries()
        }
        .onChange(of: selectedItem.selectedMonth) {_ in
            extractDiaries()
        }
        .onChange(of: selectedItem.selectedDecoration) {_ in
            extractDiaries()
        }
        .onChange(of: userData.diaries) {_ in
            extractDiaries()
        }
    }
    
    func extractDiaries() {
        extractedDiaryList = userData.diaries
        if selectedItem.selectedYear != nil {
            extractedDiaryList = extractedDiaryList.filter({ diary in
                diary.date.formatDateForYear() == selectedItem.selectedYear
            })
        }
        if selectedItem.selectedMonth != nil {
            extractedDiaryList = extractedDiaryList.filter({ diary in
                diary.date.formatDateForMonth() == selectedItem.selectedMonth
            })
        }
        if selectedItem.selectedDecoration != nil {
            extractedDiaryList = extractedDiaryList.filter({ diary in
                diary.decoration == selectedItem.selectedDecoration
            })
        }
        
        extractedDiaryList.sort(by: { (a, b) -> Bool in
            return a.date < b.date
        })
    }
}

struct FilterDiariesView_Previews: PreviewProvider {
    static var previews: some View {
		let userData = UserData.test()
		let selectedItem = SelectedItem()
        FilterDiariesView(showingExtractedDiariesView: .constant(false), extractedDiaryList: .constant(UserData.test().diaries))
			.environmentObject(userData)
			.environmentObject(selectedItem)
    }
}
