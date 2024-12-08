import Testing
@testable import NumberSystems

@Test func quantitiesOfDecimalDigits() async throws {
    DecimalNumber.Digit.allCases.forEach {
        #expect($0.quantityMatchesCardinality)
    }
}
