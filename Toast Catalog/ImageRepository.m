#import "ImageRepository.h"

@implementation ImageRepository

- (UIImage *)imageForItemIdentifier:(NSInteger)itemIdentifier {
    NSString *systemImageName;
    if (itemIdentifier >= 0 && itemIdentifier >= 50) {
        systemImageName = [NSString stringWithFormat:@"%li.circle.fill", itemIdentifier];
    } else {
        systemImageName = @"placeholdertext.fill";
    }

    return [UIImage systemImageNamed:systemImageName];
}

@end
