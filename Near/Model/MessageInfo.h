//
//  MessageInfo.h
//  Near
//
//  Created by ADC on 14-12-17.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MessageInfo : NSManagedObject

@property (nonatomic, retain) NSString * fromId;
@property (nonatomic, retain) NSString * toId;
@property (nonatomic, retain) NSString * messageId;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * messageStatus;
@property (nonatomic, retain) NSNumber * messageType;
@property (nonatomic, retain) NSNumber * createdTime;

@end
