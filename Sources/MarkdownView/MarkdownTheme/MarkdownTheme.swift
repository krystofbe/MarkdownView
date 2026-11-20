//
//  MarkdownTheme.swift
//  MarkdownView
//
//  Created by 秋星桥 on 2025/1/3.
//

import Foundation
import Litext

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public extension MarkdownTheme {
    @MainActor static var `default`: MarkdownTheme = .init()
    static let codeScale = 0.85
}

public struct MarkdownTheme: Equatable, @unchecked Sendable {
    public struct Fonts: Equatable, @unchecked Sendable {
        #if canImport(UIKit)
            public var body = UIFont.preferredFont(forTextStyle: .body)
            public var codeInline = UIFont.monospacedSystemFont(
                ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize,
                weight: .regular
            )
            public var bold = UIFont.preferredFont(forTextStyle: .body).bold
            public var italic = UIFont.preferredFont(forTextStyle: .body).italic
            public var code = UIFont.monospacedSystemFont(
                ofSize: ceil(UIFont.preferredFont(forTextStyle: .body).pointSize * codeScale),
                weight: .regular
            )
            public var largeTitle = UIFont.preferredFont(forTextStyle: .body).bold
            public var title = UIFont.preferredFont(forTextStyle: .body).bold
            public var footnote = UIFont.preferredFont(forTextStyle: .footnote)
            /// Per-level heading fonts (index 0 is h1). Empty keeps `title` for every level.
            public var headings: [UIFont] = []
            /// Font of table header text. nil keeps a bold system font at the text size.
            public var tableHeader: UIFont?
        #elseif canImport(AppKit)
            public var body = NSFont.systemFont(ofSize: NSFont.systemFontSize)
            public var codeInline = NSFont.monospacedSystemFont(
                ofSize: NSFont.systemFontSize,
                weight: .regular
            )
            public var bold = NSFont.systemFont(ofSize: NSFont.systemFontSize).bold
            public var italic = NSFont.systemFont(ofSize: NSFont.systemFontSize).italic
            public var code = NSFont.monospacedSystemFont(
                ofSize: ceil(NSFont.systemFontSize * codeScale),
                weight: .regular
            )
            public var largeTitle = NSFont.systemFont(ofSize: NSFont.systemFontSize).bold
            public var title = NSFont.systemFont(ofSize: NSFont.systemFontSize).bold
            public var footnote = NSFont.systemFont(ofSize: NSFont.smallSystemFontSize)
            /// Per-level heading fonts (index 0 is h1). Empty keeps `title` for every level.
            public var headings: [NSFont] = []
            public var tableHeader: NSFont?
        #endif
    }

    public var fonts: Fonts = .init()

    public struct Colors: Equatable, @unchecked Sendable {
        #if canImport(UIKit)
            public var body = UIColor.label
            public var highlight =
                UIColor(named: "AccentColor")
                    ?? UIColor(named: "accentColor")
                    ?? .systemOrange
            public var emphasis =
                UIColor(named: "AccentColor")
                    ?? UIColor(named: "accentColor")
                    ?? .systemOrange
            public var code = UIColor.label
            public var codeBackground = UIColor.gray.withAlphaComponent(0.25)
            public var selectionBackground: UIColor? =
                (UIColor(named: "AccentColor")
                        ?? UIColor(named: "accentColor")
                        ?? .systemOrange).withAlphaComponent(0.2)
            /// Color of level 6 headings. nil keeps the text color.
            public var headingSecondary: UIColor?
            /// Link text color. nil keeps `highlight`.
            public var link: UIColor?
            /// Inline code background used as is. nil keeps `codeBackground` at 5 % alpha.
            public var inlineCodeBackground: UIColor?
            /// Bullet and number color. nil keeps the first run's text color.
            public var listMarker: UIColor?
            /// Left bar of block quotes. nil keeps the text color at 10 % alpha.
            public var quoteBar: UIColor?
            /// Text color inside block quotes. nil keeps the body color.
            public var quoteText: UIColor?
            /// Thematic break line. nil keeps the text color at 10 % alpha.
            public var rule: UIColor?
        #elseif canImport(AppKit)
            public var body = NSColor.labelColor
            public var highlight =
                NSColor(named: "AccentColor")
                    ?? NSColor(named: "accentColor")
                    ?? .systemOrange
            public var emphasis =
                NSColor(named: "AccentColor")
                    ?? NSColor(named: "accentColor")
                    ?? .systemOrange
            public var code = NSColor.labelColor
            public var codeBackground = NSColor.gray.withAlphaComponent(0.25)
            public var selectionBackground: NSColor? =
                (NSColor(named: "AccentColor")
                        ?? NSColor(named: "accentColor")
                        ?? .systemOrange).withAlphaComponent(0.2)
            public var headingSecondary: NSColor?
            public var link: NSColor?
            public var inlineCodeBackground: NSColor?
            public var listMarker: NSColor?
            public var quoteBar: NSColor?
            public var quoteText: NSColor?
            public var rule: NSColor?
        #endif
    }

