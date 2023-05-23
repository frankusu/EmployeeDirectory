//
//  EmployeeCellView.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import SwiftUI

struct EmployeeCellView: View {
    private let imgSize = 150.0
    
    var employee: Employee
    var body: some View {
        HStack {
            employee.image!
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: imgSize, maxHeight: imgSize)
                .clipShape(Circle())
                .shadow(color: Color.gray.opacity(0.5),
                        radius: 8,
                        x: 0,
                        y: 0
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text("**Name:** \(employee.fullName)")
                Text("**Team:** \(employee.team)")
                Text("**Email:** \(employee.email)")
                    .lineLimit(1)
                if let bio = employee.biography {
                    Text("**Bio:** \(bio)")
                        .lineLimit(3)
                }
                
            }
            .font(.caption)
            .fontWeight(.light)
        }
    }
}

