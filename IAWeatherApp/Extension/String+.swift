//
//  String+.swift
//  IAWeatherApp
//
//  Created by Vu Dang on 5/19/21.
//

import Foundation

extension String {
    func isNumberOnly() -> Bool {
        if Int(self) != nil {
            return true
        } else {
            return false
        }
    }
}
