extension AtomicTransition {
    /// Provides a composite transition that uses a different transition for insertion versus removal.
    public static func asymmetric(insertion: Self, removal: Self) -> Self {
        .init { animator, view, operation, container in
            switch operation {
            case .insertion:
                insertion.prepare(animator, or: view, for: operation, in: container)
            case .removal:
                removal.prepare(animator, or: view, for: operation, in: container)
            }
        }
    }
}