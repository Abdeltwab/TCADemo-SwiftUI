 # General Information
 
 - Minimum  Deployment target : `iOS 14` 
 - iOS   target : `iOS 15` 
 - UI FrameWork :  `SWIFTUI`
 - Design architecture : `TCA`+ `Combine`
 - Dependencies : 

	 -  https://github.com/pointfreeco/swift-composable-architecture
	 - https://github.com/siteline/SwiftUI-Introspect.git
	 -  https://github.com/himbeles/LocationProvider.git


# Installation

 - clone the app, or download the from  Drive 
 - resolve package versions
 - run the app on a simulator or phone
 - give app location permission   to be able to see the distance between you and jobs (`choose always allow location while using the app)` 
 - you may need to restart the app after giving location permission
	 
  ## Installation TroubleShooting 
  
 - if all jobs distanc show 12.km this means app did not get your location try : 
	 - Restart the app
	 - select `always allow while using app` on location pop  
	 - Restart the app again , then enjoy 


 - if packages not resolved try the following 
	 
	 
	 -  `File -> Packages -> Reset Package cache`
	 -  `File -> Packages -> resolve Package versions`
	 - if still not building, try to remove the Reference of  `ServiceFrameWork ` and its container `Packages ` 
	 - re-add `ServiceFrameWork` again
	 - make sure to link it to the main target by selecting  `Target - > under General tab -> Frameworks , Libraries and Embedded Content -> plus icon`
   
   
   
   
