//
//  ImageCaching.swift
//  CataPoke
//
//  Created by Marina on 09/05/2022.
//

import Foundation
import UIKit

class ImageCaching: Caching{
    typealias T = UIImage
    
    static let reference = ImageCaching()
    private let imageCache = NSCache<AnyObject, T>()
    
    func check(key: AnyObject)->UIImage?{
        // check if it is in caching
        if let imageFromCache = imageCache.object(forKey: key){
            return imageFromCache
        }
        return nil
    }
    
    func save(item:UIImage, withKey key:AnyObject){
        imageCache.setObject(item, forKey: key)
    }
    
    
}





