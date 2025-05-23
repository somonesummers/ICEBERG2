C $Header: /u/gcmpack/MITgcm/model/src/packages_init_variables.F,v 1.95 2014/07/30 03:31:35 jmc Exp $
C $Name:  $

#include "PACKAGES_CONFIG.h"
#include "CPP_OPTIONS.h"
#ifdef ALLOW_AUTODIFF
# include "AUTODIFF_OPTIONS.h"
#endif
#ifdef ALLOW_CTRL
# include "CTRL_OPTIONS.h"
#endif

CBOP
C     !ROUTINE: PACKAGES_INIT_VARIABLES
C     !INTERFACE:
      SUBROUTINE PACKAGES_INIT_VARIABLES( myThid )

C     !DESCRIPTION: \bv
C     *==========================================================*
C     | SUBROUTINE PACKAGES_INIT_VARIABLES
C     | o Does initialisation of package-related variable data
C     *==========================================================*
C     \ev

C     !CALLING SEQUENCE:
C     PACKAGES_INIT_VARIABLES
C       |
C       |-- DIAGNOSTICS_INIT_VARIA
C       |
C       |-- OFFLINE_INIT_VARIA
C       |
C       |-- GAD_INIT_VARIA
C       |
C       |-- CD_CODE_INI_VARS
C       |
C       |-- PP81_INIT_VARIA
C       |
C       |-- KL10_INIT_VARIA
C       |
C       |-- MY82_INIT_VARIA
C       |
C       |-- GGL90_INIT_VARIA
C       |
C       |-- KPP_INIT_VARIA
C       |
C       |-- GMREDI_INIT_VARIA
C       |
C       |-- BBL_INIT_VARIA
C       |
C       |-- DWNSLP_INIT_VARIA
C       |
C       |-- EXF_INIT
C       |
C       |-- BULKF_INIT_VARIA
C       |
C       |-- EBM_INI_VARS
C       |
C       |-- CHEAPAML_INIT_VARIA
C       |
C       |-- SMOOTH_INIT_VARIA
C       |
C       |-- PROFILES_INIT_VARIA
C       |
C       |-- FLT_INIT_VARIA
C       |
C       |-- PTRACERS_INIT_VARIA
C       |
C       |-- LONGSTEP_INIT_VARIA
C       |
C       |-- GCHEM_INIT_VARI
C       |
C       |-- RBCS_INIT_VARIA
C       |
C       |-- MATRIX_INIT_VARIA
C       |
C       |-- FRAZIL_INIT_VARIA
C       |
C       |-- SEAICE_INIT_VARIA
C       |
C       |-- SALT_PLUME_INIT_VARIA
C       |
C       |-- SHELFICE_INIT_VARIA
C       |
C       |-- STREAMICE_INIT_VARIA
C       |
C       |-- ICEFRONT_INIT_VARIA
C       |
C       |-- THSICE_INI_VARS
C       |
C       |-- LAND_INI_VARS
C       |
C       |-- ATM2D_INIT_VARS
C       |
C       |-- ATM_PHYS_INIT_VARIA
C       |
C       |-- FIZHI_INI_VARS
C       |
C       |-- REGRID_INIT_VARIA
C       |
C       |-- LAYERS_INIT_VARIA
C       |
C       |-- NEST_CHILD_INIT_VARIA
C       |-- NEST_PARENT_INIT_VARIA
C       |
C       |-- CPL_INI_VARS
C       |
C       |-- MYPACKAGE_INIT_VARIA
C       |
C       |-- CTRL_INIT_VARIABLES
C       |-- CTRL_MAP_INI_ECCO
C       |-- CTRL_MAP_INI
C       |
C       |-- OBCS_INIT_VARIABLES

C     !USES:
      IMPLICIT NONE
C     === Global variables ===
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#ifdef ALLOW_AUTODIFF
# include "DYNVARS.h"
# include "tamc.h"
# include "tamc_keys.h"
#endif

C     !INPUT/OUTPUT PARAMETERS:
C     === Routine arguments ===
C     myThid  :: my Thread Id number
      INTEGER myThid
