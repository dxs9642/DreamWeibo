//


#import <UIKit/UIKit.h>
@class DreamStatus, DreamStatusDetailFrame;

@interface DreamStatusFrame : NSObject
/** 子控件的frame数据 */
@property (nonatomic, assign) CGRect toolbarFrame;
@property (nonatomic, strong) DreamStatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 微博数据 */
@property (nonatomic, strong) DreamStatus *status;
@end
