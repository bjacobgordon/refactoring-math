import Foundation

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

extension Quantity: Comparable {
    private func compared(to another: Self) -> ComparisonResult {
        return self.embodiment.cardinalityCompare(another.embodiment)
    }
    
    public static func < (leftHandOperand: Self, rightHandOperand: Self) -> Bool {
        return leftHandOperand.compared(to: rightHandOperand) == .orderedAscending
    }
    
    public static func == (leftHandOperand: Self, rightHandOperand: Self) -> Bool {
        return leftHandOperand.compared(to: rightHandOperand) == .orderedSame
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
    
    public static func hyperoperate(
        at givenLevel      : Quantity,
        by givenOperametrum: Quantity,
        on givenOperand    : Quantity
    ) -> Quantity {
        let effectiveOperametrum = (givenLevel == Quantity.none)
            ? Quantity.singular
            : givenOperametrum
        
        if (givenLevel == Quantity("")!) {
            var runningOperatum = givenOperand
            
            effectiveOperametrum.embodiment.forEach { _ in
                runningOperatum.succeed()
            }
            
            return runningOperatum
        }
        else
        if (givenLevel == Quantity("|")!) {
            var runningOperatum = givenOperand
            
            effectiveOperametrum.embodiment.forEach { _ in
                runningOperatum.succeed()
            }
            
            return runningOperatum
        }
        else
        if (givenLevel == Quantity("||")!) {
            let precedingLevel = givenLevel.predecessor
            var runningOperatum = Self.identity(at: precedingLevel)!
            
            effectiveOperametrum.embodiment.forEach { _ in
                let eachOperand     = runningOperatum
                let eachOperametrum =   givenOperand
                runningOperatum     = Self.hyperoperate(at: precedingLevel, by: eachOperametrum, on: eachOperand)
            }
            
            return runningOperatum
        }
        else
        if (givenLevel == Quantity("|||")!) {
            let precedingLevel = givenLevel.predecessor
            var runningOperatum = Self.identity(at: precedingLevel)!
            
            effectiveOperametrum.embodiment.forEach { _ in
                runningOperatum = Self.hyperoperate(at: precedingLevel, by: runningOperatum, on: givenOperand)
            }
            
            return runningOperatum
        }
        else
        if (givenLevel == Quantity("||||")!) {
            let precedingLevel = givenLevel.predecessor
            var runningOperatum = Self.identity(at: precedingLevel)!
            
            effectiveOperametrum.embodiment.forEach { _ in
                runningOperatum = Self.hyperoperate(at: precedingLevel, by: runningOperatum, on: givenOperand)
            }
            
            return runningOperatum
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

extension String {
    private func ends(beyond givenIndex: String.Index) -> Bool {
        givenIndex < self.endIndex
    }
    
    fileprivate func cardinalityCompare(_ that: String) -> ComparisonResult {
        let this = self
        
        var intermediateIndex = (
            forThis: this.startIndex,
            forThat: that.startIndex
        )
        
        while (true) {
            let thisKeepsGoing = this.ends(beyond: intermediateIndex.forThis)
            let thatKeepsGoing = that.ends(beyond: intermediateIndex.forThat)
            
            switch (thisKeepsGoing, thatKeepsGoing) {
            case   (          true,         false): return .orderedDescending
            case   (         false,         false): return .orderedSame
            case   (         false,          true): return .orderedAscending
            case   (          true,          true):
                intermediateIndex.forThis = this.index(after: intermediateIndex.forThis)
                intermediateIndex.forThat = that.index(after: intermediateIndex.forThat)
            }
        }
    }
}
