import UIKit

__block NSString *str;

dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
for (int i = 0; i < 1000; i++) {
    dispatch_async(queue, ^{
        str = [NSString stringWithFormat:@"1234567890"];
        });



