//
//  main.m
//  myTest
//
//  Created by 1 on 2020/6/5.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *obj = [[NSObject alloc] init];
        
        NSLog(@"%zd", class_getInstanceSize([NSObject class]));
        NSLog(@"调试");
        
        Person *person = [[Person alloc]init];
//        [person run];
        [person sayHello];
//        [person performSelector:@selector(run2)];

        NSLog(@"%zd", malloc_size((__bridge const void *)obj));
        
    }
    return 0;
}

