//
//  EmployeeDirectoryApp.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import SwiftUI

@main
struct EmployeeDirectoryApp: App {
    @StateObject var employeeProvider = EmployeesProvider()
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                EmployeeListView()
                    .environmentObject(employeeProvider)
            })
        }
    }
}
