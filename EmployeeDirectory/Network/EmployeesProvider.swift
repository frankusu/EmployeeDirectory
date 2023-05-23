//
//  EmployeeProvider.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import Foundation

/*
Use @MainActor to solve async publishing updates on background thread
Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
 */
@MainActor
class EmployeesProvider: ObservableObject {
    
    @Published var employees: [Employee] = []
    private let employeesClient = EmployeesClient()
    
    //TODO: refactor this
    func fetchEmployees() async throws {
        let updatedEmployees = try await employeesClient.loadEmployees()
        self.employees = updatedEmployees.sorted(by: { $0.fullName < $1.fullName })
    }
    
    func fetchMalformedEmployees() async throws {
        let updatedEmployees = try await employeesClient.loadMalformedEmployees()
        self.employees = updatedEmployees.sorted(by: { $0.fullName < $1.fullName })
    }
    
    func fetchEmptyEmployees() async throws {
        let updatedEmployees = try await employeesClient.loadEmptyEmployees()
        self.employees = updatedEmployees.sorted(by: { $0.fullName < $1.fullName })
    }
}
