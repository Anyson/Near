//
//  DBUtils.m
//  Random10X
//
//  Created by Anyson Chan on 14/11/14.
//  Copyright (c) 2014年 Sachsen. All rights reserved.
//

#import "DBUtils.h"

static DBUtils* _DB;
static dispatch_queue_t db_utils_queue;

@interface DBUtils() {
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    
    NSString* _name;
    NSString* _momdName;
}

@end

@implementation DBUtils

+ (void)createDBUtilsQueue {
    if (!db_utils_queue) {
        db_utils_queue = dispatch_queue_create("db_utils_queue", DISPATCH_QUEUE_SERIAL);
    }
}

+ (dispatch_queue_t)getDbUtilsQueue {
    [self createDBUtilsQueue];
    return db_utils_queue;
}

+ (DBUtils*) createWithName:(NSString *)name withMomd:(NSString *)momdName {

    @synchronized(_DB) {
        if (!_DB) {
            _DB = [[DBUtils alloc] initWithName:name
                                       withMomd:momdName];
        }
    };
    return _DB;
}

+ (void)resetDBUtils {
    @synchronized(_DB) {
        if (_DB) {
            _DB = nil;
        }
    }
}


- (id)initWithName:(NSString *)name withMomd:(NSString *)momdName {
    self = [super init];
    
    if (self) {
        _name = name;
        _momdName = momdName;
        [self managedObjectContext];
    }
    
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:_momdName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
//    if (![Utilities getCurrentUserId]) {
//        return nil;
//    }
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
//    NSLog_DEBUG(@"persistentStoreCoordinator : %@", [Utilities getCurrentUserId]);
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:_name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:storeURL.absoluteString]) {
        Boolean ret = [fileManager createDirectoryAtURL:storeURL withIntermediateDirectories:YES attributes:nil error:nil];
        if (!ret) {
            NSLog(@"create user directory fail");
            return nil;
            
        } else {
            storeURL = [storeURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", _momdName]];
            NSLog(@"user directory: %@",storeURL);
        }
    }
    
    NSError *error = nil;
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,NSInferMappingModelAutomaticallyOption: @YES};
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



- (NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName {
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext];
}

- (NSArray *)queryWithEntityName:(NSString *)entityName predicateFormat:(NSPredicate *)predicateFormat sortDescriptor:(NSArray *)sortDescriptorArray fetchLimit:(NSInteger)fetchLimit {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:predicateFormat];
    [fetchRequest setSortDescriptors:sortDescriptorArray];
    
    if (fetchLimit > 0) {
        [fetchRequest setFetchLimit:fetchLimit];
    }
    
    NSError *error;
    NSArray *fetchArray = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return fetchArray;
}

- (BOOL)save {
    if ([_managedObjectContext hasChanges])
    {
        NSError* error = nil;
        if (![_managedObjectContext save:&error])
        {
            NSLog(@"save Object error %@, %@", error, [error userInfo]);
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)deleteObjects:(NSArray *)objects {
    for (id obj in objects) {
        [_managedObjectContext deleteObject:obj];
    }
    
    return [self save];
}

@end
