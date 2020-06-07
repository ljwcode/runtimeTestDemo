//
//  Person.h
//  myTest
//
//  Created by 1 on 2020/6/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic,strong)NSString *name;
-(void)run;

- (void)sayHello;

@end

@interface  Bird : NSObject

-(void)run2;

@end

@interface Student : Person

@end

@interface Student (swizzle)


@end

@interface Person (swizzle)

@end

NS_ASSUME_NONNULL_END
