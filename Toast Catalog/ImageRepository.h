@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ImageRepository : NSObject

- (nullable UIImage *)imageForItemIdentifier:(NSInteger)itemIdentifier;

@end

NS_ASSUME_NONNULL_END
