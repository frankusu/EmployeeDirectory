//
//  EmployeeListView.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import SwiftUI

struct EmployeeListView: View {
    @EnvironmentObject var employeesProvider: EmployeesProvider
    @State var shouldShowAlert: Bool = false
    @State var fetchEmployeesErrorMessage = ""
    
    var body: some View {
        let employees = employeesProvider.employees
        List(employees, id: \.uuid) { employee in
            EmployeeCellView(employee: employee)
        }
        .listStyle(.inset)
        .alert("Fetch Employees Error", isPresented: $shouldShowAlert, actions: {
            Button("OK",role: .cancel, action: {})
        }, message: {
            Text("\(fetchEmployeesErrorMessage)")
        })
        .task {
            await loadList()
        }
        .refreshable {
            await loadList()
        }
        .navigationTitle("Employee Directory")
        .overlay(
            Group {
                if employees.isEmpty && fetchEmployeesErrorMessage == "" {
                    emptyView
                }
            }
        )
    }
    
    func loadList() async {
        do {
            try await employeesProvider.fetchEmployees()
//                try await employeesProvider.fetchMalformedEmployees()
//                try await employeesProvider.fetchEmptyEmployees()
        } catch {
            self.shouldShowAlert = true
            self.fetchEmployeesErrorMessage = (error as? EmployeeError)?.errorDescription ?? (EmployeeError.unexpectedError(error: error).errorDescription ?? "")
        }
    }
    @ViewBuilder
    var emptyView: some View {
        VStack {
            Spacer()
            Image("shrekMike")
                .resizable()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .shadow(color: Color.gray.opacity(0.5),
                        radius: 8,
                        x: 0,
                        y: 0
                )
            Text("No Employee Data to Show ")
            Spacer()
        }
    }
}
