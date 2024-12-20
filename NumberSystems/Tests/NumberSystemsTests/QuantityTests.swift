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
                #expect(outer.element == inner.element, "Quantity should equal itself.")
            } else {
                #expect(outer.element != inner.element, "Quantity should not equal its neighbors.")
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
    let zero =  0.asQuantity
    let ten  = 10.asQuantity
    
    let eleven =    ten.hyperoperatedUpon(atLevel: zero, by: givenOperametrum)
    let twelve = eleven.hyperoperatedUpon(atLevel: zero, by: givenOperametrum)
    
    #expect(11.represents(eleven))
    #expect(12.represents(twelve))
}

@Test func hyperoperationAtLevel1() async throws {
    let one  =  1.asQuantity
    let two  =  2.asQuantity
    let ten  = 10.asQuantity
    
    let twelve = ten.hyperoperatedUpon(atLevel: one, by: two)
    #expect(12.represents(twelve))
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
    let operatum    = operand.hyperoperatedUpon(atLevel: secondLevel, by: operametrum)
    
    let product = givenMultiplicand * givenMultiplier
    #expect(product.represents(operatum))
}

@Test("Comparison of level 3 hyperoperation to multiplication", arguments: [
    (4, 1),
    (3, 2),
    (2, 3),
    (1, 4)
])
func hyperoperationAtLevel3(_ givenBase: Int, _ givenExponent: Int) async throws {
    let thirdLevel = 3.asQuantity
    
    let operametrum = givenExponent.asQuantity
    let operand     = givenBase    .asQuantity
    let operatum    = operand.hyperoperatedUpon(atLevel: thirdLevel, by: operametrum)
    
    let power = givenBase ** givenExponent
    #expect(power.represents(operatum))
}

@Test func hyperoperationAtLevel4() async throws {
    let fourthLevel = 4.asQuantity
    
    let operametrum = 4.asQuantity
    let operand     = 2.asQuantity
    let operatum    = operand.hyperoperatedUpon(atLevel: fourthLevel, by: operametrum)
    
    let tetratum    = (2**2**2**2**1)
    #expect(tetratum.represents(operatum))
}