CEOP

#ifdef ALLOW_DEBUG
      IF (debugMode)
     &     CALL DEBUG_ENTER('PACKAGES_INIT_VARIABLES',myThid)
#endif /* ALLOW_DEBUG */

#ifdef ALLOW_DIAGNOSTICS
      IF ( useDiagnostics ) THEN
        CALL DIAGNOSTICS_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_DIAGNOSTICS */

#ifdef ALLOW_OFFLINE
C--   Here we call OFFLINE_INIT_VARIA (which calls OFFLINE_FIELDS_LOAD)
C     before other {PKG}_init_varia, closer to where main pickup-file
C     are usually read-in (but skipped when using pkg/offline)
# ifndef ALLOW_AUTODIFF
      IF ( useOFFLINE ) THEN
# endif
        CALL OFFLINE_INIT_VARIA( myThid )
# ifndef ALLOW_AUTODIFF
      ENDIF
# endif
#endif /* ALLOW_OFFLINE */

#ifdef ALLOW_GENERIC_ADVDIFF
      IF ( useGAD ) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('GAD_INIT_VARIA',myThid)
# endif
        CALL GAD_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_GENERIC_ADVDIFF */

#ifdef ALLOW_CD_CODE
C--   Initialize CD_CODE variables:
C- note(jmc): before packaging CD_CODE, was done within ini_fields (=called before),
C             therefore call CD-ini-vars before others pkg.
      IF (useCDscheme) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('CD_CODE_INI_VARS',myThid)
# endif
        CALL CD_CODE_INI_VARS( myThid )
      ENDIF
#endif /* ALLOW_CD_CODE */

#ifdef ALLOW_PP81
C--   Initialize PP81 vertical mixing scheme.
      IF (usePP81) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('PP81_INIT_VARIA',myThid)
# endif
       CALL PP81_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_PP81 */

#ifdef ALLOW_KL10
C--   Initialize KL10 vertical mixing scheme.
      IF (useKL10) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('KL10_INIT_VARIA',myThid)
# endif
       CALL KL10_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_KL10 */

#ifdef ALLOW_MY82
C--   Initialize MY82 vertical mixing scheme.
      IF (useMY82) THEN
       CALL MY82_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_MY82 */

#ifdef ALLOW_GGL90
C--   Initialize GGL90 vertical mixing scheme.
      IF (useGGL90) THEN
#ifdef ALLOW_DEBUG
      IF (debugMode) CALL DEBUG_CALL('GGL90_INIT_VARIA',myThid)
#endif
       CALL GGL90_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_GGL90 */

#ifdef ALLOW_KPP
C--   Initialize KPP vertical mixing scheme.
      IF (useKPP) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('KPP_INIT_VARIA',myThid)
# endif
       CALL KPP_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_KPP */

#ifdef ALLOW_GMREDI
C--   Initialize GM/Redi parameterization
      IF (useGMRedi) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('GMREDI_INIT_VARIA',myThid)
# endif
        CALL GMREDI_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_GMREDI */

#ifdef ALLOW_BBL
      IF ( useBBL ) THEN
        CALL BBL_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_BBL */

#ifdef ALLOW_DOWN_SLOPE
      IF ( useDOWN_SLOPE ) THEN
        CALL DWNSLP_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_DOWN_SLOPE */

#ifdef ALLOW_EXF
      IF (useEXF) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('EXF_INIT',myThid)
# endif
       CALL EXF_INIT( myThid )
      ENDIF
#endif /* ALLOW_EXF */

#ifdef ALLOW_BULK_FORCE
      IF (useBulkForce) THEN
        CALL BULKF_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_BULK_FORCE */

#ifdef ALLOW_EBM
# ifdef ALLOW_AUTODIFF_TAMC
CADJ STORE theta = tapelev_init, key = 1
# endif
      IF (useEBM) THEN
        CALL EBM_INI_VARS( myThid )
      ENDIF
#endif /* ALLOW_EBM */

