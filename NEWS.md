# EcoCleanR 1.0.2

-This submission updates version 1.0.1, which was archived due to internet access during R CMD check. In this version, all internet-dependent workflows (e.g. WoRMS/geodata maps/Bio-Oracle layers) have been removed from examples and tests or wrapped in \\dontrun{} or guarded so that no internet access occurs during CRAN checks. The package now passes R CMD check without internet use. Metadata issues noted in the archived version have also been corrected.
- Fixed Authors@R metadata and documentation issues.
- Resolved CRAN check warnings related to undocumented objects.
- Added dontrun for the functions has dependency on heavy download file from other resources. e.g. Marine environmental layers and geographic maps.
