//
//  CalendarView.swift
//  Diary5
//  
//  Created by e.hasegawa on 2022/11/19.
//  

import SwiftUI

struct CalendarView: UIViewRepresentable {
    @EnvironmentObject var userData: UserData
    @Binding var dateComponent: DateComponents
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        calendarView.delegate = context.coordinator
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "ja_JP")
        
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        selection.selectedDate = dateComponent
        calendarView.selectionBehavior = selection
        
        return calendarView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        uiView.reloadDecorations(forDateComponents: [dateComponent], animated: true)
        
        if let changedDiary = userData.changedDiary {
            let component = Calendar.current.dateComponents(in: TimeZone.current, from: changedDiary.date)
            uiView.reloadDecorations(forDateComponents: [component], animated: true)
        }
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
		let parent: CalendarView
        
		init(parent: CalendarView) {
			self.parent = parent
		}
        
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
			let foundDiaries = parent.userData.diaries.filter { diary in
                    Calendar.current.startOfDay(for: diary.date) == Calendar.current.startOfDay(for: dateComponents.date!)
                }
            
            switch foundDiaries.count {
            case let n where n > 1:
                return .image(UIImage(systemName: "square.fill.on.square.fill"))
            case 1:
                return .image(UIImage(systemName: foundDiaries.first!.decoration.icon))
            default:
                return nil
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let components = dateComponents else { return }
			parent.dateComponent = components
        }
    }
}
