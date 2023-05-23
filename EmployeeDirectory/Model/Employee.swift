//
//  Employee.swift
//  EmployeeDirectory
//
//  Created by Frank Su on 2023-01-12.
//

import Foundation
import SwiftUI

struct RootEmployee: Decodable {
    let employees: [Employee]
}

struct Employee {
    let uuid: UUID
    let fullName: String
    let phone: String? //TODO: phone number (123) 000-1234 formatting?
    let email: String
    let biography: String?
    let photoUrlSmall: URL?
    let photoUrlLarge: URL?
    let team: String
    let type: EmployeeType
    
    var image: Image?
}

enum EmployeeType: String, Decodable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}

extension Employee: Decodable {
    
    enum EmployeeCodingKey: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case email = "email_address"
        case biography
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team
        case type = "employee_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EmployeeCodingKey.self)
        let rawUuid = try? container.decode(String.self, forKey: .uuid)
        let rawFullName = try? container.decode(String.self, forKey: .fullName)
        let rawPhoneNumber = try? container.decode(String.self, forKey: .phoneNumber)
        let rawEmail = try? container.decode(String.self, forKey: .email)
        let rawBiography = try? container.decode(String.self, forKey: .biography)
        let rawPhotoUrlSmall = try? container.decode(String.self, forKey: .photoUrlSmall)
        let rawPhotoUrlLarge = try? container.decode(String.self, forKey: .photoUrlLarge)
        let rawTeam = try? container.decode(String.self, forKey: .team)
        let rawType = try? container.decode(EmployeeType.self, forKey: .type)
        
        guard let uuid = UUID(uuidString: rawUuid ?? ""),
              let fullName = rawFullName,
              let email = rawEmail,
              let team = rawTeam,
              let type = rawType
        else {
            throw EmployeeError.malformedData
        }
        
        self.uuid = uuid
        self.fullName = fullName
        self.phone = rawPhoneNumber
        self.email = email
        self.biography = rawBiography
        self.photoUrlSmall = URL(string: rawPhotoUrlSmall ?? "")
        self.photoUrlLarge = URL(string: rawPhotoUrlLarge ?? "")
        self.team = team
        self.type = type
        
        self.image = nil
    }
    
    
}
