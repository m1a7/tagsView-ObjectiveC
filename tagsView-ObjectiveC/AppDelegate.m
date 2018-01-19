//
//  AppDelegate.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 16/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "AppDelegate.h"

#import "SantaCatalinaVC.h" // ViewController
#import "SantaCatalinaVM.h" // ViewController - viewModel


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    

    // Init Controller
    SantaCatalinaVC* vc = [[SantaCatalinaVC alloc] init];
    // Init ViewModel for controller
    vc.vm_TableView = [[SantaCatalinaVM alloc] init];
    
    // Init uinavigationcontroller
    UINavigationController* navContr = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // ui customize for navigationBar
    [navContr.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navContr.navigationBar.shadowImage = [UIImage new];
    navContr.navigationBar.translucent = YES;
    [navContr.navigationBar setBarTintColor:[UIColor blackColor]];
    
    NSDictionary* titleTextAttributesDict = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                              NSFontAttributeName            : [UIFont fontWithName:@"AvenirNext-UltraLight" size:23]};
   
    [navContr.navigationBar setTitleTextAttributes: titleTextAttributesDict];
    
    // Set this vc like root view controller
    [[UIApplication sharedApplication].keyWindow setRootViewController:navContr];

    return YES;
}




@end
