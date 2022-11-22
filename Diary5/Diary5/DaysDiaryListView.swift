//
//  DaysDiaryListView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DaysDiaryListView: View {
    @ObservedObject var userData: UserData
    @Binding var dateComponent: DateComponents
    
    @State private var foundDiaries: [DiaryItem]?
    @State private var selectedDiary: DiaryItem?
    
    var body: some View {
        VStack {
            if let diaries = foundDiaries {
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
        .onAppear {
            findDiaries(dateComponent: dateComponent)
        }
        .onChange(of: dateComponent) { component in
            findDiaries(dateComponent: component)
        }
        .onChange(of: userData.diaries) {_ in
            findDiaries(dateComponent: dateComponent)
        }
    }
    
    func findDiaries(dateComponent: DateComponents) {
        guard let date = dateComponent.date else { return }
        foundDiaries = userData.diaries.filter { diary in
            Calendar.current.startOfDay(for: diary.date) == Calendar.current.startOfDay(for: date)
        }
        foundDiaries?.sort(by: { (a, b) -> Bool in
            return a.date < b.date
        })
    }
}

struct DaysDiaryListView_Previews: PreviewProvider {
    static var dateComponent: DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    
    static var previews: some View {
        DaysDiaryListView(userData: UserData.test(), dateComponent: .constant(dateComponent))
    }
}
