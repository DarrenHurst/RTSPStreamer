//
//  Props.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-01-29.
//

import Foundation



@propertyWrapper
struct Trimmed {
    private var str: String = ""
    var wrappedValue: String {
        get { str }
        set { str = newValue.trimmingCharacters(in: .whitespacesAndNewlines)}
    }
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