#ifdef ALLOW_CHEAPAML
      IF (useCheapAML) THEN
        CALL CHEAPAML_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_CHEAPAML */

#ifdef ALLOW_SMOOTH
      CALL SMOOTH_INIT_VARIA(myThid)
#endif /* ALLOW_SMOOTH */

#ifdef ALLOW_PROFILES
C--   Initialise Profiles cost function.
      IF (usePROFILES) THEN
        CALL PROFILES_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_PROFILES */

#ifdef ALLOW_FLT
C--   Initialise float position
      IF ( useFLT ) THEN
        CALL FLT_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_FLT */

#ifdef ALLOW_PTRACERS
# ifndef ALLOW_AUTODIFF
      IF ( usePTRACERS ) THEN
# endif
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('PTRACERS_INIT_VARIA',myThid)
# endif
        CALL PTRACERS_INIT_VARIA( myThid )
# ifdef ALLOW_LONGSTEP
#  ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('LONGSTEP_INIT_VARIA',myThid)
#  endif
        CALL LONGSTEP_INIT_VARIA( myThid )
# endif /* ALLOW_LONGSTEP */
# ifndef ALLOW_AUTODIFF
      ENDIF
# endif
#endif /* ALLOW_PTRACERS */

#ifdef ALLOW_GCHEM
      IF (useGCHEM) THEN
        CALL GCHEM_INIT_VARI( myThid )
      ENDIF
#endif /* ALLOW_GCHEM */

#ifdef ALLOW_RBCS
      IF ( useRBCS ) THEN
        CALL RBCS_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_RBCS */

#ifdef ALLOW_MATRIX
      IF ( useMATRIX ) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('MATRIX_INIT',myThid)
# endif
        CALL MATRIX_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_MATRIX */

#ifdef ALLOW_FRAZIL
      IF (useFRAZIL) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('FRAZIL_INIT_VARIA',myThid)
# endif
        CALL FRAZIL_INIT_VARIA( myThid)
      ENDIF
#endif /* ALLOW_FRAZIL */

#ifdef ALLOW_SEAICE
C--   Initialize SEAICE model.
      IF (useSEAICE) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('SEAICE_INIT_VARIA',myThid)
# endif
       CALL SEAICE_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_SEAICE */

#ifdef ALLOW_SALT_PLUME
      IF ( useSALT_PLUME ) THEN
        CALL SALT_PLUME_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_SALT_PLUME */

#ifdef ALLOW_SHELFICE
      IF (useShelfIce) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('SHELFICE_INIT_VARIA',myThid)
# endif
       CALL SHELFICE_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_SHELFICE */

#ifdef ALLOW_STREAMICE
cph      IF (useStreamIce) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('STREAMICE_INIT_VARIA',myThid)
# endif
       CALL STREAMICE_INIT_VARIA( myThid )
cph      ENDIF
#endif /* ALLOW_STREAMICE */

#ifdef ALLOW_ICEFRONT
      IF (useICEFRONT) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('ICEFRONT_INIT_VARIA',myThid)
# endif
       CALL ICEFRONT_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_ICEFRONT */

#ifdef ALLOW_ICEPLUME
      IF (useICEPLUME) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('ICEPLUME_INIT_VARIA',myThid)
# endif
       CALL ICEPLUME_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_ICEPLUME */

#ifdef ALLOW_ICEBERG
      IF (useICEBERG) THEN
# ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('ICEBERG_INIT_VARIA',myThid)
# endif
       CALL ICEBERG_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_ICEBERG */

#ifdef ALLOW_THSICE
      IF (useThSIce) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('THSICE_INI_VARS',myThid)
# endif
        CALL THSICE_INI_VARS( myThid)
      ENDIF
#endif /* ALLOW_THSICE */

#ifdef ALLOW_LAND
      IF ( useLAND ) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('LAND_INI_VARS',myThid)
# endif
        CALL LAND_INI_VARS( myThid )
      ENDIF
#endif /* ALLOW_LAND */

