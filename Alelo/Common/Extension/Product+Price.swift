import UIKit

extension Product {
    
    func priceAttributed() -> NSAttributedString {
        let redAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                            NSAttributedString.Key.font: Fonts.normal]
        let greenAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen,
                               NSAttributedString.Key.font: Fonts.bigBold]
        let greenString = NSMutableAttributedString(string: actualPrice, attributes: greenAttributes)
        if regularPrice != actualPrice {
            let redString = NSAttributedString(string: regularPrice, attributes: redAttributes)
            greenString.append(redString)
        }
        return greenString
    }
}
