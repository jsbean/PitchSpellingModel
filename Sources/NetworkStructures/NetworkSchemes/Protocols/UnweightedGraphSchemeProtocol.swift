//
//  UnweightedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol UnweightedGraphSchemeProtocol: GraphSchemeProtocol {
    init (_ contains: @escaping (Edge) -> Bool)
}

extension UnweightedGraphSchemeProtocol {
    @inlinable
    public func pullback <H> (_ path: KeyPath<H.Node, Node>) -> H where
        H: UnweightedGraphSchemeProtocol
    {
        return pullback { $0[keyPath: path] }
    }
    
    @inlinable
    public func pullback <H> (_ f: @escaping (H.Node) -> Node) -> H where
        H: UnweightedGraphSchemeProtocol
    {
        return H { self.contains(Edge(f($0.a),f($0.b))) }
    }
}
