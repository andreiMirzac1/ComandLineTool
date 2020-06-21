//
//  HoleFillingAlgorithmTests.swift
//
//  Created by Andrei Mirzac on 19/06/2020.
//

import Foundation
import XCTest
@testable import ImageLibrary

class HoleFillingAlgorithmTests: XCTestCase {

    let threshold: Float = 0.001
    let valuesFour: [Float] = [0.6, 0.7, -1,
                               0.6, -1, 0.8,
                               -1, -1, 0.99,
                               0.2, 0.3, 0.5]

    let valuesFourResult: [Float] = [0.6, 0.7, 0.63,
                                     0.6, 0.619, 0.8,
                                     0.575, 0.598, 0.99,
                                     0.2, 0.3, 0.5]

    let valuesEight: [Float] = [-1, 0.7, 0.4, -1,
                                0.6, -1,  -1, 0.4,
                                0.3, -1,  -1, 0.5,
                                0.2, 0.3, 0.5, 0.6,
                                 -1,  0.3, 0.5, -1]

    let valuesEightResult: [Float] = [0.45325893, 0.7, 0.4, 0.44763857,
                                      0.6, 0.44825363, 0.4472144, 0.4,
                                      0.3, 0.43526173, 0.44367325, 0.5,
                                      0.2, 0.3, 0.5, 0.6,
                                      0.4221711, 0.3, 0.5, 0.44536904]

    func testHoleFillingWithConnectivityFour() throws {
        let inputs = AlgorithmInputs(eps: 1, z: 0.3, connectivity: .four)
        let bitmap = Bitmap(width: 3, height: 4, values: valuesFour)
        let alg = HoleFillingAlgorithm(bitmap: bitmap, algInputs: inputs)
        let resultBitMap = try alg.fillHole()
        assert(array1: resultBitMap.pixels, array2: valuesFourResult)
        print(resultBitMap.pixels)
        print(valuesFourResult)
    }

    func testHoleFillingWithConnectivityEight() throws {
        let inputs = AlgorithmInputs(eps: 1, z: 0.3, connectivity: .eight)
        let bitmap = Bitmap(width: 4, height: 5, values: valuesEight)
        let alg = HoleFillingAlgorithm(bitmap: bitmap, algInputs: inputs)
        let resultBitMap = try alg.fillHole()
        assert(array1: resultBitMap.pixels, array2: valuesEightResult)
        print(resultBitMap.pixels)
    }
}

extension HoleFillingAlgorithmTests {
    func assert(array1: [Float], array2: [Float]) {
        for (val1,val2) in zip(array1, array2){
            let difference = val2 - val1
            XCTAssert(difference < threshold)
        }
    }
}
