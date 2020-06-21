//
//  CGImageExtensions.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 21/06/2020.
//

import CoreGraphics

extension CGImage {
    func makeImageMask() -> CGImage? {
        return CGImage(maskWidth: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerPixel, bytesPerRow: bytesPerRow, provider: dataProvider!, decode: nil, shouldInterpolate: false)
    }
}