#ifdef ALLOW_ATM2D
      IF (useAtm2d) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('ATM2D_INIT_VARS',myThid)
# endif
        CALL ATM2D_INIT_VARS( myThid )
      ENDIF
#endif /* ALLOW_ATM2D */

#ifdef ALLOW_ATM_PHYS
      IF (useAtm_Phys) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('ATM_PHYS_INIT_VARIA',myThid)
# endif
        CALL ATM_PHYS_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_ATM_PHYS */

#ifdef ALLOW_FIZHI
C Initialize FIZHI state variables
      IF (useFIZHI) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('FIZHI_INIT_VARS',myThid)
# endif
        CALL FIZHI_INIT_VARS( myThid )
      ENDIF
#endif /* ALLOW_FIZHI */

#ifdef ALLOW_REGRID
      IF ( useREGRID ) THEN
        CALL REGRID_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_REGRID */

#ifdef ALLOW_LAYERS
      IF ( useLayers ) THEN
        CALL LAYERS_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_LAYERS */

#ifdef ALLOW_NEST_CHILD
C--   Initialize NEST in CHILD configuration
      IF (useNEST_CHILD) THEN
#ifdef ALLOW_DEBUG
       IF (debugMode)
     &       CALL DEBUG_CALL('NEST_CHILD_INIT_VARIA',myThid)
#endif
       CALL NEST_CHILD_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_NEST_CHILD */

#ifdef ALLOW_NEST_PARENT
C--   Initialize NEST in PARENT configuration
      IF (useNEST_PARENT) THEN
#ifdef ALLOW_DEBUG
       IF (debugMode)
     &       CALL DEBUG_CALL('NEST_PARENT_INIT',myThid)
#endif
       CALL NEST_PARENT_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_NEST_PARENT */

#ifdef COMPONENT_MODULE
      IF (useCoupler) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('CPL_INI_VARS',myThid)
# endif
        CALL CPL_INI_VARS( myThid )
      ENDIF
#endif /* COMPONENT_MODULE */

#ifdef ALLOW_MYPACKAGE
      IF ( useMYPACKAGE ) THEN
        CALL MYPACKAGE_INIT_VARIA( myThid )
      ENDIF
#endif /* ALLOW_MYPACKAGE */

#ifdef ALLOW_AUTODIFF_TAMC
CADJ STORE theta  = tapelev_init, key = 1
CADJ STORE salt   = tapelev_init, key = 1
# ifdef ALLOW_DIFFKR_CONTROL
CADJ STORE diffkr = tapelev_init, key = 1
# endif
#endif /* ALLOW_AUTODIFF_TAMC */

#ifdef ALLOW_AUTODIFF
C--   Initialise auxiliary xx_ fields
      IF (debugMode) CALL DEBUG_CALL('CTRL_INIT_VARIABLES',myThid)
      CALL CTRL_INIT_VARIABLES ( myThid )
C--   Map the control variables onto the model state.
C-    Needs to be called after few {PKG}_init_varia (e.g., PTRACERS_INIT_VARIA)
# ifdef ALLOW_ECCO
      IF (debugMode) CALL DEBUG_CALL('CTRL_MAP_INI_ECCO',myThid)
      CALL CTRL_MAP_INI_ECCO( myThid )
# else
      IF (debugMode) CALL DEBUG_CALL('CTRL_MAP_INI',myThid)
      CALL CTRL_MAP_INI( myThid )
# endif
#endif /* ALLOW_AUTODIFF */

#ifdef ALLOW_OBCS
C--   put this call in last position (needs to come after few {PKG}_init_varia)
      IF (useOBCS) THEN
# ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('OBCS_INIT_VARIABLES',myThid)
# endif
        CALL OBCS_INIT_VARIABLES( myThid )
      ENDIF
#endif /* ALLOW_OBCS */

#ifdef ALLOW_DEBUG
      IF (debugMode)
     &     CALL DEBUG_LEAVE('PACKAGES_INIT_VARIABLES',myThid)
#endif /* ALLOW_DEBUG */

      RETURN
      END
