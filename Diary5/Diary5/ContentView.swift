//
//  ContentView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    @State private var dateComponent: DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    @State private var showingAddDiaryView = false
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    CalendarView(userData: userData, dateComponent: $dateComponent)
                        .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddDiaryView = true
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .sheet(isPresented: $showingAddDiaryView) {
                            AddDiaryView(userData: userData, dateComponent: $dateComponent)
                        }
                    }
                }
            }
            
            DaysDiaryListView(userData: userData, dateComponent: $dateComponent)
                .frame(height: 180)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData.test())
    }
}
