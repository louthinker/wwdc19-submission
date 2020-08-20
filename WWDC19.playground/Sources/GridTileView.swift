
/* Class: GridTileView */
/* Visualization of a wall tile. */

import UIKit

public enum GridTileType {
    
    // Duck can go through
    case open
    
    // Duck can't go through
    case wall
    
}

public class GridTileView: UIView {
    
    public var color: UIColor
    public let type: GridTileType
    
    public init(type: GridTileType, x: Double, y: Double) {
        color = .clear
        self.type = type
        super.init(frame: CGRect(x: x, y: y, width: 40.0, height: 40.0))
    }
    
    public convenience init(type: GridTileType, x: Double, y: Double, color: UIColor) {
        self.init(type: type, x: x, y: y)
        self.color = color
        backgroundColor = color
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
