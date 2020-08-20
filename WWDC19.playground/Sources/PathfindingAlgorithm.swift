
/* Class: PathfindingAlgorithm */
/* Finds the shortest path in a tile-based map. */

public class PathfindingAlgorithm {
    
    public init() {}
    
    public func findShortestPath(map: Grid) -> [(Int, Int)] {
        
        // List of coordinates
        var list: [(tile: (x: Int, y: Int), counter: Int)] = []
        list.append((tile: map.endCoordinate, counter: 0))
        
        var i = 0
        while !list.contains(where: { $0.tile == map.startCoordinate }) {
            
            let currentTile = list[i]
            
            // List of the current tile's four adjacent tiles
            var adjacentTiles: [(tile: (x: Int, y: Int), counter: Int)] = []
            for coordinate in [(-1, 0), (0, -1), (0, 1), (1, 0)] {
                
                let x = currentTile.tile.x + coordinate.0
                let y = currentTile.tile.y + coordinate.1
                
                if x >= 0 && x < map.width && y >= 0 && y < map.height {
                    adjacentTiles.append((tile: (x: x, y: y), counter: currentTile.counter + 1))
                }
                
            }
            
            var adjacentTilesAfterRemoval: [(tile: (x: Int, y: Int), counter: Int)] = []
            
            // Check conditions
            for tile in adjacentTiles {
                
                // Tile isn't a wall
                if !map.walls.contains(where: { $0 == tile.tile }) {
                    
                    // Tile doesn't exist with a lower counter in the main list
                    if !list.contains(where: { $0.tile == tile.tile && $0.counter <= tile.counter }) {
                        adjacentTilesAfterRemoval.append(tile)
                    }
                    
                }
                
            }
            
            list.append(contentsOf: adjacentTilesAfterRemoval)
            i += 1
            
        }
        
        var currentTile = map.startCoordinate
        var path: [(x: Int, y: Int)] = [currentTile]
        while currentTile != map.endCoordinate {
            var nextTile: (tile: (x: Int, y: Int), counter: Int) = ((-1, -1), -1)
            for coordinate in [(-1, 0), (0, -1), (0, 1), (1, 0)] {
                
                let x = currentTile.x + coordinate.0
                let y = currentTile.y + coordinate.1
                
                for tile in list {
                    if tile.tile.x == x && tile.tile.y == y && (nextTile.counter < 0 || nextTile.counter > tile.counter) {
                        nextTile = tile
                        break
                    }
                }
                
            }
            currentTile = nextTile.tile
            path.append(currentTile)
        }
        
        return path
        
    }
    
}
