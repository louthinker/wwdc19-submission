
/* Class: GridView */
/* Visualization of the Grid object. */

import UIKit

public class GridView: UIView {
    
    private let duck: UIImageView
    private let grid: Grid
    private var tileViews: [[GridTileView]]
    
    public init(grid: Grid) {
        self.grid = grid
        duck = UIImageView(frame: CGRect(x: Double(50 + grid.startCoordinate.x * 40), y: Double(50 + grid.startCoordinate.y * 40), width: 40.0, height: 40.0))
        duck.image = UIImage(named: "Duck.png")
        duck.alpha = 0.0
        duck.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        tileViews = [[GridTileView]]()
        super.init(frame:  CGRect(x: 0, y: 0, width: 500.0, height: 500.0))
        backgroundColor = UIColor.Grid.Black
        setUpView()
    }
    
    private func setUpView() {
        
        // Border and its animation
        let background = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height))
        background.backgroundColor = UIColor.Grid.Blue
        self.addSubview(background)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            background.frame = CGRect(x: 50.0, y: 50.0, width: 400.0, height: 400.0)
        })
        
        // Wall tiles
        for y in 0 ..< grid.height {
            var row = [GridTileView]()
            for x in 0 ..< grid.width {
                if grid.walls.contains(where: { $0 == (x, y) }) {
                    let tile = GridTileView(type: .wall, x: Double(50 + x * 40), y: Double(50 + y * 40), color: UIColor.Grid.Black)
                    tile.alpha = 0.0
                    tile.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    row.append(tile)
                    self.addSubview(tile)
                } else {
                    let tile = GridTileView(type: .open, x: Double(50 + x * 40), y: Double(50 + y * 40))
                    tile.alpha = 0.0
                    row.append(tile)
                    self.addSubview(tile)
                }
            }
            tileViews.append(row)
        }
        
        // Walls animation
        for y in 0 ..< tileViews.count {
            for x in 0 ..< tileViews[y].count {
                if tileViews[y][x].type == .wall {
                    
                    UIView.animate(withDuration: 0.2, delay: 0.5 + Double(x + y) * 0.1, options: .curveEaseOut, animations: {
                        self.tileViews[y][x].alpha = 1.0
                    })
                    
                    UIView.animate(withDuration: 0.4, delay: 0.5 + Double(x + y) * 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                        self.tileViews[y][x].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    })
                    
                }
            }
        }
        
        let finishTile = UILabel(frame: CGRect(x: Double(50 + grid.endCoordinate.x * 40), y: Double(50 + grid.endCoordinate.y * 40), width: 40.0, height: 40.0))
        finishTile.textAlignment = .center
        finishTile.text = "🏁"
        finishTile.alpha = 0.0
        finishTile.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        self.addSubview(finishTile)
        self.addSubview(duck)
        
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
            self.duck.alpha = 1.0
            finishTile.alpha = 1.0
        })
        
        UIView.animate(withDuration: 1.0, delay: 1.5, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.duck.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            finishTile.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            self.showShortestPath()
        })
        
    }
    
    private func showShortestPath() {
        let algorithm = PathfindingAlgorithm()
        let shortestPath = algorithm.findShortestPath(map: grid)
        animateDuckThroughPath(path: shortestPath)
    }
    
    public func animateDuckThroughPath(path: [(Int, Int)]) {
        
        for i in 0 ..< path.count {
            
            if i == 0 {
                
                UIView.animate(withDuration: 0.125, delay: 0.25 * Double(i), options: .curveEaseOut, animations: {
                    self.tileViews[path[i].1][path[i].0].alpha = 1.0
                    self.tileViews[path[i].1][path[i].0].backgroundColor = UIColor(red: CGFloat(Float.random(in: 0.19 ..< 0.29)), green: CGFloat(Float.random(in: 0.40 ..< 0.50)), blue: CGFloat(Float.random(in: 0.72 ..< 0.82)), alpha: 1.0)
                })
                
            } else {
            
                let dx = path[i].0 - path[i - 1].0
                let dy = path[i].1 - path[i - 1].1
                
                UIView.animate(withDuration: 0.125, delay: 0.25 * Double(i), options: .curveEaseOut, animations: {
                    self.tileViews[path[i].1][path[i].0].alpha = 1.0
                    self.tileViews[path[i].1][path[i].0].backgroundColor = UIColor(red: CGFloat(Float.random(in: 0.19 ..< 0.29)), green: CGFloat(Float.random(in: 0.40 ..< 0.50)), blue: CGFloat(Float.random(in: 0.72 ..< 0.82)), alpha: 1.0)
                })
                
                UIView.animate(withDuration: 0.25, delay: 0.25 * Double(i), options: .curveEaseOut, animations: {
                    self.duck.frame = self.duck.frame.offsetBy(dx: CGFloat(40.0 * Double(dx)), dy: CGFloat(40.0 * Double(dy)))
                })
                
            }
            
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}
