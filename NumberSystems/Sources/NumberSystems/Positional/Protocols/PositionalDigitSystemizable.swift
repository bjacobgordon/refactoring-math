public protocol PositionalDigitSystemizable: CaseIterable, RawRepresentable<Int> {
    static var placeholder: Self { get }
    
    var predecessor: Self { get }
}

extension PositionalDigitSystemizable {
    public static func fatalPredecessionError() -> Never {
        fatalError("Digit has no defined precedent")
    }
    
    public var quantity: Quantity {
        if self == Self.placeholder { return Quantity.none }
        
        let precedingQuantity = self.predecessor.quantity
        return precedingQuantity.successor
    }
}

extension PositionalDigitSystemizable {
    public var cardinality: Int {
        self.rawValue
    }
    
    public var quantityMatchesCardinality: Bool {
        self.cardinality.represents(self.quantity)
    }
}
