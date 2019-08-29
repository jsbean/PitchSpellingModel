//
//  AdjacencySchemes.swift
//  SpellingNetworks
//
//  Created by Benjamin Wetherfield on 8/29/19.
//

import NetworkStructures
import Encodings
import DataStructures
import Pitch

struct AdjacencySchemes {
    
    /// Adjacency scheme that connects `.up` tendencies to `.down` tendencies
    // for sameInts
    static let connectUpToDown: NetworkScheme<UnassignedInnerNode> =
        NetworkScheme<Tendency> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return a == .up && b == .down
            default:
                return false
            }
            }.pullback { node in node.index.b }
    
    
    /// Adjacency scheme that connects `.source` to `.down` tendencies and not pitch class `8`
    static let connectSourceToDown: NetworkScheme<Cross<Pitch.Class, Tendency>> =
        NetworkScheme<Pitch.Class> { edge in
            edge.a == .source && edge.b != .internal(8)
            }.pullback { cross in cross.a }
            * NetworkScheme<Tendency> { edge in
                edge.a == .source && edge.b == .internal(.down)
                }.pullback { cross in cross.b }
    
    /// Adjacency scheme that connects `.up` tendencies and not pitch class `8` to `.sink`
    static let connectUpToSink: NetworkScheme<Cross<Pitch.Class, Tendency>> =
        NetworkScheme<Pitch.Class> { edge in
            edge.a != .internal(8) && edge.b == .sink
            }.pullback { cross in cross.a }
            * NetworkScheme<Tendency> { edge in
                edge.a == .internal(.up) && edge.b == .sink
                }.pullback { cross in cross.b }
    
    /// Adjacency scheme that connects nodes with the same `int` value
    static let connectSameInts: NetworkScheme<UnassignedInnerNode> =
        NetworkScheme<Int> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return a == b
            default:
                return false
            }
            }.pullback { node in node.index.a }
    
    /// Adjacency scheme that connects nodes with different `int` values
    static let connectDifferentInts: NetworkScheme<UnassignedInnerNode> =
        NetworkScheme<Int> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return a != b
            default:
                return false
            }
            }.pullback { node in node.index.a }
    
    /// Adjacency scheme that connects `.up` tendencies to `.down` tendencies and vice versa provided
    /// the pitch classes of the nodes are connected per `upDownEdgeLookup`
    static let connectDifferentTendencies: NetworkScheme<Cross<Pitch.Class, Tendency>> =
        NetworkScheme { edge in
            switch (edge.a, edge.b) {
            case let (.internal(source), .internal(destination)):
                return (
                    source.b != destination.b
                        && PitchClassesForDifferentTendenciesLookup.contains(.init(source.a, destination.a))
                )
            default:
                return false
            }
    }
    
    /// Adjacency scheme that connects nodes with the same tendency provided the pitch classes of the nodes
    /// are *not* connected per `upDownEdgeLookup`
    static let connectSameTendencies: NetworkScheme<Cross<Pitch.Class, Tendency>> =
        NetworkScheme { edge in
            switch (edge.a, edge.b) {
            case (.internal(let source), .internal(let destination)):
                return (
                    source.b == destination.b
                        && !PitchClassesForDifferentTendenciesLookup.contains(.init(source.a, destination.a))
                )
            default:
                return false
            }
    }
    
    static let connectPitchClassesForDifferentTendencies: NetworkScheme<Cross<Pitch.Class, Tendency>> =
        NetworkScheme { edge in
            switch (edge.a, edge.b) {
            case let (.internal(source), .internal(destination)):
                return PitchClassesForDifferentTendenciesLookup.contains(.init(source.a, destination.a))
            default:
                return false
            }
    }
    
    static let connectPitchClassesForSameTendencies: NetworkScheme<Cross<Pitch.Class, Tendency>> =
        NetworkScheme { edge in
            switch (edge.a, edge.b) {
            case let (.internal(source), .internal(destination)):
                return !PitchClassesForDifferentTendenciesLookup.contains(.init(source.a, destination.a))
            default:
                return false
            }
    }
    
    /// Pairs of pitch classes that have a different skew, such that `ModifierDirection.neutral` for one node is
    /// sharp or 'up' in absolute terms and for the other node it is down
    static let PitchClassesForDifferentTendenciesLookup: Set<UnorderedPair<Pitch.Class>> = [
        .init(00, 01),
        .init(00, 04),
        .init(00, 08),
        .init(01, 03),
        .init(01, 05),
        .init(01, 10),
        .init(03, 04),
        .init(03, 06),
        .init(03, 08),
        .init(03, 11),
        .init(04, 05),
        .init(05, 06),
        .init(05, 08),
        .init(05, 11),
        .init(06, 10),
        .init(07, 08),
        .init(08, 10),
        .init(10, 11)
    ]
}
