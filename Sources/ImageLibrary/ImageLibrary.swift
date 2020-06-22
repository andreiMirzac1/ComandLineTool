//
//  Files.swift
//
//  Created by Andrei Mirzac on 19/06/2020.
//

import Foundation
import CoreGraphics

public class ImageLibrary {

    private var cgImage: CGImage
    private var cgMask: CGImage
    private var algInputs: AlgorithmInputs

    public init(cgImage: CGImage, mask: CGImage, algInputs: AlgorithmInputs) {
        self.cgImage = cgImage
        self.cgMask = mask
        self.algInputs = algInputs
    }

    public func mergedMaskImage() throws -> CGImage {
        return try mergeMaskIntoImage().cgImage
    }

    public func generateImage() throws -> CGImage {
        let imageData = try mergeMaskIntoImage()
        let bitmap = try applyHoleFilling(imageData: imageData)
        return try makeCGImage(bitMap: bitmap)
    }

    private func mergeMaskIntoImage() throws -> ImageData {
        let imageData = try makeGrayScaleImageData(from: cgImage)
        let cgMaskData = try makeGrayScaleImageData(from: cgMask)
        return try applyMasking(image: imageData.cgImage, mask: cgMaskData.cgImage)
    }

    private func applyHoleFilling(imageData: ImageData) throws -> Bitmap {
        let cgImage = imageData.cgImage
        let bitMap = BitmapConvertor.convertToHoleFillingBitmap(array: imageData.array, width: cgImage.width, height: cgImage.height)
        let alg = HoleFillingAlgorithm(bitmap: bitMap, algInputs: algInputs)
        return try alg.fillHole()
    }

    private func applyMasking(image: CGImage, mask: CGImage) throws -> ImageData {
        guard let mask = mask.makeImageMask(),
            let result = image.masking(mask) else {
                throw ImageLibraryError.failedToApplyMask
        }
        return try makeGrayScaleImageData(from: result)
    }

    private func makeGrayScaleImageData(from image: CGImage) throws -> ImageData {
        let width = image.width
        let height = image.height
        let imageRect: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let totalBytes = height * MemoryLayout<UInt8>.size * width
        var buffer = [UInt8](repeating: 0, count: totalBytes)

        let context = CGContext(data: &buffer, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: width, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image, in: imageRect)
        guard let resultImage = context?.makeImage() else {
            throw ImageLibraryError.failedToGrayScaleImage
        }
        return ImageData(cgImage: resultImage, array: Array(buffer))
    }

    private func makeCGImage(bitMap: Bitmap) throws -> CGImage {
        let usignedArray = BitmapConvertor.convertBitmapToUInt8(bitmap: bitMap)
        let width = bitMap.width
        let height = bitMap.height

        let bitsPerPixel = 8
        let totalBytes = width * height
        let bytesPerRow = width
        let bitsPerComponent = 8
        let spaceColor = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        let bytes = usignedArray
        guard let dataProvider = CGDataProvider(data: Data(bytes: bytes, count: totalBytes) as CFData) else {
            throw ImageLibraryError.failedDataProvider
        }

        guard let image = CGImage(width: width,
                              height: height,
                              bitsPerComponent: bitsPerComponent,
                              bitsPerPixel: bitsPerPixel,
                              bytesPerRow: bytesPerRow,
                              space: spaceColor,
                              bitmapInfo: bitmapInfo,
                              provider: dataProvider,
                              decode: nil,
                              shouldInterpolate: false,
                              intent: .defaultIntent) else {
            throw ImageLibraryError.failedToConvertBitMapValueToImage
        }
        return image
    }
}

extension ImageLibrary {
    enum ImageLibraryError: Error {
        case failedToGrayScaleImage
        case failedToApplyMask
        case failedToConvertBitMapValueToImage
        case failedDataProvider
    }
}
