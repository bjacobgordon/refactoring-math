public protocol Hyperoperable: Equatable, Operable {
    static func hyperoperate(
        at givenLevel      : Self,
        by givenOperametrum: Self,
        on givenOperand    : Self
    ) -> Self
}

extension Hyperoperable {
    public func hyperoperatedUpon(
        at givenLevel      : Self,
        by givenOperametrum: Self
    ) -> Self {
        return Self.hyperoperate(
            at: givenLevel,
            by: givenOperametrum,
            on: self
        )
    }
}
