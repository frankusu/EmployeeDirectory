//
//  ImageCache.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import Foundation
import UIKit

class ImageCache: NSCache<NSString, UIImage> {
    
    subscript(url: URL) -> UIImage? {
        get {
            let key = url.absoluteString as NSString
            return object(forKey: key)
        }
        
        set {
            let key = url.absoluteString as NSString
            if let newValue = newValue {
                setObject(newValue, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
