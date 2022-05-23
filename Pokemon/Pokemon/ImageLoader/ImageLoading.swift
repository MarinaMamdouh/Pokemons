//
//  ImageLoading.swift
//  CataPoke
//
//  Created by Marina on 11/05/2022.
//

import Foundation
import SwiftUI

protocol ImageLoading{
    associatedtype T
    func loadImage(with key:T) async throws-> UIImage
}
