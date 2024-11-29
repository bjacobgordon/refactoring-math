public struct NadalaNumber: PositionalNumberSystemizable {
    public enum Digit: Int {
        case               tɑ
        case  no , nɛ, nu, nɑ
        case `do`, dɛ, du, dɑ
        case  lo , lɛ, lu, lɑ
    }
}

extension NadalaNumber.Digit: PositionalDigitSystemizable {
    public static var placeholder: Self { .tɑ }
    
    public var predecessor: Self {
        switch self {
        case .lɑ: return .lu
        case .lu: return .lɛ
        case .lɛ: return .lo
        case .lo: return .dɑ
        case .dɑ: return .du
        case .du: return .dɛ
        case .dɛ: return .do
        case .do: return .nɑ
        case .nɑ: return .nu
        case .nu: return .nɛ
        case .nɛ: return .no
        case .no: return .placeholder
        default : Self.fatalPredecessionError()
        }
    }
}
