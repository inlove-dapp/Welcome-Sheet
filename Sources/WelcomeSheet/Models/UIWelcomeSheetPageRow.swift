//
//  UIWelcomeSheetPageRow.swift
//
//
//  Created by Eskil Gjerde Sviggum on 18/01/2023.
//

import SwiftUI
import UIKit

@objc
public class UIWelcomeSheetPageRow: NSObject {
    /// Title displayed above the content.
    @IBInspectable
    public var title: String = ""
    
    /// Text displayed beneath the title.
    @IBInspectable
    public var content: String = ""
    
    /// Image displayed at the beginning of a row.
    @IBInspectable
    public var image: UIImage = .init()
    
    /// Color used for image. When `nil`, uses default accent color.
    @IBInspectable
    public var accentColor: UIColor?
    
    func welcomeSheetPageRow() -> WelcomeSheetPageRow {
        WelcomeSheetPageRow(uiImage: image, accentUIColor: accentColor, title: LocalizedStringKey(title), content: LocalizedStringKey(content))
    }
}
