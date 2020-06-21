//
//  Files.swift
//
//  Created by Andrei Mirzac on 19/06/2020.
//

import Foundation

struct DataProvider {
    private var pathProvider: PathProvider

    init(pathProvider: PathProvider = PathProvider()) {
        self.pathProvider = pathProvider
    }

    func readFrom(urlPath: URL) throws -> Data  {
        return try Data(contentsOf: urlPath)
    }
    
    func save(data: Data, url: URL) throws {
        try data.write(to: url)
    }
}
