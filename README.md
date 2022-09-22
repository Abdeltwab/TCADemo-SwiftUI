 # General Information
 
 - Project code on Drive + Video of app working : https://drive.google.com/drive/folders/1Stlm5bkvqWdL-LLpe_mWQSWYrK5u0FG5
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
   
# App Structure 

### ServiceFrameWork :  
SDK Networking service, and it has the following sub Folders 
	
 **Shared**: have common helpers for all modules e.g `Client, EndPoint`
 **Modules**: have each module services and stores, for now, it has only `ShiftsListModule`

### Asssement : The App Target 
it has the following structure 

**Utilities**: has all helpers for the projects, like : 
 - **Extention** : has all classes extensions e.g `Date+`
 - **Refreshable** : helper to  support `iOS 15 list  refreshable modifier for iOS 14 
 - **ImageLoader** : image loader class to mimic `iOS 15 AsyncImage` class for iOS 14 
 - **ReusableViews** : has General UI component   e.g `ActionButton , PrimaryButtonView`
 


**Resources**:  Centralized place for all resources that are required by all views.
 - **Styling** : has fonts , colors , spacing 
 - **Images**: has system images, and custom images used  
 - **Localization**: has all strings localized, now it's only English 
 
 **Modules**:  App Scences Modules.
 - **AppModule**: App Parent   module in which dependencies are initialized and injected to child module 
 - **ShiftsListModule**: The only Module for now, has all presentation logic for shiftsList Scene
 
   
   
