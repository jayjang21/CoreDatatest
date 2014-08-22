//
//  CoreDatatestAppDelegate.h
//  CoreDatatest
//
//  Created by Jay Jang on 14. 8. 22..
//  Copyright (c) 2014년 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDatatestAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
