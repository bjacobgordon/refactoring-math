import Testing
@testable import NumberSystems

let maybeNone              = Quantity("")
let maybeStandardSingle    = Quantity("|")
let maybeStandardMany      = Quantity("||")
let maybeProprietarySingle = Quantity("🐄")
let maybeMixed             = Quantity("|🐄")

@Test func quantityInitializationViaString() async throws {
    #expect(maybeNone              != nil)
    #expect(maybeStandardSingle    != nil)
    #expect(maybeStandardMany      != nil)
    #expect(maybeProprietarySingle == nil)
    #expect(maybeMixed             == nil)
}

@Test func identitiesOfQuantities() async throws {
    let none           = maybeNone!
    let standardSingle = maybeStandardSingle!
    let standardMany   = maybeStandardMany!
    
    let uniqueQuantities = [
        none,
        standardSingle,
        standardMany,
    ].enumerated()
    
    uniqueQuantities.forEach { (outer) in
        uniqueQuantities.forEach { (inner) in
            if (outer.offset == inner.offset) {
                #expect(!(outer.element <  inner.element), "Quantity should not be less than itself."   )
                #expect(  outer.element == inner.element , "Quantity should be equal to itself."        )
                #expect(!(outer.element >  inner.element), "Quantity should not be greater than itself.")
                return
            }
            
            #expect(outer.element != inner.element, "Quantity should not be equal to others.")
            
            if (outer.offset < inner.offset) {
                #expect(outer.element < inner.element, "Quantity should be less than a subsequent neighbor.")
            }
            else
            if (outer.offset > inner.offset) {
                #expect(outer.element > inner.element, "Quantity should be greater than a preceding neighbor.")
            }
        }
    }
}

@Test("Conversion of decimal integers to quantities", arguments: [
    0,
    10,
    100,
    1000
])
func decimalIntegerToQuantity(_ givenCount: Int) async throws {
    let equivalentQuantity = givenCount.asQuantity
    #expect(givenCount.represents(equivalentQuantity))
}
