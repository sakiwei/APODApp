//
//  SortUtils.swift
//  APOD
//
//  Created by Sakiwei on 21/1/2022.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { lhs, rhs in
            return lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }

    func sortedDesc<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { lhs, rhs in
            return lhs[keyPath: keyPath] > rhs[keyPath: keyPath]
        }
    }
}
