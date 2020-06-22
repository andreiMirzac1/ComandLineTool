//
//  Convertor.swift
//  ImageLibrary
//
//  Created by Andrei Mirzac on 21/06/2020.
//

import Foundation

class HoleFillingAlgorithm {
    enum HoleFillingAlgorithmErrors: Error {
        case invalidBitMapValues
    }
    private var bitmap: Bitmap
    private var algInputs: AlgorithmInputs

    init(bitmap: Bitmap, algInputs: AlgorithmInputs) {
        self.bitmap = bitmap
        self.algInputs = algInputs
    }

    func fillHole() throws -> Bitmap {
        try validateBitMapValues()
        let boundaryPoints = findHoleBoundary(connectivity: algInputs.connectivity)
        let holePoints = findHolePoints()
        var resultBitMap = bitmap
        for point in holePoints {
            resultBitMap[point.x, point.y] = calculateValue(for: point, boundary: boundaryPoints)
        }
        return resultBitMap
    }

    private func calculateValue(for point: Point, boundary: Set<Point>) -> Float {
        var res: Float = 0
        var sumWeights: Float = 0

        for bPoint in boundary {
            let bPointWeight = weight(point1: bPoint, point2: point)
            res += bPointWeight * bPoint.value
            sumWeights += bPointWeight
        }
        return res/sumWeights
    }

    private func weight(point1: Point, point2: Point) -> Float {
        return 1 / (algInputs.eps + pow((pow(Float(point1.x) - Float(point2.x), 2) + pow(Float(point1.y) - Float(point2.y), 2)), algInputs.z))
    }

    private func validateBitMapValues() throws {
        for j in 0..<bitmap.height {
            for i in 0..<bitmap.width {
                let value = bitmap[j,i]
                if value > 1 && value < -1 {
                    throw HoleFillingAlgorithmErrors.invalidBitMapValues
                }
            }
        }
    }

    // Set of points that are not holes but at least one neighbour has hole value
    private func findHoleBoundary(connectivity: PixelConnectivity) -> Set<Point> {
        var boundary = Set<Point>()
        for x in 0..<bitmap.width {
            for y in 0..<bitmap.height {
                if isBoundary(x: x, y: y, connectivity: connectivity) {
                    boundary.insert(Point(x: x, y: y, value: bitmap[x, y]))
                }
            }
        }
        return boundary
    }

    private func findHolePoints() -> Set<Point> {
        var holes = Set<Point>()
        for x in 0..<bitmap.width {
            for y in 0..<bitmap.height {
                if bitmap.isHole(x: x, y: y) {
                    holes.insert(Point(x: x, y: y, value: bitmap[x, y]))
                }
            }
        }
        return holes
    }

    private func isBoundary(x: Int, y: Int, connectivity: PixelConnectivity) -> Bool {
        guard !bitmap.isHole(x: x, y: y) else {
            return false
        }

        let hasBoundaryFour = bitmap.isHole(x: x - 1, y: y) ||
            bitmap.isHole(x: x + 1, y: y) ||
            bitmap.isHole(x: x, y: y + 1) ||
            bitmap.isHole(x: x, y: y - 1)

        switch connectivity {
        case .four:
            return hasBoundaryFour
        case .eight:
            return hasBoundaryFour ||
                bitmap.isHole(x: x - 1, y: y - 1) ||
                bitmap.isHole(x: x - 1, y: y + 1) ||
                bitmap.isHole(x: x + 1, y: y + 1) ||
                bitmap.isHole(x: x + 1, y: y - 1)
        }
    }
}
