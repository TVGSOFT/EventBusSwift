## EventBusSwift

The idea come from https://github.com/greenrobot/EventBus in Android.

## Requirements

- iOS 8.0+ / Mac OS X 10.10+ / watchOS 2.0+ / tvOS 9.0+
- Swift 3
  - Xcode 8.0+

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
