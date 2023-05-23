//
//  APILoader.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import Foundation

class APILoader {
    
    func loadData(url: URL) async throws -> Data {
        do {
            guard let (data, response) = try await URLSession.shared.data(from: url) as? (Data, HTTPURLResponse), (200...299).contains(response.statusCode) else {
                throw EmployeeError.networkError
            }
            return data
        } catch {
            throw EmployeeError.networkError
        }
    }
}
