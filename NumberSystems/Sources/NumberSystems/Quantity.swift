let tallyMark: Character = "|"

public struct Quantity: Sendable {
    fileprivate static let standardEmbodyingElement = tallyMark
    private static let             embodimentOfNone = ""
    
    public static let none     = Self(Self.embodimentOfNone)!
    public static let singular = Self(String(Self.standardEmbodyingElement))!
    
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
    
    public mutating func precede() {
        guard (self != Quantity.none) else { fatalError("There is no precedent for a lack of quantity") }
        
        self.embodiment.removeLast()
    }
    
    public static func identity(at givenLevel: Quantity) -> Quantity? {
        switch givenLevel {
        case Quantity.none    : return nil
        case Quantity.singular: return Quantity.none
        default               : return Quantity.singular
        }
    }
    
    public static func hyperoperateUpon(
        atLevel givenLevel: Quantity,
        by givenOperametrum: Quantity,
        on givenOperand: inout Quantity
    ) {
        if (givenLevel == Quantity.none) { return givenOperand.succeed() }
        
        // (1 + (1 + (1 + (1 + 2))))
        // (1 + (1 + (1 + (0 + 3))))
        // (1 + (1 + (1 + (    3))))
        // (1 + (1 + (1 +      3 )))
        // (1 + (1 + (0 +      4 )))
        // (1 + (1 + (         4 )))
        // (1 + (1 +           4  ))
        // (1 + (0 +           5  ))
        // (1 + (              5  ))
        // (1 +                5   )
        // (0 +                6   )
        // (                   6   )
        //                     6
        //  two increase                 by four toGet six
        // four turns                       two  into  six
        // four added                    to two  yields six
        // four hyperoperate atLevel one on two  yields six
        else if givenLevel == Quantity("|")! {
            givenOperametrum.embodiment.forEach { _ in
                Self.hyperoperateUpon(atLevel: givenLevel.predecessor, by: givenOperand, on: &givenOperand)
            }
            
            return
        }
        else if
            (givenLevel == Quantity("||" )!) ||
            (givenLevel == Quantity("|||")!)
        {
            let precedingLevel = givenLevel.predecessor
            var operatum = Self.identity(at: precedingLevel)!
            
            givenOperametrum.embodiment.forEach { _ in
                Self.hyperoperateUpon(atLevel: precedingLevel, by: givenOperand, on: &operatum)
            }
            
            givenOperand = operatum
            
            return
        }
        else if
            (givenLevel == Quantity("||||")!)
        {
            let precedingLevel = givenLevel.predecessor
            var runningOperatum = Self.identity(at: precedingLevel)!
            
            givenOperametrum.embodiment.forEach { _ in
                var eachOperand     =   givenOperand
                let eachOperametrum = runningOperatum
                Self.hyperoperateUpon(atLevel: precedingLevel, by: eachOperametrum, on: &eachOperand)
                runningOperatum = eachOperand
            }
            
            givenOperand = runningOperatum
            
            return
        }
        
        fatalError("Higher-level operations not yet defined")
    }
}

extension String {
    fileprivate var hasProprietaryElements: Bool {
        self.contains { $0 != Quantity.standardEmbodyingElement }
    }
    
    fileprivate static func standardEmbodimentOf(_ givenValue: Int) -> String {
        guard 0 <= givenValue else { fatalError("Cannot initiate Quantity instance from negative value") }
        
        return String(
            repeating: Quantity.standardEmbodyingElement,
            count: givenValue
        )
    }
}

extension Int {
    public func represents(_ givenQuantity: Quantity) -> Bool {
        self == givenQuantity.embodiment.count
    }
    
    public var asQuantity: Quantity {
        let newEmbodiment = String.standardEmbodimentOf(self)
        return Quantity(newEmbodiment)!
    }
}
