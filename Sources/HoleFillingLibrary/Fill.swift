//
//  Fill.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 19/06/2020.
//


import ArgumentParser

struct Fill: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generate a grayscale image with filled holes from given input")

    @Argument(help: "The imput Image")
    private var orgImageName: String

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool

    func run() throws {
    }
}
