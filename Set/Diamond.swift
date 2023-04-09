//
//  Diamond.swift
//  Set
//
//  Created by Oliver Hnát on 08.04.2023.
//

import SwiftUI


struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {

        let leftSide = CGPoint(x: rect.minX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.midY-rect.maxY/4)
        let rightSide = CGPoint(x: rect.maxX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.midY+rect.maxY/4)
        
        var p = Path()
        
        p.move(to: rightSide)
        p.addLine(to: top)
        p.addLine(to: leftSide)
        p.addLine(to: bottom)
        p.addLine(to: rightSide)
        
        return p
    }
    
}
