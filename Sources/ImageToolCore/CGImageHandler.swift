//
//  ImagePersistentManager.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 20/06/2020.
//

import Foundation

protocol ImageStorageProtocol {
    func saveImage(_ image: CGImage, name: String) throws -> Bool
    func loadImage(withName name: String) throws -> CGImage
}

struct CGImageHandler: ImageStorageProtocol {

    enum CGImageHandler: Error {
        case failedToCreateAnImageDestination
        case failedToCreateAnCGImage
        case invalidImageExtension
    }
    
    let fileManager: DataProvider
    let pathProvider: PathProvider
    
    init(fileManager: DataProvider = DataProvider(), pathProvider: PathProvider = PathProvider()) {
        self.fileManager = fileManager
        self.pathProvider = pathProvider
    }

    @discardableResult func saveImage(_ image: CGImage, name: String) throws -> Bool {
        let url = try pathProvider.destionationPath(fileName: name)
        let imageFormat = try parseImageFormat(from: url)
        guard let destination = CGImageDestinationCreateWithURL(url as CFURL, imageFormat.kUTType, 1, nil) else {
            throw CGImageHandler.failedToCreateAnImageDestination
        }
        CGImageDestinationAddImage(destination, image, nil)
        return CGImageDestinationFinalize(destination)
    }

    func loadImage(withName name: String) throws -> CGImage {
        let url = try pathProvider.destionationPath(fileName: name)
        let imageFormat = try parseImageFormat(from: url)
        let imageData = try fileManager.readFrom(urlPath: url)
        return try createCGImage(from: imageData, imageFormat: imageFormat)
    }

    private func createCGImage(from data: Data, imageFormat: ImageFormat) throws -> CGImage {
        guard let dataProvider = CGDataProvider(data: data as CFData) else {
            throw CGImageHandler.failedToCreateAnCGImage
        }
        switch imageFormat {
        case .jpeg:
            guard let cgImage = CGImage(jpegDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent) else {
                throw CGImageHandler.failedToCreateAnCGImage
            }
            return cgImage
        case .png:
            guard let cgImage = CGImage(pngDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent) else {
                throw CGImageHandler.failedToCreateAnCGImage
            }
            return cgImage
        }
    }

    private func parseImageFormat(from url: URL) throws -> ImageFormat {
        guard let imageFormat = ImageFormat(rawValue: url.pathExtension) else {
            throw CGImageHandler.invalidImageExtension
        }
        return imageFormat
    }
}
