## R CMD check results
This submission updates version 1.0.1, which was archived due to internet access during R CMD check. In this version, all internet-dependent workflows (e.g. WoRMS/geodata maps/Bo-Oracle layers) have been removed from examples and tests or wrapped in \\dontrun{} or guarded so that no internet access occurs during CRAN checks. The package now passes R CMD check without internet use. Metadata issues noted in the archived version have also been corrected.


checking for future file timestamps ... NOTE
0 errors | 0 warnings | 1 note

 
