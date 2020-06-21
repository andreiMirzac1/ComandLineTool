//
//  ImageFormat.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 20/06/2020.
//

import Foundation

enum ImageFormat: String {
    case png
    case jpeg

    var kUTType: CFString {
        switch self {
        case .png:
            return kUTTypePNG
        case .jpeg:
            return kUTTypeJPEG
        }
    }
}
