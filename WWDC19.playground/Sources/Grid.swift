
/* Class: Grid */
/* Sets of open tiles and walls. */

public class Grid {
    
    public let width: Int
    public let height: Int
    public var startCoordinate: (x: Int, y: Int)
    public var endCoordinate: (x: Int, y: Int)
    public var walls: [(Int, Int)]
    
    public convenience init() {
        self.init(width: 10, height: 10)
    }
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
        startCoordinate = (x: 0, y: 0)
        endCoordinate = (x: 0, y: 0)
        walls = []
        initialize()
    }
    
    public func initialize() {
        
        // It's necessary to ensure there's at least one way the
        // finish tile can be reached from the start tile
        startCoordinate = (x: 0, y: Int.random(in: 0 ..< height))
        var path: [(Int, Int)] = [startCoordinate]
        var currentTile = startCoordinate
        
        var previousDirection = -1
        while currentTile.x != width - 1 {
            
            // 0: up  1: down  2: right
            var direction = Int.random(in: 0 ... 2)
            while (
                
                // Only go one direction before going to the right
                (direction == 0 && previousDirection == 1) ||
                (direction == 1 && previousDirection == 0) ||
                
                // Stay inside the grid
                (direction == 0 && currentTile.y == 0) ||
                (direction == 1 && currentTile.y == height - 1)
            
            ) {
                direction = Int.random(in: 0 ... 5)
            }
            
            for _ in 0 ..< Int.random(in: 2 ... 4) {
                switch (direction) {
                case 0:
                    currentTile.y -= 1
                    break
                case 1:
                    currentTile.y += 1
                    break
                case 2:
                    currentTile.x += 1
                    break
                default: break
                }
                if currentTile.x > width - 1 {
                    currentTile.x = width - 1
                }
                if currentTile.y < 0 {
                    currentTile.y = 0
                }
                if currentTile.y > height - 1 {
                    currentTile.y = height - 1
                }
                if (!path.contains(where: { $0 == currentTile })) {
                    path.append(currentTile)
                }
            }
            
            previousDirection = direction
            
        }
        
        endCoordinate = (x: width - 1, y: Int.random(in: 0 ..< height))
        for y in min(currentTile.y, endCoordinate.y) ... max(currentTile.y, endCoordinate.y) {
            path.append((x: currentTile.x, y: y))
        }
        
        // Generate random walls (sets of tiles)
        // ((width * height) / 5) -> number of walls
        for _ in 0 ..< (width * height) / 5 {
            
            let numberOfTiles = Int.random(in: 3 ... 5)
            var currentTile = (x: Int.random(in: 0 ..< width), y: Int.random(in: 0 ..< height))
            
            for _ in 0 ..< numberOfTiles {
                
                let coordinate = ["x", "y"].randomElement()!
                let direction = [-1, 1].randomElement()!
                
                switch (coordinate) {
                case "x":
                    currentTile.x += direction
                    break
                case "y":
                    currentTile.x += direction
                    break
                default: break
                }
                
                if (
                    
                    // No walls interrupting the path
                    !path.contains(where: { $0 == currentTile }) &&
                        
                        // Wall inside the grid
                        currentTile.x < width && currentTile.y < height &&
                        currentTile.x >= 0 && currentTile.y >= 0
                    
                    ) {
                    walls.append(currentTile)
                }
                
            }
            
        }
        
    }
    
    private func printGrid() {
        for y in 0 ..< height {
            for x in 0 ..< width {
                if x == startCoordinate.x && y == startCoordinate.y {
                    print("S ", separator: "", terminator: "")
                } else if x == endCoordinate.x && y == endCoordinate.y {
                    print("E ", separator: "", terminator: "")
                } else if walls.contains(where: { $0 == (x, y) }) {
                    print("X ", separator: "", terminator: "")
                } else {
                    print("_ ", separator: "", terminator: "")
                }
            }
            print("")
        }
    }
    
}
