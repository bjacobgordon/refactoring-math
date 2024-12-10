public protocol Operable {
    /// Changes the cardinality of this value to the next one.
    mutating func succeed()
}

extension Operable {
    public var successor: Self {
        var clone = self
        clone.succeed()
        return clone
    }
}
