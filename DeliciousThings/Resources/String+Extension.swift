//
//  String+Extension.swift
//  DeliciousThings
//
//  Created by MacBook on 18.06.2022.
//

import Foundation

extension String {
    var asUrl:URL? {
        return URL(string: self)
    }
}
