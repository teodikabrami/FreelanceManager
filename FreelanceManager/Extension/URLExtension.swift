//
//  URLExtension.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

extension URL {
    
    static func soundName() -> URL {
        return Bundle.main.url(forResource: "Aladdin", withExtension: "mp3")!
    }
    
}
