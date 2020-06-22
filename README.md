## HoleFilling Algorithm

### Complexity O(n*m)
Since for each point n we loop through all boundary m to calculate the color intensity, the complexity O(n*m). 
But expressing it in terms of n leads to  O(n*sqrt(n)). Since the bigger is n value the more m approximates to sqrt(n).


### Complexity O(n)
In order to approximate to O(n) instead of running over all m boundary for each n hole, just run the calculation b  constant times.
 Where T is a defined constant representing the number of boundary pixels that should be used to calculate pixel color.
1. Start first to fill the pixels that have as neighbours b boundary points.
2. Next fill the holes that have neighbours holes calculated from the previous step, use b neighbours of current pixels.

 Using this algorithm leads to O(n*b) since constants are omitted it equals to O(n).
