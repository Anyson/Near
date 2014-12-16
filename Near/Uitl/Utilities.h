//
//  Utilities.h
//  Face2Face
//
//  Created by Anyson Chan on 14-6-23.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

typedef enum LoginType LoginType;

typedef NS_ENUM(uint32_t, GenderType) {
    GENDER_TYPE_MALE = 1,
    GENDER_TYPE_FEMALE,
    GENDER_TYPE_UNKNOWN
};

typedef NS_ENUM(uint32_t, FriendStatus) {
    FRIEND_STATUS_NONE,
    FRIEND_STATUS_INVITEE,//被邀请
    FRIEND_STATUS_INVITATION,//邀请
    FRIEND_STATUS_CHATTING,//聊天中
    FRIEND_STATUS_BE_REMOVE,//对方解除联系人
};

typedef NS_ENUM(uint32_t, MessageStatus) {
    MESSAGE_STATUS_UNKNOW,//未知
    MESSAGE_STATUS_UNREAD,//未读
};

typedef NS_ENUM(uint32_t, MessageType) {
    MESSAGE_TYPE_TEXT,//文本
};


#define IS_IOS_VENSION_8 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)


//
#ifdef DEBUG

#define NSLog_INFO(xx, ...) NSLog(xx, ##__VA_ARGS__)
#define NSLog_DEBUG(xx, ...) NSLog(@"%@ %s %d: " xx, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __func__, __LINE__, ##__VA_ARGS__)

#else

#define NSLog_INFO(xx, ...)
#define NSLog_DEBUG(xx, ...)

#endif

///////////////////////////////////////////
// UIWindow Level
///////////////////////////////////////////
#define UIWindowLevelHighestPriorit UIWindowLevelStatusBar + 1

#define MAIN_BLOCK(block) dispatch_async(dispatch_get_main_queue(), block)
#define DEFAULT_BLOCK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define STR(key) NSLocalizedString(key, @"")


///////////////////////////////////////////
// Key
///////////////////////////////////////////
#define kUSER_TOKEN                       @"user_token"
#define kDEVICE_TOKEN                     @"device_token"
#define kBADGE_NUMBER                     @"badge_number"
#define kIS_FIRST_TO_USE                  @"is_first_to_use"
#define kIS_OPEN_RADAR                    @"is_open_radar"
#define kCOUNTRY_CODE                     @"country_code"
#define kLOOK_TYPE                        @"look_type"
#define kCHANGE_FEED_VERSION              @"change_feed_version"
#define kMAX_MESSAGE_ID                   @"max_message_id"

#define kAVATAR_DATA                      @"avatar_data"
#define kTEMPORARY_LOGIN_INFO             @"temporary_login_info"

#define kENTER_BACKGROUND_TIME            @"enter_background_time"

#define kENTER_BACKGROUND_NOTIFICATION    @"enter_background"
#define kENTER_FOREGROUND_NOTIFICATION    @"enter_foreground"

///////////////////////////////////////////
// userinfo Key
///////////////////////////////////////////
#define kUSER_ID                    @"userId"
#define kNICKNAME                   @"nickname"
#define kALIAS_NAME                 @"alias_name"
#define kGENDER                     @"gender"
#define kFAV_GENDER                 @"fav_gender"
#define kAVATAR_URL                 @"avatar_url"
#define kLOGIN_TYPE                 @"login_type"
#define kFRIEND_STATUS              @"friend_status"
#define kIS_NEAR_REMINDER           @"is_near_reminder"//临近提醒
#define kFACE_COUNTER               @"face_counter"
#define kLAST_FACE_TIME             @"last_face_time"
#define kFIRST_FACE_TIME            @"first_face_time"
#define kMEET_LONGITUDE             @"meet_longitude"
#define kMEET_LATITUDE              @"meet_latitude"
#define kSHIELD_TIME                @"shield_time"
#define kCREATED_TIME               @"created_time"
#define kACTIVE_TIME                @"active_time"

#define kFIRST_NAME                 @"first_name"
#define kLAST_NAME                  @"last_name"
#define kPHONE                       @"phone"
#define kWECHAT_ID                  @"wechat_id"
#define kFACEBOOK_ID                @"facebook_id"

#define kAVATAR_DATA                @"avatar_data"
#define kUSER_INFO                  @"user_info"
#define kTO_ID                      @"to_id"
#define kMESSAGE_ID                 @"message_id"
#define kMEDIA_MESSAGE_TYPE         @"media_message_type"
#define kMEDIA_MESSAGE_CONTENT      @"media_message_content"
#define kSEND_TIME                  @"send_time"

///////////////////////////////////////////
// 通知
///////////////////////////////////////////
#define kUPDATED_PROFILE_NOTIFICATION @"updated_profile_notification"

@class DBManager;
@interface Utilities : NSObject

+ (float)getRihgtWidth:(float)w;
+ (float)getRihgtHeight:(float)h;

//get md5 value
+ (NSString *) md5:(NSString *)str;

+ (NSString *)md5WithData:(NSData *)data;

//hash 值
+ (uint32_t)ELFHash:(char *)str;

+ (NSString *)getSubStringByByetLength:(int)length str:(NSString *)string;

//获取时区
+ (int)getTimezone;

//是否要重新发现，超过五分钟的执行一次发现动画
+ (BOOL)isNeedRediscover;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 图片处理
////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)roundImage:(UIView *)imageView borderColor:(UIColor *)borderColor borderWidth:(float)borderWidth;

+ (CGSize)calcScaledSize:(CGSize)origin bound:(CGSize)size;

+ (UIImage *)getSubImage:(CGRect)rect image:(UIImage *)image;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)size;

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage*) grayscale:(UIImage*)anImage type:(char)type;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 格式化时间
////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)formatTimeByYMD:(long)ftime;
+ (NSString *)formatTime:(long)ftime;


////////////////////////////////////////////////////////////////////////////////////////////////////////////
// NSData 和 NSString互换
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//base64
+ (NSString *)toBase64String:(NSData *)data;
+ (NSData *)getDataWithBase64String:(NSString *)str;

//json
+ (NSData *)toJsonData:(NSDictionary *)dict;
+ (NSString *)toJsonString:(NSDictionary *)dict;
+ (NSDictionary *)getDataWithJsonData:(NSData *)data;
+ (NSDictionary *)getDataWithJsonString:(NSString *)str;

+ (CATransition *)generateViewControllerFadeInAnimationWithDelegate:(id)delegate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// json & dict transfer
////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)dict2Json:(NSDictionary *)dict;
+ (NSDictionary *)json2dict:(NSString *)json;


@end
