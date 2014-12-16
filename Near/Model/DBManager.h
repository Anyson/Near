//
//  DBManager.h
//  TextCoreData
//
//  Created by ADC on 14-12-15.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+ (DBManager *)shareManager;

- (void)addUserWithUserId:(NSString *)userId nickname:(NSString *)nickname gender:(GenderType)gender avatarUrl:(NSString *)avatarUrl completion:(void(^)(BOOL isFinish))completion;


@end
