//
//  Shapes.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-20.
//

import Foundation
import SwiftUI

struct BorderFrame: Shape {
    var paths:[CGPoint]
    init() {
        paths = []
    }
    
     var animatableData: [CGPoint] {
       get { paths }
       set { paths = newValue }
     }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 1.0
        let trs = CGPoint(x: UIScreen.screenWidth - radius, y: 0)
        let tr = CGPoint(x: Int(UIScreen.screenWidth  - radius), y: 0)
        let br = CGPoint(x: UIScreen.screenWidth - radius, y: UIScreen.screenHeight - radius  )
        
        let bl = CGPoint(x: radius + radius, y: UIScreen.screenHeight)
        let tl = CGPoint(x: radius , y: 0 + radius )
        
        path.move(to: CGPoint(x:  radius + radius, y: 0))
        // path.addLine(to: CGPoint(x: 10, y: 40))
        path.addArc(tangent1End: CGPoint(x: trs.x, y: 0) , tangent2End: CGPoint(x: tr.x, y: tr.y + 5) , radius: radius)
           // path.addLine(to: tre)\
        path.addLine(to: br)
        path.addArc(tangent1End: CGPoint(x: br.x, y: br.y + radius) , tangent2End: CGPoint(x: br.x - radius, y: br.y + radius) , radius: radius)
        path.addLine(to: bl)
        path.addArc(tangent1End: CGPoint(x: bl.x - radius  , y: bl.y  ) , tangent2End: CGPoint(x: bl.x - radius, y: bl.y - radius) , radius: radius)
        path.addLine(to: tl)
        path.addArc(tangent1End: CGPoint(x: tl.x    , y: tl.y - radius ) , tangent2End: CGPoint(x: tl.x + radius , y: tl.y - radius) , radius: radius)
        return path
       
    }
}
