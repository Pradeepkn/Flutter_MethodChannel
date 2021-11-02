import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let stepsChannel = FlutterMethodChannel(name: "samples.flutter.dev/crossplatform",
                                                binaryMessenger: controller.binaryMessenger)
        stepsChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // Note: this method is invoked on the UI thread.
          guard call.method == "getStepsCount" else {
            result(FlutterMethodNotImplemented)
            return
          }
          self?.receiveNumberOfSteps(result: result)
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func receiveNumberOfSteps(result: FlutterResult) {
        result(100)
    }
}
