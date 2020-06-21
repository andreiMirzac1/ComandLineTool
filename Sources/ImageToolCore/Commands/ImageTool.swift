//
//  ImageTool.swift
//  FillHolesCommandLineTool
//
//  Created by Andrei Mirzac on 19/06/2020.
//

import ArgumentParser

public struct ImageTool: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to fill hole in a grayscale image",
        subcommands: [Fill.self])
    
    public init() { }
}
