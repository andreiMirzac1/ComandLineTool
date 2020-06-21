//
//  FilesTests.swift
//  Created by Andrei Mirzac on 19/06/2020.
//

import Foundation
import XCTest
@testable import ImageToolCore

class DataProviderTests: XCTestCase {

    let dataProvider = DataProvider()
    let pathProvider = PathProvider()
    let fileName = "testFileName"

    func testLoadFile() throws {
        //When
        let data = "Test Data".data(using: .utf8)!
        let path = try pathProvider.destionationPath(fileName: fileName)
        try dataProvider.save(data: data, url: path)

        //Then
        let savedData = try dataProvider.readFrom(urlPath: path)
        XCTAssertEqual(savedData, data)
    }
}
