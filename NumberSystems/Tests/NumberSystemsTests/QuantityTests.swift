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

@Test("Successor of quantities", arguments: [
    0,
    10,
    100,
    1000
])
func successorOfQuantity(_ givenCount: Int) async throws {
    let operativeQuantity = givenCount.asQuantity
    let succeededCount    = givenCount + 1
    let succeededQuantity = operativeQuantity.successor
    #expect(succeededCount.represents(succeededQuantity))
}

@Test("Predecessor of quantities", arguments: [
    1,
    10,
    100,
    1000
])
func predecessorOfQuantity(_ givenCount: Int) async throws {
    let operativeQuantity = givenCount.asQuantity
    let  precededCount    = givenCount - 1
    let  precededQuantity = operativeQuantity.predecessor
    #expect(precededCount.represents(precededQuantity))
}

@Test("Operatrum-agnostic characteristics of level 0 hyperoperation", arguments: [
    Quantity(""  )!,
    Quantity("|" )!,
    Quantity("||")!
])
func hyperoperationAtLevel0(_ givenOperametrum: Quantity) async throws {
    let zerothLevel = 0.asQuantity
    
    let ten    = 10.asQuantity
    let eleven =    ten.hyperoperatedUpon(at: zerothLevel, by: givenOperametrum)
    let twelve = eleven.hyperoperatedUpon(at: zerothLevel, by: givenOperametrum)
    
    #expect(11.represents(eleven))
    #expect(12.represents(twelve))
}

@Test("Alignment of level 1 hyperoperation with addition", arguments: [
    (   1, 1),
    (  10, 2),
    ( 100, 3),
    (1000, 4)
])
func hyperoperationAtLevel1(_ givenAugend: Int, _ givenAddend: Int) async throws {
    let firstLevel =  1.asQuantity
    
    let operand     = givenAugend.asQuantity
    let operametrum = givenAddend.asQuantity
    let operatum    = operand.hyperoperatedUpon(at: firstLevel, by: operametrum)
    
    let sum = givenAugend + givenAddend
    #expect(sum.represents(operatum))
}

@Test("Comparison of level 2 hyperoperation to multiplication", arguments: [
    (   1, 1),
    (  10, 2),
    ( 100, 3),
    (1000, 4)
])
func hyperoperationAtLevel2(_ givenMultiplicand: Int, _ givenMultiplier: Int) async throws {
    let secondLevel = 2.asQuantity
    
    let operametrum = givenMultiplier  .asQuantity
    let operand     = givenMultiplicand.asQuantity
    let operatum    = operand.hyperoperatedUpon(at: secondLevel, by: operametrum)
    
    let product = givenMultiplicand * givenMultiplier
    #expect(product.represents(operatum))
}

@Test("Comparison of level 3 hyperoperation to exponentiation", arguments: [
    (4, 1),
    (3, 2),
    (2, 3),
    (1, 4)
])
func hyperoperationAtLevel3(_ givenBase: Int, _ givenExponent: Int) async throws {
    let thirdLevel = 3.asQuantity
    
    let operametrum = givenExponent.asQuantity
    let operand     = givenBase    .asQuantity
    let operatum    = operand.hyperoperatedUpon(at: thirdLevel, by: operametrum)
    
    let power = givenBase ** givenExponent
    #expect(power.represents(operatum))
}
