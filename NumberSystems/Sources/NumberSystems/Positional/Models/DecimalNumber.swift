public struct DecimalNumber: PositionalNumberSystemizable {
    public enum Digit: Int {
        case                          zero
        case one, two  , three, four, five
        case six, seven, eight, nine, ten
    }
}

extension DecimalNumber.Digit: PositionalDigitSystemizable {
    public static var placeholder: Self { .zero }
    
    public var predecessor: Self {
        switch self {
        case .ten  : return .nine
        case .nine : return .eight
        case .eight: return .seven
        case .seven: return .six
        case .six  : return .five
        case .five : return .four
        case .four : return .three
        case .three: return .two
        case .two  : return .one
        case .one  : return .placeholder
        default    : Self.fatalPredecessionError()
        }
    }
}
