//
//  DBManager.m
//  TextCoreData
//
//  Created by ADC on 14-12-15.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

#import "DBManager.h"
#import "DBUtils.h"
#import "UserInfo.h"
#import "FriendInfo.h"
#import "MessageInfo.h"

#define kNear              @"Near"
#define kDataName          @"Data"
#define kUserInfoEntity    @"UserInfo"
#define kFriendInfoEntity  @"FriendInfo"
#define kMessageInfoEntity @"MessageInfo"

@interface DBManager () {
    dispatch_queue_t queue;
}

@property (weak, nonatomic) DBUtils *dbUtils;

@end

@implementation DBManager

+ (DBManager *)shareManager {
    static DBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        queue = [DBUtils getDbUtilsQueue];
        [self setupDbUtil];
    }
    return self;
}


- (void)setupDbUtil {
    dispatch_sync(queue, ^{
        self.dbUtils = [DBUtils createWithName:kDataName
                                      withMomd:kNear];
    });
}

- (void)addUserWithUserId:(NSString *)userId nickname:(NSString *)nickname gender:(GenderType)gender avatarUrl:(NSString *)avatarUrl completion:(void (^)(BOOL))completion {
    dispatch_async(queue, ^{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(userId == %@)", userId];
        //先判断该用户是否存在
        NSArray *fetArray = [self.dbUtils queryWithEntityName:kUserInfoEntity
                                              predicateFormat:predicate
                                               sortDescriptor:nil
                                                   fetchLimit:-1];
        UserInfo *userInfo = nil;
        if (fetArray.count > 0) {
            userInfo = [fetArray objectAtIndex:0];
        } else {
            userInfo = (UserInfo *)[self.dbUtils insertNewObjectForEntityForName:kUserInfoEntity];
        }
        
        userInfo.userId = userId;
        userInfo.nickname = nickname;
        userInfo.gender = @(gender);
        userInfo.avatarUrl = avatarUrl;
        
        completion([self.dbUtils save]);
        
    });
}

@end
