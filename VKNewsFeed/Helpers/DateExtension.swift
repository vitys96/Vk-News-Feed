//  DateExtension.swift

import UIKit

extension Date {
    
    func timeSinceDate(fromDate: Date) -> String {
        let earliest = self < fromDate ? self : fromDate
        let latest = (earliest == self) ? fromDate : self
        
        let components: DateComponents = Calendar.current.dateComponents([.minute,.hour,.day,.weekOfYear,.month,.year,.second], from: earliest, to: latest)
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        if (week >= 2) {
            return "\(week) неделю назад"
            
        } else if (week >= 1){
            return "1 неделю назад"
            
        } else if (day >= 2) {
            return "\(day) дня назад"
            
        } else if (day >= 1 && hours > 24) {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "'вчера в' HH:mm"
            return dateFormat.string(from: earliest)
            
        } else if (hours >= 5){
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "'сегодня в' HH:mm"
            return dateFormat.string(from: earliest)
            
        } else if (hours >= 2) {
            return "\(hours) часа назад"
            
        } else if (hours >= 1){
            return "1 час назад"
            
        } else if (minutes >= 5) {
            return "\(minutes) минут назад"
            
        } else if (minutes > 2) {
            return "\(minutes) минуты назад"
            
        } else if (minutes >= 1){
            return "1 минуту назад"
            
        } else if (seconds >= 5) {
            return "\(seconds) секунд назад"
            
        } else if (seconds >= 2) {
            return "\(seconds) секунды назад"
            
        } else {
            return "Только что"
        }
    }
}

