//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Foundation
import UIKit
import CoreGraphics
import CoreText

public enum FontError: Swift.Error {
   case failedToRegisterFont
}


/// Extension for simplifying resizing fonts
extension UIFont {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(descriptor: self.fontDescriptor, size: fontSize)
    }
    
    public static func registerKanvasFonts() throws {
        guard let fontURL = Bundle.module.url(forResource: "GT-America-Standard-Regular", withExtension: "otf", subdirectory: "Fonts"), let fontDataProvider = CGDataProvider(url: fontURL as CFURL), let font = CGFont(fontDataProvider) else {
            throw FontError.failedToRegisterFont
        }

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        
        guard error == nil else {
            throw FontError.failedToRegisterFont
        }
    }
}
