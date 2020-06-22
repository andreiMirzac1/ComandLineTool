//
//  BitmapConvertor.swift
//  ArgumentParser
//
//  Created by Andrei Mirzac on 21/06/2020.
//

import Foundation

struct BitmapConvertor {
    static func convertToHoleFillingBitmap(array: [UInt8], width: Int, height: Int) -> Bitmap {
        var bitmap: Bitmap = Bitmap(width: width, height: height, value: 0)
        for x in 0..<width {
            for y in 0..<height {
                let index = x * width + y
                let value = Float(array[index]) / Float(255)
                if value == 0 {
                    bitmap[x, y]  = -1
                } else {
                    bitmap[x, y]  = value
                }
            }
        }
        return bitmap
    }
    
    static func convertBitmapToUInt8(bitmap: Bitmap) -> [UInt8] {
        var array: [UInt8] = Array(repeating: 0, count: bitmap.count)
        for x in 0..<bitmap.width {
            for y in 0..<bitmap.height {
                let index = x * bitmap.width + y
                array[index] = UInt8(bitmap[x,y] * Float(255))
            }
        }
        return array
    }
}
