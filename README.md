## EventBusSwift

The idea come from https://github.com/greenrobot/EventBus in Android.

## Requirements

- iOS 8.0+ / Mac OS X 10.10+ / watchOS 2.0+ / tvOS 9.0+
- Swift 3
  - Xcode 8.0+

## Installation

### CocoaPods

To install EventBusSwift with CocoaPods, add the following lines to your `Podfile`.

#### Swift 3.0.x

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0' # or platform :osx, '10.10' if your target is OS X.
use_frameworks!

pod 'EventBusSwift'
```

Then run `pod install` command. For details of the installation and usage of CocoaPods, visit [its official website](https://cocoapods.org).

## Documentation

1. Define Notification Name:

    ```swift  
    extension Notification.Name {
    
        public static let Message = Notification.Name("Message")
    
    }
    ```

2. Register and unregister your subscriber. For example on iOS, UIViewController should usually register according to their life cycle:

   ```swift
    func onViewWillAppear(_ animated: Bool) {
        super.onViewWillAppear(animated)
        EvenBus.shared.register(self, name: .Message) { [weak self] (object) in
            guard let _ = self else { return }
            
            if let text = object as? String {
                print(text)
            }
        }
    }
    
    func onViewWillDisappear(_ animated: Bool) {
        super.onViewWillDisappear(animated)
        EvenBus.shared.unregister(self, name: .Message)
    }
    ```

3. Post events:

    ```swift
    EvenBus.shared.post(name: .Message, object: "Hello EventBus")
    ```
