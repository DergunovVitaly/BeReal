//
//  Array+Extension.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

extension Array where Element: Identifiable {
    func uniqued() -> [Element] {
        var seen = Set<Element.ID>()
        return filter { seen.insert($0.id).inserted }
    }
}
