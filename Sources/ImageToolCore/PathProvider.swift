//
//  PathProvider.swift
//  ImageToolCore
//
//  Created by Andrei Mirzac on 20/06/2020.
//

import Foundation

struct PathProvider {
    enum PathProviderError: Error {
        case couldNotCreateDestinationPath
    }

    private var fileManager: FileManager
    private var currentDirectory: URL? {
        return URL(fileURLWithPath: fileManager.currentDirectoryPath, isDirectory: true)
    }

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    func destionationPath(fileName: String) throws -> URL {
        guard let url = currentDirectory?.appendingPathComponent(fileName) else {
            throw PathProviderError.couldNotCreateDestinationPath
        }
        return url
    }
}





