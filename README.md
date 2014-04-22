# Stretchr Cocoa SDK

## Installation

The preferred method of including the Stretchr SDK in your project is through [Cocoapods](http://cocoapods.org/). To install Cocoapods, simply do:

`sudo gem install cocoapods`

Once Cocoapods is installed, you need to add the Stretchr SDK to your Podfile. For example, in your project directory:

`vi Podfile`

and add the following to your Podfile:

```bash
platform :ios , '5.1'
pod 'Stretchr'
```

Now run `pod install` and a new workspace will be created for you with the Stretchr dependency included.


## Usage

Using the SDK is straightforward and simple. It is built around an asynchronous block-based interaction.

The first thing you need to do is initialize the shared singleton Stretchr object and get a reference to the instance:

```obj-c
[Stretchr initializeSharedSDKWithAccount:@"account"
                                 project:@"project"
                                     key:@"a89fgypw5ap98fhgp98aghjap98sfhv"];
Stretchr* stretchr = [Stretchr sharedSDK];
```

Then, to read an item from Stretchr, you could do the following:

```obj-c
STResourceBlock success = ^(STRequest * request, STResource * resource) {
  NSLog(@"Response: %@", resource);
};
STFailureBlock failure =
    ^(STRequest * request, NSInteger status, NSArray * errors) {
  NSLog(@"Failure! Status: %ld, errors: %@", status, errors);
};
[stretchr readResourceAtPath:@"user/tyler"
                       query:nil
                     success:success
                     failure:failure];
```

For comprehensive usage information, please refer to the [documentation generated via Cocoadocs](http://cocoadocs.org/docsets/Stretchr/0.3.0/).

## Upcoming

[Mantle](https://github.com/Mantle/Mantle) support is planned soon. Stretchr will automatically convert Mantle objects to JSON on your behalf, allowing you to easily create your model and persist it to Stetchr. When you get a response, you'll be able to use Mantle methods to create your model object from JSON, also.
