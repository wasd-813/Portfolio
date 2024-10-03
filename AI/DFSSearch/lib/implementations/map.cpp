#include "../headers/map.h"
#include <iostream>
#include <cstdlib>
#include <ctime>

// returns an mxn map instantiated with 0s
Map BuildMap(int m, int n){
    Map map(m , vector<int> (n));

    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            SetCoordinateValue(Coordinate (i, j), &map, 0);
        }
    }
    
    return map;
}

// print the contents of the map
void PrintMap(Map map){
    for(int i = 0; i < map.size(); i++){
        for(int j = 0; j < map[0].size(); j++){
            cout << map[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;
}

// add a starting pos, (top-left)
void AddStart(Map *map){
    SetCoordinateValue(Coordinate (0, 0), map, 3);
}

// adds a random amount of walls to map based on the map size
void AddWalls(Map *map){
    int numSqs = (*map).size() * (*map)[0].size();

    // get a random number of walls roughly equal to 1/4 of the total number of square
    srand(time(0));
    int range = numSqs / 5;
    int numWalls = rand() % range + (numSqs / 4) - (range / 2);

    // add numWalls walls to the map in random, empty locations
    for(int i = 0; i < numWalls; i++){
        Coordinate coord = GetEmptySpace(*map);
        SetCoordinateValue(coord, map, 1);
    }

    
}

// add a target to find
void AddTarget(Map *map){
    Coordinate coord = GetEmptySpace(*map);
    SetCoordinateValue(coord, map, 2);
}

// helper function to find a random empty space on the map
Coordinate GetEmptySpace(Map map){
    // get a random location on the map that is not currently filled
    int x, y;
    do{
        x = rand() % map[0].size();
        y = rand() % map.size();
    }
    while(map[x][y] != 0);

    return Coordinate (x, y);
}

// set the value of the Map to a value at a coordinate
void SetCoordinateValue(Coordinate coord, Map *map, int value){
    int x = get<0>(coord);
    int y = get<1>(coord);

    if(x < 0 || x >= (*map)[0].size() || y < 0 || y >= (*map).size())
        return;

    (*map)[x][y] = value;
}

// given a coordinate, return the value of the map at that location
int GetCoordinateValue(Coordinate coord, Map *map){
    int x = get<0>(coord);
    int y = get<1>(coord);

    if(x < 0 || x >= (*map)[0].size() || y < 0 || y >= (*map).size())
        return -1;

    return (*map)[x][y];
}