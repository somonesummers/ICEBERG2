This package is a current work in progress extending the ICEBERG package for MITgcm which can be found here ( Davison 2020, https://zenodo.org/records/3979647)
Key additions in this package:
  - Addition of iceberg physical blocking based on parameterizations from Hughes 2022 (https://doi.org/10.1029/2021JC018228)
  including new diagnostic fields for iceberg drag in X and Y directions.
  - Acceleration of the thermodynamics code and streamlining of configuation files (all berg geometries now in 3 binary files)
  - Addition of diagnostic for Iceberg surface area
  - New check of global configuration files to ensure hFac values are not reset
  - Iceberg melting can now be controlled with a mask as a runtime parameter

This work is still a work in progress, and will be moved to a zenodo DOI repository once finalized.
Any questions can be directed to Paul Summers (paul.summers@rutgers.edu) 

Main development was run on MITgcm checkpoint 68z, last run for compatibility on checkpoint69c, last tested Jan 27 2025. 

Installation is similar to any non-standard MITgcm package
  - Copy '/pkg/iceberg' directory and contents into the 'MITgcm/pkg' directory
  - Copy files in 'code' to the code folder of your local experiment directory (recommended), or overwrite the version in the existing 'MITgcm/pkg' or 'MITgcm/src' directories of your main MITgcm folder (be careful with this option)
  - Use 'pythonMakeBergs.py' to generate files needed in the 'input' directory.
  - Use the data.iceberg file in the 'input' directory of your experiment directory

Recommended structure:

        MITgcm
        |--experiment
           |--build
           |--code
               | _copy contents of code directory here._
           |--input
               | _copy contents of input directory here, execute 'pythonMakeBergs.py' here.
                  *MUST* update domain size in this script to agree with your model domain._
           |--results
        |--pkg
           | _copy entire 'iceberg' directory here._ 
