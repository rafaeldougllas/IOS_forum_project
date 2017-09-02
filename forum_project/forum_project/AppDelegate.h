//
//  AppDelegate.h
//  forum_project
//
//  Created by Rafael Douglas on 27/08/17.
//  Copyright © 2017 com.rafael.douglas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

