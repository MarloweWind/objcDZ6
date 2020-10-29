//
//  calculator.m
//  objcDZ6
//
//  Created by Алексей Мальков on 28.10.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

#import "calculator.h"
#import "main.h"

CalculatorBlock sum = ^(NSNumber *first, NSNumber *second) {
    return [NSNumber numberWithInt:[first intValue] + [second intValue]];
};

CalculatorBlock minus = ^(NSNumber *first, NSNumber *second) {
    return [NSNumber numberWithInt:[first intValue] - [second intValue]];
};

CalculatorBlock multy = ^(NSNumber *first, NSNumber *second) {
    return [NSNumber numberWithInt:[first intValue] * [second intValue]];
};

CalculatorBlock divide = ^(NSNumber *first, NSNumber *second) {
    return [NSNumber numberWithInt:[first intValue] / [second intValue]];
};

CalculatorResult resultBlock = ^(NSNumber *result) {
    int res = [result intValue];
    printf("Результат: %i", res);
};

@implementation Calculator: NSObject

-(void) initWithNumbersFirst:(NSNumber *) first Second:(NSNumber *) second {
    _first = first;
    _second = second;
    
    if ([_second intValue] > -1) {
        dispatch_queue_t globalQueueDefault = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
        
        __block NSNumber *resultSum = nil;
        __block NSNumber *resultMinus = nil;
        __block NSNumber *resultMultiply = nil;
        __block NSNumber *resultDivide = nil;
        
        MakeQueue queue = ^(void) {
            dispatch_async(globalQueueDefault, ^{
                resultSum = sum(self.first, self.second);
            });

            dispatch_async(globalQueueDefault, ^{
                resultMinus = minus(self.first, self.second);
            });
            
            dispatch_async(globalQueueDefault, ^{
                resultMultiply = multy(self.first, self.second);
            });
            
            dispatch_async(globalQueueDefault, ^{
                if (self.second > 0) {
                    resultDivide = divide(self.first, self.second);
                }
            });
        };
        
        queue();
        
        dispatch_barrier_sync(globalQueueDefault, ^{
            selectCalculatorOperation(self);
        });
        
        NSNumber *result = nil;
        
        switch ([self.operations intValue]) {
            case opPlus:
                result = resultSum;
                break;
            case opMinus:
                result = resultMinus;
                break;
            case opDivide:
                result = resultDivide;
                break;
            default:
                break;
        }
        
        if (result != nil) {
            resultBlock(result);
        } else {
            printf("Такой операции нет");
        }
        
        loadNumbers(self);
    }
}

@end
