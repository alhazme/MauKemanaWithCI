//
//  ResultExtension.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation
import RealmSwift

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
