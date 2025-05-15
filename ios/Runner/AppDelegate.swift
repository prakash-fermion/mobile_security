import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    
    let controller = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "com.fermion.mobilesecurity/channel", binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler { call, result in
    if call.method == "isDebuggerAttached" {
      result(isDebuggerAttached())
    } else {
      result(FlutterMethodNotImplemented)
    }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

func isDebuggerAttached() -> Bool {
    var info = kinfo_proc()
    var size = MemoryLayout<kinfo_proc>.stride
    var name: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]

    let result = sysctl(&name, u_int(name.count), &info, &size, nil, 0)
      
    return (info.kp_proc.p_flag & P_TRACED) != 0
}
