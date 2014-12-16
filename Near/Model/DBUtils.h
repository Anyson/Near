//
//  DBUtils.h
//  Random10X
//
//  Created by Anyson Chan on 14/11/14.
//  Copyright (c) 2014年 Sachsen. All rights reserved.
//

@import CoreData;
#import <Foundation/Foundation.h>

@interface DBUtils : NSObject

+ (void)createDBUtilsQueue;
+ (dispatch_queue_t)getDbUtilsQueue;
+ (DBUtils*) createWithName:(NSString *)name withMomd:(NSString *)momdName;
+ (void)resetDBUtils;

- (id)initWithName:(NSString *)name withMomd:(NSString *)momdName;

- (NSManagedObject *)insertNewObjectForEntityForName:(NSString *)entityName;

- (NSArray *)queryWithEntityName:(NSString *)entityName predicateFormat:(NSPredicate *)predicateFormat sortDescriptor:(NSArray *)sortDescriptorArray fetchLimit:(NSInteger)fetchLimit;

- (BOOL)deleteObjects:(NSArray *)objects;
- (BOOL)save;

@end
