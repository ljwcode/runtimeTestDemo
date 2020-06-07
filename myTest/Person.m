//
//  Person.m
//  myTest
//
//  Created by 1 on 2020/6/5.
//

#import "Person.h"
#import <objc/message.h>

//@interface Person()
//
//@property(nonatomic,strong)Bird *b;
//
//
//@end

static Person *p = nil;


@implementation Person

-(void)run
{
    NSLog(@"run");
}

- (void)sayHello {
    NSLog(@"person say hello");
}

+(void)hook_getInstanceMethod:(SEL)originSel swizzleSel:(SEL)swizzleSel
{
    Method orginMethod = class_getInstanceMethod(self, originSel);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSel);
    
    [self hook_swizzleMethodOriginSel:originSel oridingMethod:orginMethod swizzleSel:swizzleSel swizzleMethod:swizzleMethod class:self];
}

+(void)hook_swizzleMethodOriginSel:(SEL)originSel oridingMethod:(Method)originMethod swizzleSel:(SEL)swizzleSel swizzleMethod:(Method)swizzleMethod class:(Class)cls
{
    BOOL didAndMethod = class_addMethod(cls, originSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if(didAndMethod){
        class_replaceMethod(cls, swizzleSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

//-(id)forwardingTargetForSelector:(SEL)aSelector
//{
//    Bird *bird = [[Bird alloc]init];
//    if([bird respondsToSelector:aSelector])
//    {
//        return bird;
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

@end

//@interface Student()
//
//@end


@implementation Student (swizzle)

+ (void)load {
//    [self jr_swizzleMethod:@selector(s_sayHello) withMethod:@selector(sayHello) error:nil];
    [self hook_getInstanceMethod:@selector(s_sayHello) swizzleSel:@selector(sayHello)];
    
}

- (void)s_sayHello {
    [self s_sayHello];

    NSLog(@"Student + swizzle say hello");
}

@end


@implementation Person (swizzle)

+ (void)load {
//    [self jr_swizzleMethod:@selector(p_sayHello) withMethod:@selector(sayHello) error:nil];
    [self hook_getInstanceMethod:@selector(p_sayHello) swizzleSel:@selector(sayHello)];
}

- (void)p_sayHello {
    [self p_sayHello];
    
    NSLog(@"Person + swizzle say hello");
}

@end

@interface Student()


@end

@implementation Student

@end

//@implementation Person
//
////+(void)initialize
////{
////    NSLog(@"initilize");
////    [self hook_getInstanceMethod:@selector(run2) swizzleSel:@selector(run3)];
////}
////类在接收到消息（objc_msgSend)时开始调用，父类调用完之后再调用子类,每个类调用一次，父类可能会被调用多次。
////app启动（runtime开始）时调用，只调用一次，按照按照内存地址，即编译顺序调用，父类调用完之后再调用子类
//+(Person *)shareInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        p = [[Person alloc]init];
//    });
//    return p;
//}
//
//-(void)run{
//    NSLog(@"执行了该方法");
//}
//
//-(void)run3
//{
//    NSLog(@"run3");
//}
//
//+(void)load
//{
//    [self hook_getInstanceMethod:@selector(run2) swizzleSel:@selector(run3)];
//}
//
//-(void)hook_dealloc
//{
//    [[Person shareInstance] handleDeallocObject:self];
//}
//
//NSString *hook_ZoombieClassPrefix = @"hook_zoombie";
//
//
//- (void)handleDeallocObject:(__unsafe_unretained id)object {
//
//
//    NSString *className = NSStringFromClass([object class]);
//    NSString *zombieClassName = [hook_ZoombieClassPrefix stringByAppendingString: className];
//    Class zombieClass = NSClassFromString(zombieClassName);
//    if(zombieClass) return;
//
//    zombieClass = objc_allocateClassPair([NSObject class], [zombieClassName UTF8String], 0);
//    objc_registerClassPair(zombieClass);
//    class_addMethod([zombieClass class], @selector(forwardingTargetForSelector:), (IMP)forwardingTargetForSelector, "@@:@");
//
//    object_setClass(object, zombieClass);
//}
//
//id forwardingTargetForSelector(id object, SEL _cmd, SEL aSelector) {
//
//    NSString *className = NSStringFromClass([object class]);
//    NSString *realClass = [className stringByReplacingOccurrencesOfString:hook_ZoombieClassPrefix withString:@""];
//
//    NSLog(@"[%@ %@] message sent to deallocated instance %@", realClass, NSStringFromSelector(aSelector), object);
//    abort();
//}



//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    NSLog(@"HHH");
//    if(sel == @selector(run2))
//    {
//        class_addMethod([self class], sel, (IMP)run, "v@:");
//
//    }
//
//    return [super resolveInstanceMethod:sel];
//}
//void mysel(){
//    NSLog(@"mysel");
//}
//
//@end

@implementation Bird

-(void)run2
{
    NSLog(@"run2");
}

@end
