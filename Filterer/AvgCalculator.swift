import UIKit

public struct AvgCalculator {
    
    var rgbaImage: RGBAImage
    var avgRed: Int = 0
    var avgGreen: Int = 0
    var avgBlue: Int = 0

    public init(rgbaImage: RGBAImage) {
        self.rgbaImage = rgbaImage
        calculateAvg()
    }
   
    // Find the average colors of the image
    mutating func calculateAvg() {
        
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                let pixel = rgbaImage.pixels[index]
        
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        let pixelCount = rgbaImage.width * rgbaImage.height;

        avgBlue = totalBlue / pixelCount
        avgRed = totalRed / pixelCount
        avgGreen = totalGreen / pixelCount
    }
    
    
    
    
    
}
