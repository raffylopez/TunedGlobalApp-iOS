## TunedGlobal App Client (iOS)
[Github link](https://github.com/raffylopez/TunedGlobalApp-iOS)

UICollectionView-based app displaying music albums via the TunedGlobal API, with in-built image caching and downsampling.

![preview](https://user-images.githubusercontent.com/9276000/122334645-a107e980-cf6c-11eb-8085-bbbd7ff61a9e.png)

### Project Details:
- **Xcode Version:** 12.3
- **Language:** Swift 5.3.2
- **Deployment Target:** iOS 13.0
- **Platform:** Universal (iPhone & iPad)
- **Build Tool / 3rd Party Libraries:** none
### Notes:
- NSCache and app documents sandbox for image caching, after initial load from network.
- Since API-sourced image downloads are on the heftier side, cell images are re-scaled through downsampling, for improved performance and responsiveness. See: [WWDC 2018: Image and Graphics Best Practices](https://developer.apple.com/videos/play/wwdc2018/219/).
- Tested using simulator and physical device.

