//
//  AppDelegate.h
//  TestGame
//
//  Created by Nouman Aslam on 06/07/2021.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) CMMotionManager *motionManager;
@end

