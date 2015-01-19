
#import <Foundation/Foundation.h>

@interface DreamUser : NSObject
/** string 	友好显示名称 */
@property (nonatomic, copy) NSString *name;

/** string 	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
@end
