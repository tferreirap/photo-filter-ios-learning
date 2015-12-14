import UIKit

public class BlueFilter: FilterProtocol {
    
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
        let avgBlue = avgCalc.avgBlue
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                let blueDelta = Int(pixel.blue) - avgBlue
                
                var filterModifier = self.modifier
                if ( Int(pixel.blue) < avgBlue) {
                    filterModifier = 1
                }
                pixel.blue = UInt8(max(min(255, avgBlue + filterModifier * blueDelta),0))
                rgbaImage.pixels[index] = pixel
            }
        }
        return rgbaImage.toUIImage()!

    }
}