//
//  Date+Extension.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

import Foundation

extension Date {
    var monthBefore: Date {
        Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    var monthAfter: Date {
        Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
}
