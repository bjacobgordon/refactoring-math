import Foundation

extension Int: Exponentiable {
    public static func ** (_ base: Int, _ exponent: Int) -> Int {
        return Int(
            pow(
                Double(base),
                Double(exponent)
            )
        )
    }
}
