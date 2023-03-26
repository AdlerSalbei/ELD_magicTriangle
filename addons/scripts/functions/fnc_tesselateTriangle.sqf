#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * BROKEN DOES NOT DO ANYTHING, I CANT FIGURE THIS OUT
 * tesselate a triangle into usable triangles with passed maximum side length
 * input is the clockwise corners of a convex polygon 
 *
 * Arguments:
 * 0: Position of corner in format PositionASL <ARRAY>
 * 1: Position of corner in format PositionASL <ARRAY>
 * 2: Position of corner in format PositionASL <ARRAY>
 *
 * Return Value:
 * array of triangles in format <ARRAY> 
 * 		0: Position of corner in format PositionASL <ARRAY>
 * 		1: Position of corner in format PositionASL <ARRAY>
 * 		2: Position of corner in format PositionASL <ARRAY>
 *
 * Example:
 * [[1991.94,5567.88,6.89202],[1994.63,5571.75,6.89802],[1995.49,5567,6.89769]] call ELD_magicTriangle_scripts_fnc_splitTriangle;
 *
 * Public: No
 */


params ["_pos1", "_pos2", "_pos3", ["_size", 24]];






private _longestSide = 0;
private _length0 = _pos1 vectorDistance _pos2;
private _length1 = _pos2 vectorDistance _pos3;
private _length2 = _pos3 vectorDistance _pos1;


private _pointA = [];
private _pointB = [];
private _pointC = [];

if (_length0 >= _length1 && _length0 >= _length2) then {
	//_longestSide = 0;
	_pointA = _pos2;
	_pointC = _pos1;
	_pointB = _pos3;
} else {
	if (_length1 >= _length0 && _length1 >= _length2) then {
		_longestSide = 1;
		_pointA = _pos3;
		_pointC = _pos2;
		_pointB = _pos1;
	} else {
		_longestSide = 2;
		_pointA = _pos1;
		_pointC = _pos3;
		_pointB = _pos2;
	};
};

//AC is longest side

private _vectorAC = _pointC vectorDiff _pointA;
private _vectorAB = _pointB vectorDiff _pointA;
private _vectorCB = _pointB vectorDiff _pointC;
private _factor = ceil ((vectorMagnitude _vectorAC)/ _size);

_result = [];
for "_i" from 0 to (_factor - 1) do { 
	_pA = 
};

