//
//  ImageFetcher.swift
//  CataPoke
//
//  Created by Marina on 05/05/2022.
//

import Foundation
import SwiftUI

class ImageHandler{
    
    func request(route: APIRoute) async throws -> UIImage {
        // check if it is in caching
        let request = route.asRequest()
        if let imageFromCache = ImageCaching.reference.check(key: request as AnyObject){
            
            return imageFromCache
        }
        let session = URLSession.shared
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let data = data,
                        error == nil,
                        let image = UIImage(data: data)
                    else {
                        continuation.resume(with: .failure(RequestError.NoData))
                        return
                        
                    }
                    // Cache the image
                    ImageCaching.reference.save(item: image, withKey: route.asURL() as AnyObject)
                    continuation.resume(with: .success(image))
                }
            })
            
            task.resume()
        }
    }
}
