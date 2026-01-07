# ios-applovin-mediation
## Enables you to serve Magnite Ads in your iOS application using AppLovin mediation network

### 1. Getting Started

The following instructions assume you are already familiar with the AppLovin MAX SDK and have already integrated the AppLovin MAX iOS SDK into your application. Otherwise, please start by visiting AppLovin site and reading the instructions on how to add AppLovin mediation code into your app.
  * [AppLovin site](https://dash.applovin.com/documentation/mediation)
  * [AppLovin instructions](https://dash.applovin.com/documentation/mediation/ios/getting-started/integration)
  
### 2. Adding Your Application to Your Magnite Developer's Account
1. Login into your [Magnite developer's account](TODO:PROVIDE URL TO PORTAL)
1. Add your application and get its App ID

### 3. Integrating the Magnite <-> AppLovin Mediation Adapter
The easiest way is to use CocoaPods, just add to your Podfile the dependency
```
pod 'magnite-applovin-mediation'
```

### 4. Adding a Custom Event
1. Login into your [AppLovin account](https://dash.applovin.com/)
1. On the left menu expand "MAX->Mediation->Networks"
1. Scroll down and select "Click here to add a Custom Network"
1. On a Manage Network page select SDK as Network Type
1. Set Custom Network Name to "Magnite"
1. Set iOS Adapter Class Name to "MagniteAppLovinAdapter"
1. Tap Save
1. Start creating your Ad Units. Now in the Ad Unit waterfall you should see "Custom Network (SDK) - Magnite" under "Custom Networks & Deals" section. Expand it
1. Change Status to enabled
1. IMPORTANT! Set your Magnite AppID in corresponding field
1. You may also pass custom parameters in JSON format. Supported names and values you may find in adapter's MagniteAppLovinExtras.m

#### If you need additional assistance you can take a look on our app example which works with this mediation adapter
