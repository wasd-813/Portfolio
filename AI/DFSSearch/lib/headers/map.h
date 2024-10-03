#include <vector>
#include <tuple>

#ifndef MAP_H
#define MAP_H

using namespace std;

typedef vector<vector<int> > Map;
typedef tuple<int, int> Coordinate;

/*  A Map in a mxn 2d Vectors
*   if [i][j] :=
*       -1 -> out of range
*       0 -> empty
*       1 -> wall
*       2 -> target
*       3 -> searched
*/

Map BuildMap(int, int);
void PrintMap(Map);
void AddStart(Map *);
void AddWalls(Map *);
void AddTarget(Map *);
Coordinate GetEmptySpace(Map);
int GetCoordinateValue(Coordinate, Map *);
void SetCoordinateValue(Coordinate, Map *, int);

#endif