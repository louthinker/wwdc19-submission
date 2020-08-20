/*:
 # Implementing a Pathfinding Algorithm
 ### Finding the shortest path in a tile-based map
 - - -
 I'm Luis, the creator of this playground. One of my hobbies is developing videogames, and it had been a while since I wanted to learn a pathfinding algorithm to use in my own creations. Thanks to the WWDC19 scholarship application, I could do that while preparing my submission!
 
 The implemented algorithm works like this:
 - A list is initialized with the end coordinate of the map (which is random), and a counter variable starting at 0 is attached to it
 - For each element in the list, the following is done:
    1. A list with the four adjacent tiles of the element is created, with a counter variable attached whose value is the element's counter variable value plus 1
    2. All tiles in this list are checked for the following two conditions
        - If the tile is a wall, it's removed from the list
        - If there's an element in the main list with the same coordinate and a lesser or equal counter, it's removed from the list
    3. All remaining tiles in the list are added to the end of the main list
    4. Proceed to the next tile in the list
 - Finally, when all the tiles in the list have been processed, a path is created from the start coordinate to the end coordinate, always going from the current tile to the nearby tile with the lowest counter.
 
 The algorithm was obtained from _https://en.wikipedia.org/wiki/Pathfinding#Sample_algorithm_
 - - -
 Press the Play button every time you want to generate a new map, and the pathfinding algorithm will calculate the shortest path from the start to the end coordinate (which then a little duck will try out!).
 
 **I hope you like it!**
 */
import UIKit
import PlaygroundSupport

// Create a 10x10 grid (map)
let grid = Grid()

// Initialize a view based on the created grid,
// whose shortest path will be automatically
// calculated and animated
let view = GridView(grid: grid)

// Show the view in the Playground live view
PlaygroundPage.current.liveView = view
