import UIKit

public protocol FilterProtocol {
    func applyFilter() -> UIImage
    func applyFilterWithImage(image: UIImage) -> UIImage
}

