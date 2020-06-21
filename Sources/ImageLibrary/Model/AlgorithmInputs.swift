//
//  AlgorithmInputs.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 21/06/2020.
//

import Foundation

public struct AlgorithmInputs {
    let eps: Float
    let z: Float
    let connectivity: PixelConnectivity

    public init(eps: Float, z: Float, connectivity: PixelConnectivity) {
        self.eps = eps
        self.z = z
        self.connectivity = connectivity
    }
}
