//
//  EmployeeDirectoryTests.swift
//  EmployeeDirectoryTests
//
//  Created by Frank Su on 2023-01-12.
//

import XCTest
import UIKit
@testable import EmployeeDirectory

final class EmployeeDirectoryTests: XCTestCase {
    
    func testEmployeeModelDecoder() throws {
        
        let employeeDirectory = try JSONDecoder().decode(RootEmployee.self, from: employeesTestJson)
        
        XCTAssertEqual(employeeDirectory.employees.count, 11)
        XCTAssertEqual(employeeDirectory.employees[0].fullName, "Justine Mason")
        XCTAssertEqual(employeeDirectory.employees[0].biography, "Engineer on the Point of Sale team.")
        XCTAssertEqual(employeeDirectory.employees[0].type, .fullTime)
    }
    
    func testEmployeeModelDecoderMalformedData() throws {
        
        XCTAssertThrowsError(try JSONDecoder().decode(RootEmployee.self, from: employeesTestMalformed)) { error in
            XCTAssertEqual(error as! EmployeeError, EmployeeError.malformedData)
        }
        
    }
    
    func testEmployeeModelDecoderEmptyData() throws {
        let employeeDirectory = try JSONDecoder().decode(RootEmployee.self, from: employeesTestEmpty)
        
        XCTAssertEqual(employeeDirectory.employees.count, 0)
    }
    
    func testImageCache() {
        let image = UIImage(systemName: "person.fill")
        let cache = ImageCache()
        let url = URL(string:"www.frankiscool.com")!
        XCTAssertEqual(cache[url], nil)
        cache[url] = image
        XCTAssertNotNil(cache[url])
        
        
    }
}
