precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence

protocol Exponentiable {
    static func ** (_ base: Self, _ exponent: Self) -> Self
}
