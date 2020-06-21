//
//  Bitmap.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 21/06/2020.
//

import Foundation

struct Bitmap: CustomStringConvertible, Hashable {
    private let holeValue: Float = -1
    var pixels: [Float]
    let width: Int
    let height: Int

    var count: Int {
        return height * width
    }

    init(width: Int, height: Int, value: Float) {
        self.width = width
        self.height = height
        pixels = Array(repeating: value, count: width * height)
    }

    init(width: Int, height: Int, values: [Float]) {
        self.width = width
        self.height = height
        self.pixels = values
    }

    subscript(x: Int, y: Int) -> Float {
        get { pixels[y * width + x] }
        set { pixels[y * width + x] = newValue }
    }

    var description: String {
        var matrix = "Width: \(width) Height: \(height)\n"
        for x in 0..<width {
            for y in 0..<height {
                matrix.append(contentsOf: "\(self[y,x]) ")
            }
            matrix.append(contentsOf: "\n")
        }
        return matrix
    }
}

extension Bitmap {
    func isHole(x: Int, y: Int) -> Bool {
        guard hasValidIndex(x: x, y: y) else {
            return false
        }

        return self[x, y] == holeValue
    }

    func hasValidIndex(x: Int, y: Int) -> Bool {
        return x < width &&
            y < height &&
            y >= 0 &&
            x >= 0
    }
}
