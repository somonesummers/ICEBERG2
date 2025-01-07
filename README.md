This package is n current work in progress extending ICEBERG package for MITgcm which can be found here (https://zenodo.org/records/3979647)
Key additions in this package:
  - Addition of iceberg physical blocking based on parameterizations from Hughes 2022 (https://doi.org/10.1029/2021JC018228)
  including new diagnostic fields for iceberg drag in X and Y directions.
  - Acceleration of the thermodynamics code and streamlining of configuation files (all berg geometries now in 3 binary files)
  - Addition of diagnostic for Iceberg surface area
  - New check of global configuration files to ensure hFac values are not reset
  - Iceberg melting can now be controlled with a mask as a runtime parameter

This work is still a work in progress, and will be moved to a zenodo DOI repository once finalized.
Any questions can be directed to Paul Summers (paul.summers@rutgers.edu) 

Installation is similar to any non-standard MITgcm package
  - Copy 'ICERBERG/pkg' directory contents to a folder called 'ICEBERG' inside the 'MITgcm/pkg' directory
  - Copy files in 'code' to the code folder of your local experiment folder (recommended), or overwrite the version in the existing 'pkg' or 'src' folders of your main MITgcm folder (be careful with this option)
  - Use 'pythonMakeBergs.py' to generate files needed for in the 'input'.
  - Currently the format of data.iceberg is missing, from this directory, I will add soon
