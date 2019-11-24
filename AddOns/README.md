## Optional AddOns for BastionEPGP
To install any of these addons, drag the folders out of the `BastionEPGP\AddOns\` subfolder and into `_classic_\Interface\AddOns`

 - **BastionEPGP_Export**: If loaded the export functions for Standings, Loot and Log in BastionEPGP will also dump the export in `_classic_\WTF\Account\<your_account>\SavedVariables\BastionEPGP_Export.lua` in CSV and JSON format for parsing by external programs.
 - **BastionEPGP_CEPGP**: Example plugin for registering CEPGP as a price system option instead of the built-in. CEPGP also needs to be present in the AddOns folder but can be disabled. 
   *If using BastionEPGP as your main epgp addon CEPGP shouldn't be allowed to modify officer notes.*
 - **BastionEPGP_EPGP-Classic**: Example plugin for registering EPGP-Classic (uses LibGearPoints-1.2) as a price system option.