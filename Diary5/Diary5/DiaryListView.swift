//
//  DiaryListView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DiaryListView: View {
    @EnvironmentObject var userData: UserData
    @StateObject var selectedItem: SelectedItem = SelectedItem()
    
    @State private var allDiaries: [DiaryItem] = []
    @State private var dateComponent: DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    @State private var showingAddDiaryView = false
    @State private var showingFilterDiariesView = false
    @State private var searchText = ""
    @State private var searchResults: [DiaryItem] = []
    @State private var extractedDiaryList: [DiaryItem] = []
    @State private var showingExtractedDiariesView = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !showingExtractedDiariesView {
                    if userData.diaries.isEmpty {
                        Text("登録された日記はありません。")
                            .foregroundColor(.gray)
                    } else if searchText.isEmpty {
                        VStack {
                            DiaryListFormView(diaries: $allDiaries)
                            
                            Text("全\(userData.diaries.count)件")
                                .foregroundColor(.gray)
                        }
                    } else {
                        VStack {
                            DiaryListFormView(diaries: $searchResults)
                            
                            Text("\(searchResults.count)件")
                                .foregroundColor(.gray)
                        }
                    }
                } else {
                    selectedItem.showSelectedItem()
                    
                    if searchText.isEmpty {
                        VStack {
                            ExtractedDiariesView(extractedDiaryList: $extractedDiaryList)
                        }
                    } else {
                        VStack {
                            DiaryListFormView(diaries: $searchResults)
                            
                            Text("\(searchResults.count)件")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddDiaryView = true
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                    .sheet(isPresented: $showingAddDiaryView) {
                        AddDiaryView(dateComponent: $dateComponent)
							.environmentObject(userData)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    if !showingExtractedDiariesView {
                        Button(action: {
                            showingFilterDiariesView = true
                        }) {
                            Text("絞り込む")
                        }
                        .disabled(userData.diaries.isEmpty)
                        .sheet(isPresented: $showingFilterDiariesView) {
                            FilterDiariesView(showingExtractedDiariesView: $showingExtractedDiariesView, extractedDiaryList: $extractedDiaryList)
                                .presentationDetents([.medium, .large])
								.environmentObject(userData)
								.environmentObject(selectedItem)
                        }
                    } else {
                        Button(action: {
                            showingExtractedDiariesView = false
                            clearSelectedItem()
                        }) {
                            Text("条件をクリア")
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "テキストの内容で検索")
        .onAppear {
            sortDiaries()
        }
        .onChange(of: userData.diaries) {_ in
            sortDiaries()
            searchForDiaries()
            extractDiaries()
        }
        .onChange(of: searchText) {_ in
            searchForDiaries()
        }
        .onChange(of: extractedDiaryList) {_ in
            searchForDiaries()
            extractDiaries()
        }
    }
    
    func clearSelectedItem() {
        selectedItem.selectedYear = nil
        selectedItem.selectedMonth = nil
        selectedItem.selectedDecoration = nil
    }
    
    func sortDiaries() {
        allDiaries = userData.diaries
        allDiaries.sort(by: { (a, b) -> Bool in
            return a.date < b.date
        })
    }
    
    func searchForDiaries() {
        if !showingExtractedDiariesView {
            searchResults = allDiaries.filter { diary in
                diary.text1.contains(searchText) || diary.text2.contains(searchText)
            }
        } else {
            searchResults = extractedDiaryList.filter { diary in
                diary.text1.contains(searchText) || diary.text2.contains(searchText)
            }
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

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView()
            .environmentObject(UserData.test())
    }
}
