//
//  WelcomeSheetPage.swift
//
//
//  Created by Jakub Florek on 27/11/2021.
//

import SwiftUI

/// Describes Welcome Sheet page's content.
public struct WelcomeSheetPage: Identifiable, Decodable {
    private enum CodingKeys: String, CodingKey {
        case title, rows, mainButtonTitle, accentColor, backgroundColor, isShowingOptionalButton, optionalButtonTitle, optionalButtonURL
    }
    
    public var id = UUID()
    
    /// Large title displayed on the top.
    public var title: LocalizedStringKey
    /// Rows of content inside body.
    public var rows: [WelcomeSheetPageRow]
    
    /// Title for the main button. Set to `"Continue"` by default.
    public var mainButtonTitle: LocalizedStringKey
    /// Color used for main buttons. When `nil`, uses default accent color.
    public var accentColor: Color?
    /// Background color. When `nil`, uses default system background.
    public var backgroundColor: Color?
    
    /// Specifies whether to show the optional button.
    public var isShowingOptionalButton = false
    /// Optional button title.
    public var optionalButtonTitle: LocalizedStringKey?
    /// URL to open after optional button is tapped.
    public var optionalButtonURL: URL?
    /// Clousure executed after optional button is tapped.
    public var optionalButtonAction: (() -> ())?
    /// View shown after optional button is tapped.
    public var optionalButtonView: AnyView?
    
    private init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], accentColor: Color? = nil, backgroundColor: Color? = nil, mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonView: AnyView? = nil) {
        self.title = title
        self.rows = rows
        self.mainButtonTitle = mainButtonTitle ?? "Continue"
        self.accentColor = accentColor
        self.backgroundColor = backgroundColor
        isShowingOptionalButton = true
        self.optionalButtonTitle = optionalButtonTitle
        self.optionalButtonURL = optionalButtonURL
        self.optionalButtonAction = optionalButtonAction
        self.optionalButtonView = optionalButtonView
    }
    
    /// Creates Welcome Sheet page.
    public init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonUIView: UIView? = nil) {
        self.init(title: title, rows: rows, accentColor: nil, backgroundColor: nil, mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction, optionalButtonView: Self.getAnyViewFrom(uiVIew: optionalButtonUIView))
    }
    
    // V SwiftUI Initializers V
    
    /// Creates Welcome Sheet page.
    public init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], accentColor: Color?, backgroundColor: Color?, mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonView: (() -> any View)? = nil) {
        self.init(title: title, rows: rows, accentColor: accentColor, backgroundColor: backgroundColor, mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction, optionalButtonView: Self.getAnyViewFrom(view: optionalButtonView))
    }
    
    /// Creates Welcome Sheet page.
    public init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], accentColor: Color?, mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonView: (() -> any View)? = nil) {
        self.init(title: title, rows: rows, accentColor: accentColor, backgroundColor: nil, mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction, optionalButtonView: Self.getAnyViewFrom(view: optionalButtonView))
    }
    
    /// Creates Welcome Sheet page.
    public init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], backgroundColor: Color?, mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonView: (() -> any View)? = nil) {
        self.init(title: title, rows: rows, accentColor: nil, backgroundColor: backgroundColor, mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction, optionalButtonView: Self.getAnyViewFrom(view: optionalButtonView))
    }
    
    // V UIKit initializer V
    
    /// Creates Welcome Sheet page.
    public init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], accentUIColor: UIColor?, backgroundUIColor: UIColor?, mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonUIView: UIView? = nil) {
        self.init(title: title, rows: rows, accentColor: accentUIColor?.toColor(), backgroundColor: backgroundUIColor?.toColor(), mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction, optionalButtonView: Self.getAnyViewFrom(uiVIew: optionalButtonUIView))
    }
    
    /// Creates Welcome Sheet page.
    public init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], accentUIColor: UIColor?, mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonUIView: UIView? = nil) {
        self.init(title: title, rows: rows, accentColor: accentUIColor?.toColor(), backgroundColor: nil, mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction, optionalButtonView: Self.getAnyViewFrom(uiVIew: optionalButtonUIView))
    }
    
    /// Creates Welcome Sheet page.
    public init(title: LocalizedStringKey, rows: [WelcomeSheetPageRow], backgroundUIColor: UIColor?, mainButtonTitle: LocalizedStringKey? = nil, optionalButtonTitle: LocalizedStringKey? = nil, optionalButtonURL: URL? = nil, optionalButtonAction: (() -> ())? = nil, optionalButtonUIView: UIView? = nil) {
        self.init(title: title, rows: rows, accentColor: nil, backgroundColor: backgroundUIColor?.toColor(), mainButtonTitle: mainButtonTitle, optionalButtonTitle: optionalButtonTitle, optionalButtonURL: optionalButtonURL, optionalButtonAction: optionalButtonAction, optionalButtonView: Self.getAnyViewFrom(uiVIew: optionalButtonUIView))
    }
    
    // V Codable initializer V
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try LocalizedStringKey(container.decode(String.self, forKey: .title))
        rows = try container.decode([WelcomeSheetPageRow].self, forKey: .rows)
        
        do {
            mainButtonTitle = try LocalizedStringKey(container.decode(String.self, forKey: .mainButtonTitle))
        } catch {
            mainButtonTitle = "Continue"
        }
        
        do {
            let colorHex = try container.decode(String.self, forKey: .accentColor)
            accentColor = Color(hex: colorHex)
        } catch {
            accentColor = nil
        }
        
        do {
            let colorHex = try container.decode(String.self, forKey: .backgroundColor)
            backgroundColor = Color(hex: colorHex)
        } catch {
            accentColor = nil
        }
        
        do {
            optionalButtonTitle = try LocalizedStringKey(container.decode(String.self, forKey: .optionalButtonTitle))
        } catch {
            optionalButtonTitle = nil
        }
        
        do {
            let urlString = try container.decode(String.self, forKey: .optionalButtonURL)
            optionalButtonURL = URL(string: urlString)
        } catch {
            optionalButtonURL = nil
        }
        
        do {
            isShowingOptionalButton = try container.decode(Bool.self, forKey: .isShowingOptionalButton)
        } catch {
            if optionalButtonTitle != nil {
                isShowingOptionalButton = true
            } else {
                isShowingOptionalButton = false
            }
        }
    }
}

private extension WelcomeSheetPage {
    static func getAnyViewFrom(view: (() -> any View)?) -> AnyView? {
        guard let view else { return nil }
        return AnyView(view())
    }
    
    static func getAnyViewFrom(uiVIew: UIView?) -> AnyView? {
        guard let uiVIew else { return nil }
        return AnyView(OptionalButtonView(uiView: uiVIew))
    }
}
