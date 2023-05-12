//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 07/05/23.
//

import Foundation
import SwiftUI

public enum ResponseStatus {
    case success
    case error
    
    public var title: String {
        switch self {
        case .error:
            return "Error"
        case .success:
            return "Success"
        }
    }
    public var message: String {
        switch self {
        case .error:
            return "Try again later"
        case .success:
            return "Success"
        }
    }
}
