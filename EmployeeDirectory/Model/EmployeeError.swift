//
//  EmployeeError.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import Foundation

enum EmployeeError: Error, Equatable {
    static func == (lhs: EmployeeError, rhs: EmployeeError) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
    
    case networkError
    case malformedData
    case unexpectedError(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "No internet connection or error fetching Employee data over the network."
        case .malformedData:
            return "Returned Employee data is missing crucial data."
        case .unexpectedError(let err):
            return "Unexpected error: \(err)"
        }
    }
}
