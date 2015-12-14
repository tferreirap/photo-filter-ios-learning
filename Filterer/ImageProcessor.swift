import UIKit

public class ImageProcessor {

    var image: UIImage
    var filtersDictionary = [Int: FilterProtocol]()

    public init(image: UIImage) {
        self.image = image
    }
    
    public func applyDefaultFilterWithName(filterName: String) -> UIImage? {
        var returnedImage: UIImage?
        
        switch filterName {
            case "Grey filter":
                returnedImage = GreyFilter(image: image, modifier: 1).applyFilter()
            case "35x Blue filter":
                returnedImage = BlueFilter(image: image, modifier: 35).applyFilter()
            case "Dark Grey filter":
                returnedImage = GreyFilter(image: image, modifier: 10).applyFilter()
            case "2x Blue filter":
                returnedImage = BlueFilter(image: image, modifier: 2).applyFilter()
            case "Heavy Contrast filter":
                returnedImage = ContrastFilter(image: image, modifier: 10).applyFilter()
            default:
                break
            
        }
        return returnedImage
    }
    
    // To apply the filters in order, we first add it to a dictionary
    // where its key will be the order that the filter should be applied
    // on a image. Secondly, we will sort the dictionary by its keys, then
    // apply the sorted filters.
    public func addFilterByOrder(filter: FilterProtocol, order: Int) {
        filtersDictionary[order] = filter
    }
    
    //
    public func applyOrderedFilters() -> UIImage{
        let sortedDict = filtersDictionary.sort { $0.0 < $1.0 }
        print ("-- Printing ordered dicionary, you can check the result in the console")
        print (sortedDict)
        
        var curImage = self.image
        for (_, filter) in sortedDict {
            curImage = filter.applyFilterWithImage(curImage);
        }
        return curImage
        
    }
    
    public func removeAllOrderedFilters() {
        self.filtersDictionary.removeAll()
    }
    
}