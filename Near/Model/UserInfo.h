//
//  UserInfo.h
//  Near
//
//  Created by ADC on 14-12-17.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * createdTime;

@end
