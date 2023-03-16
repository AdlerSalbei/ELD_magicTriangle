#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * create simple objects that act as a collider for vehicles for a triangle
 *
 * Arguments:
 * 0: Position of corner in format PositionASL <ARRAY>
 * 1: Position of corner in format PositionASL <ARRAY>
 * 2: Position of corner in format PositionASL <ARRAY>
 *
 * Return Value:
 * triangle collider simple objects <ARRAY>
 *
 * Example:
 * [[1991.94,5567.88,6.89202],[1994.63,5571.75,6.89802],[1995.49,5567,6.89769]] call ELD_magicTriangle_scripts_fnc_createTriangleCollider;
 *
 * Public: No
 */




//TODO when reworking this function use setObjectScale to scale the boundingbox according to the largest side of the triangle 


//omg this function is pain



//this procedure sorts the points so the object doesn't get turned inside out


params ["_pos1", "_pos2", "_pos3", ["_texture", 1]];

private _posAVG = ((_pos1) vectorAdd ((_pos2) vectorAdd (_pos3))) vectorMultiply (1/3);



([[_pos1, _pos2, _pos3], [_posAVG], {
	private _diff = _x vectorDiff _input0;
	_diff # 1 atan2 _diff # 0
}, "DESCEND"] call BIS_fnc_sortBy) params ["_pos1", "_pos2", "_pos3"];



/* sides are as follows :
	0: 1-2
	1: 2-3
	2: 3-1
*/
private _longestSide = 0;
private _length0 = _pos1 distance _pos2;
private _length1 = _pos2 distance _pos3;
private _length2 = _pos3 distance _pos1;



/*
			A
			|\
			|°\
			|  \
			| 1 \
			|    \
			P|----->B
			|   °/
			| 2 /
			|  /
			| /
			|/
			C
*/

private _pointA = [];
private _pointB = [];
private _pointC = [];
private _pointP = [];

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

private _vectorAC = _pointC vectorDiff _pointA;

_pointP = _pointA vectoradd (_vectorAC vectorMultiply (((_pointA vectorDiff _pointB) vectorDotProduct _vectorAC)/_vectorAC vectorDotProduct _vectorAC));

private _vectorAP = _pointP vectorDiff _pointA;
private _vectorAB = _pointB vectorDiff _pointA;
private _triangle1Angle = acos (_vectorAB vectorCos _vectorAP);// round down

private _triangle1Scale = vectorMagnitude _vectorAP;

private _vectorBP = _pointP vectorDiff _pointB;
private _vectorBC = _pointC vectorDiff _pointB;
private _triangle2Angle = acos (_vectorBP vectorCos _vectorBC);// round up

private _triangle2Scale = vectorMagnitude _vectorBP;

private _files = addonFiles ["magicTriangle\colliderGen0\", ".p3d"];

private _triangle1Model = [_triangle1Angle, false] call FUNC(getTriangleColliderModel);
private _triangle1Model = [_triangle2Angle, true] call FUNC(getTriangleColliderModel);
