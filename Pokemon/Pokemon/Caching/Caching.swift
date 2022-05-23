//
//  Caching.swift
//  CataPoke
//
//  Created by Marina on 10/05/2022.
//

import Foundation
protocol Caching{

    associatedtype T

    func check(key: AnyObject)->T?
    func save(item:T, withKey key:AnyObject)
}
