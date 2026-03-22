//
//  Priority.swift
//  task-hop
//
//  Created by Raka Febrian Syahputra on 22/03/26.
//

enum Priority: String, CaseIterable, Identifiable {
    case doFirst, schedule, delegate, eliminate
    
    var id: String { rawValue }
    
    var name: String {
        switch self {
        case .doFirst: return "Do First"
        case .schedule: return "Schedule"
        case .delegate: return "Delegate"
        case .eliminate: return "Eliminate"
        }
    }
}
