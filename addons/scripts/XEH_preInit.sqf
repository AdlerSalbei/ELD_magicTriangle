#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;



ADDON = true;



GVAR(coveredTrenchList) = [];

functionname = QFUNC(fullyInitTrenchesWithIntersect);
// functionname2 = "asadasfasf";