//
//  EmployeesClient.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import Foundation
import SwiftUI
import UIKit

// actor instead of class to prevent data races
actor EmployeesClient {
    
    private let employeeURL = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
    private let employeeURLMalformedData = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json")!
    private let employeeURLEmptyData = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json")!
    
    private let cache = ImageCache()
    private let api = APILoader()
    
    func loadEmployees() async throws -> [Employee] {
        try await load(url: employeeURL)
    }
    
    func loadMalformedEmployees() async throws -> [Employee] {
        try await load(url: employeeURLMalformedData)
    }
    
    func loadEmptyEmployees() async throws -> [Employee] {
        try await load(url: employeeURLEmptyData)
    }
    
    func load(url: URL) async throws -> [Employee] {

        let employeeData = try await api.loadData(url: url)
        let rootEmployee = try JSONDecoder().decode(RootEmployee.self, from: employeeData)
        var employees = rootEmployee.employees
        await withTaskGroup(of: (Int, Image).self) { group in
            for (index, employee) in employees.enumerated() {
                if let url = employee.photoUrlSmall {
                    group.addTask {
                        //TODO: Keep track of currently in progress network awaits. Increase efficiency even more by prreventing duplicate network calls
                        do {
                            let image = try await self.loadImage(url: url)
                            return (index, image)
                        } catch {
                            //TODO: handle error here
                            _ = error
                        }
                        return (index, Image(systemName: "person.fill"))
                    }
                }
            }
            while let result = await group.next() {
                employees[result.0].image = result.1
            }
        }
        return employees
    }
    
    func loadImage(url: URL) async throws -> Image {
        if let uiImage = cache[url] {
            return Image(uiImage: uiImage)
        } else {
            do {
                let imageData = try await api.loadData(url: url)
                let image = Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "person.fill")!)
                return image
            } catch {
                throw error
            }
        }
    }
}