    public var colors: Colors = .init()

    public struct Spacings: Equatable, Sendable {
        public var final: CGFloat = 16
        public var general: CGFloat = 8
        public var list: CGFloat = 8
        public var cell: CGFloat = 32
        /// Space after a paragraph and after the last item of a list.
        public var paragraph: CGFloat = 16
        /// Extra space between the lines of a paragraph, list item or quote.
        public var lineSpacing: CGFloat = 4
        /// Space around headings.
        public var headingBefore: CGFloat = 16
        public var headingAfter: CGFloat = 16
        /// Drops the space after the last paragraph so stacked views control the gap themselves.
        public var trimsTrailingParagraphSpacing = false
    }

    public struct Links: Equatable, Sendable {
        /// Underline for link text, for example `[.single, .patternDot]`. nil draws none.
        public var underlineStyle: NSUnderlineStyle?
        /// Text appended to every link, for example an arrow. nil appends nothing.
        public var suffix: String?
        /// Suffix size relative to the body font.
        public var suffixScale: CGFloat = 0.7
    }

    public var links: Links = .init()

    public enum ListNumberStyle: Equatable, Sendable {
        /// Numbers 0 to 50 as circled symbols (original look).
        case circle
        /// "n." in the body font.
        case text
    }

    public var listNumberStyle: ListNumberStyle = .circle

    public enum ImageStyle: Equatable, Sendable {
        /// The source URL as link text (original look).
        case sourceLink
        /// The alt text, or the file name without one, as a link to the source.
        case altTextLink
    }

    public var imageStyle: ImageStyle = .sourceLink

    public enum EmphasisStyle: Equatable, Sendable {
        /// Thick underline in `colors.emphasis` (original look).
        case underline
        /// Italic font trait, combinable with bold.
        case italic
    }

    public var emphasisStyle: EmphasisStyle = .underline

    public var spacings: Spacings = .init()

    public struct Sizes: Equatable, Sendable {
        public var bullet: CGFloat = 4
    }

    public var sizes: Sizes = .init()

    public struct Table: Equatable, @unchecked Sendable {
        public var cornerRadius: CGFloat = 8
        /// Whether cell text can be selected on its own. Turn off when the host owns selection.
        public var cellsSelectable = true
        public var borderWidth: CGFloat = 1
        #if canImport(UIKit)
            public var borderColor = UIColor.separator
            public var headerBackgroundColor = UIColor.systemGray6
            public var cellBackgroundColor = UIColor.clear
            public var stripeCellBackgroundColor = UIColor.systemGray.withAlphaComponent(0.03)
        #elseif canImport(AppKit)
            public var borderColor = NSColor.separatorColor
            public var headerBackgroundColor = NSColor.windowBackgroundColor
            public var cellBackgroundColor = NSColor.clear
            public var stripeCellBackgroundColor = NSColor.systemGray.withAlphaComponent(0.03)
        #endif
    }

    public var table: Table = .init()

    public init() {}
}

public extension MarkdownTheme {
    static var defaultValueFont: Fonts {
        Fonts()
    }

    static var defaultValueColor: Colors {
        Colors()
    }

    static var defaultValueSpacing: Spacings {
        Spacings()
    }

    static var defaultValueSize: Sizes {
        Sizes()
    }

    static var defaultValueTable: Table {
        Table()
    }
}

public extension MarkdownTheme {
    enum FontScale: String, CaseIterable {
        case tiny
        case small
        case middle
        case large
        case huge
    }
}

public extension MarkdownTheme.FontScale {
    var offset: Int {
        switch self {
        case .tiny: -4
        case .small: -2
        case .middle: 0
        case .large: 2
        case .huge: 4
        }
    }

    func scale(_ font: PlatformFont) -> PlatformFont {
        let size = max(4, font.pointSize + CGFloat(offset))
        return font.withSize(size)
    }
}

public extension MarkdownTheme {
    mutating func scaleFont(by scale: FontScale) {
        let defaultFont = Self.defaultValueFont
        fonts.body = scale.scale(defaultFont.body)
        fonts.codeInline = scale.scale(defaultFont.codeInline)
        fonts.bold = scale.scale(defaultFont.bold)
        fonts.italic = scale.scale(defaultFont.italic)
        fonts.code = scale.scale(defaultFont.code)
        fonts.largeTitle = scale.scale(defaultFont.largeTitle)
        fonts.title = scale.scale(defaultFont.title)
    }

    mutating func align(to pointSize: CGFloat) {
        fonts.body = fonts.body.withSize(pointSize)
        fonts.codeInline = fonts.codeInline.withSize(pointSize)
        fonts.bold = fonts.bold.withSize(pointSize).bold
        fonts.italic = fonts.italic.withSize(pointSize)
        fonts.code = fonts.code.withSize(pointSize * Self.codeScale)
        fonts.largeTitle = fonts.largeTitle.withSize(pointSize).bold
        fonts.title = fonts.title.withSize(pointSize).bold
    }
}
