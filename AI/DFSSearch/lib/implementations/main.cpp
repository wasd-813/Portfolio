#include <iostream>
#include <string>
#include "../headers/map.h"
#include <stack>

using namespace std;

bool DFS(Coordinate, Map *);

int main(){
    int m = 15;
    int n = 15;

    Map map = BuildMap(m, n);

    AddStart(&map);
    AddWalls(&map);
    AddTarget(&map);

    PrintMap(map);

    DFS(Coordinate (0, 0), &map);

    return 0;
}

bool DFS(Coordinate location, Map *map){
    SetCoordinateValue(location, map, 3);
    PrintMap(*map);

    // get adjacent coordinates
    vector<Coordinate> adj;
    for(int i = -1; i <= 1; i++){
        for(int j = -1; j <= 1; j++){
            adj.push_back(Coordinate (get<0>(location) + i, get<1>(location) + j));
        }
    }

    // recursively search for goal in each adjacent coordinate
    for(Coordinate coord : adj){
        int val = GetCoordinateValue(coord, map);

        if(val == 2){
            cout << "Found it!" << endl;
            return true;
        }

        if(val == 0)
            if(DFS(coord, map))
                return true;
    }
    return false;
}