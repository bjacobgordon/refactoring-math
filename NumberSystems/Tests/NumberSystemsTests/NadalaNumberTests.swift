import Testing
@testable import NumberSystems

@Test func quantitiesOfNadalaDigits() async throws {
    NadalaNumber.Digit.allCases.forEach {
        #expect($0.quantityMatchesCardinality)
    }
}
