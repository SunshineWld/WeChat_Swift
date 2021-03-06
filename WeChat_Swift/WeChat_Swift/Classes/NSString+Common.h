//  Created by chen ying on 12-11-6.
//  Copyright (c) 2012年 hoolai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Common)

/** 验证邮箱 */
-(BOOL)isValidateEmail;

/** 是否都为整形数字 */
- (BOOL)isPureInt;

/** 验证身份证号码 */
- (BOOL)isValidateIDCard;

/** 验证手机号码 */
- (BOOL)isValidateMobileNumber;

/** 验证银行卡 (Luhn算法) */
- (BOOL)isValidCardNumber;

/** 是否包含中文 */
- (BOOL)containsChineseCharacter;

- (float)stringWidthWithFont:(UIFont *)font height:(float)height;
- (float)stringHeightWithFont:(UIFont *)font width:(float)width;

@end
