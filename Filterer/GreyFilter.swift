import UIKit

public class GreyFilter: FilterProtocol  {
    
    var rgbaImage: RGBAImage
    var image: UIImage
    var modifier: Int
    var avgCalc: AvgCalculator
    
    public init(image: UIImage, modifier: Int) {
        if (modifier < 0) {
            self.modifier = 1
        } else {
            self.modifier = modifier
        }
        self.image = image
        self.rgbaImage = RGBAImage(image: image)!
        avgCalc = AvgCalculator(rgbaImage: rgbaImage)
    }
    
    public func applyFilter() -> UIImage {
        return applyFilterWithImage(self.image)
    }
    
    public func applyFilterWithImage(image: UIImage) -> UIImage {
        let rgbaImage = RGBAImage(image: image)!
        // Calculate Avg of the colors in the image here
        let avgRed = avgCalc.avgRed
        let avgGreen = avgCalc.avgGreen
        let avgBlue = avgCalc.avgBlue
        let sum = avgRed + avgGreen + avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                var filterModifier = self.modifier
                
                if ( (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue) ) < sum ) {
                    filterModifier = 2
                }
                
                let pixelSum = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue))
                let pixelAvg = pixelSum/3
                pixel.red = UInt8(max(min(255, pixelAvg / filterModifier),0))
                pixel.green = UInt8(max(min(255, pixelAvg / filterModifier),0))
                pixel.blue = UInt8(max(min(255, pixelAvg / filterModifier),0))
                
                rgbaImage.pixels[index] = pixel
            }
        }
        return rgbaImage.toUIImage()!
        
    }
}