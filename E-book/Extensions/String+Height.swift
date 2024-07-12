//
//  String+Height.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 04.07.24.
//

import Foundation
import UIKit

extension String {
    public func height(width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font: font]
        let boundingRect = NSString(string: self).boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        
        return ceil(boundingRect.height)
    }
}
