//
//  NSObjectExtensions.swift
//  TabBar
//
//  Created by Mohamed Shaat on 6/28/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import Foundation

extension NSObject {
    class func fromClassName(className : String) -> AnyClass? {
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + className
        let aClass = NSClassFromString(className)
        return aClass
    }
}
