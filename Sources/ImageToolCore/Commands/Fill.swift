//
//  Fill.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 19/06/2020.
//

import Foundation
import ArgumentParser
import ImageLibrary

struct Fill: ParsableCommand {

    enum FillErrors: Error {
        case invalidInputConectivity
    }

    public static let configuration = CommandConfiguration(abstract: "Generate a grayscale image with filled holes from a given input")

    @Argument(help: "The input Image")
    private var orgImageName: String

    @Argument(help: "The mask that defines the hole in origin input image")
    private var holeMask: String

    @Argument(help: "This argument represents pixel conectivity. Valid values are 4 or 8")
    private var conectivity: Int

    @Argument(help: "Epsilon constant")
    private var epsConstant: Float

    @Argument(help: "Z constant")
    private var zConstant: Float

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool

    func run() throws {
        let cgImage = try CGImageHandler().loadImage(withName: orgImageName)
        let cgHoleMask = try CGImageHandler().loadImage(withName: holeMask)

        let imageLib = ImageLibrary(cgImage: cgImage, mask: cgHoleMask, algInputs: try makeAlgorithmInputs())
        let result = try imageLib.generateImage()
        try CGImageHandler().saveImage(result, name: "result.png")
        print("Find the new generated image in the same directory, named \"result.png\"")
    }

    func makeAlgorithmInputs() throws -> AlgorithmInputs {
        guard let pixelConnectivity = PixelConnectivity(rawValue: conectivity) else {
            throw FillErrors.invalidInputConectivity
        }
        return AlgorithmInputs(eps: epsConstant, z: zConstant, connectivity: pixelConnectivity)
    }
}
