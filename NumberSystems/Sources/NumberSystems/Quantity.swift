import Foundation

let tallyMark: Character = "|"

public struct Quantity: Sendable {
    fileprivate static let standardEmbodyingElement = tallyMark
    private static let             embodimentOfNone = ""
    
    public static let none = Self(Self.embodimentOfNone)!
    
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

extension String {
    fileprivate var hasProprietaryElements: Bool {
        self.contains { $0 != Quantity.standardEmbodyingElement }
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
