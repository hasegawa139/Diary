//
//  DisplayStyleTabView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct DisplayStyleTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("カレンダー", systemImage: "calendar")
                }
            
            DiaryListView()
                .tabItem {
                    Label("日記", systemImage: "text.book.closed")
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white.withAlphaComponent(0.9)
        }
    }
}

struct DisplayStyleTabView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayStyleTabView()
            .environmentObject(UserData.test())
    }
}
