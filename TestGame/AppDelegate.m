//
//  AppDelegate.m
//  TestGame
//
//  Created by Nouman Aslam on 06/07/2021.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize motionManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

- (CMMotionManager *)motionManager
{
    if(!motionManager) motionManager = [[CMMotionManager alloc]init];
    return motionManager;
}

@end
