let tallyMark: Character = "|"

public struct Quantity: Sendable {
    fileprivate static let standardEmbodyingElement = tallyMark
    private static let         embodimentOfNone = ""
    
    public static let none = Self(Self.embodimentOfNone)!
    
    fileprivate var embodiment: String
    
    public init?(_ givenEmbodiment: String) {
        if givenEmbodiment.hasProprietaryElements { return nil }

        self.embodiment = givenEmbodiment
    }
}

extension Quantity: Equatable {
    public static func ==(_ leftHandOperand: Self, _ rightHandOperand: Self) -> Bool {
        var currentIndexOnLeftHand  =  leftHandOperand.embodiment.startIndex
        var currentIndexOnRightHand = rightHandOperand.embodiment.startIndex

        while (
            (currentIndexOnLeftHand  <  leftHandOperand.embodiment.endIndex) &&
            (currentIndexOnRightHand < rightHandOperand.embodiment.endIndex)
        ) {
            currentIndexOnLeftHand  =  leftHandOperand.embodiment.index(after: currentIndexOnLeftHand)
            currentIndexOnRightHand = rightHandOperand.embodiment.index(after: currentIndexOnRightHand)
        }

        return
            (currentIndexOnLeftHand  ==  leftHandOperand.embodiment.endIndex) &&
            (currentIndexOnRightHand == rightHandOperand.embodiment.endIndex)
    }
}

extension Quantity: Hyperoperable {
    public mutating func succeed() {
        let newElement = self.embodiment.first ?? Quantity.standardEmbodyingElement
        self.embodiment.append(newElement)
    }
    
    public mutating func hyperoperateUpon(
        atLevel givenLevel: Quantity,
        by givenOperametrum: Quantity
    ) {
        if (givenLevel == Quantity.none) { return self.succeed() }

        fatalError("Higher-level operations not yet defined")
    }
}

extension String {
    fileprivate var hasProprietaryElements: Bool {
        self.contains { $0 != Quantity.standardEmbodyingElement }
    }
}

extension Int {
    public func represents(_ givenQuantity: Quantity) -> Bool {
        self == givenQuantity.embodiment.count
    }
}
