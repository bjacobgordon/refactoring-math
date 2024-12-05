public protocol Operable {
    /// Changes the cardinality of this value to the next one.
    mutating func succeed()
    
    /// Changes the cardinality of this value to the previous one.
    mutating func precede()
}

extension Operable {
    public var successor: Self {
        var clone = self
        clone.succeed()
        return clone
    }
    
    public var predecessor: Self {
        var clone = self
        clone.precede()
        return clone
    }
}
