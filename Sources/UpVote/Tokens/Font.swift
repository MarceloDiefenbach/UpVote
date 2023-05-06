import SwiftUI

public extension Font {
    /// Namespace to prevent naming collisions with static accessors on
    /// SwiftUI's Font.
    ///
    /// Xcode's autocomplete allows for easy discovery of design system fonts.
    /// At any call site that requires a font, type `Font.DesignSystem.<esc>`
    struct DesignSystem {
        public static let bigRegular = Font.system(size: 40, weight: .regular, design: .default)
        public static let bigBold = Font.system(size: 40, weight: .bold, design: .default)
        public static let largeTitleBold = Font.system(size: 32, weight: .bold, design: .default)
        public static let largeTitleRegular = Font.system(size: 32, weight: .regular, design: .default)
        public static let titleBold = Font.system(size: 24, weight: .bold, design: .default)
        public static let titleRegular = Font.system(size: 24, weight: .regular, design: .default)
        public static let normalBold = Font.system(size: 16, weight: .bold, design: .default)
        public static let normalSemiBold = Font.system(size: 16, weight: .semibold, design: .default)
        public static let normalRegular = Font.system(size: 16, weight: .regular, design: .default)
        public static let smallBold = Font.system(size: 12, weight: .bold, design: .default)
        public static let smalRegular = Font.system(size: 12, weight: .regular, design: .default)
    }
}
