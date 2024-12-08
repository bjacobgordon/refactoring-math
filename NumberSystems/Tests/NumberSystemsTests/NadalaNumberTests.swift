import Testing
@testable import NumberSystems

@Test func quantitiesOfNadalaDigits() async throws {
    NadalaNumber.Digit.allCases.forEach {
        #expect($0.quantityMatchesCardinality)
    }
}

@Test func symbolsOfNadalaDigits() async throws {
    
}

@Test func universalNamesOfNadalaDigits() async throws {
    
}

@Test func singleDigitNadalaNumbers() async throws {
    
}
