//
//  Timestamp.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 07.10.25.
//

import Firebase

extension Timestamp {
    func timestampString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        if let str = formatter.string(from: self.dateValue(), to: Date()) {
                    return str
                } else {
                    let seconds = Date().timeIntervalSince(self.dateValue())
                    if seconds < 60 {
                        return "now"
                    } else {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .short
                        return dateFormatter.string(from: self.dateValue())
                    }
                }
    }
}
