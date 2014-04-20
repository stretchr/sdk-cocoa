# Stretchr Cocoa SDK

## Installation

*The below instructions do not yet function while the rewrite is in progress.*

The preferred method of including the Stretchr SDK in your project is through [Cocoapods](http://cocoapods.org/). To install Cocoapods, simply do:

`sudo gem install cocoapods`

Once Cocoapods is installed, you need to add the Stretchr SDK to your Podfile. For example, in your project directory:

`edit Podfile`

and add the following to your Podfile:

```bash
platform :ios , '5.1'
pod 'Stretchr'
```

Now run `pod install` and a new workspace will be created for you with the Stretchr dependency included.


