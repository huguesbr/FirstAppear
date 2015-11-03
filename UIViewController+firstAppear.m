//
//  UIViewController+firstAppear.m
//  Hugues Bernet-Rollande
//
//  Created by Hugues Bernet-Rollande on 2/11/15.
//  Copyright © 2015 Hugues Bernet-Rollande. All rights reserved.
//

#import "UIViewController+firstAppear.h"

#import <objc/runtime.h>

static NSString * const UIViewControllerWillFirstAppearNotification = @"UIViewControllerWillFirstAppearNotification";
static NSString * const UIViewControllerDidFirstAppearNotification = @"UIViewControllerDidFirstAppearNotification";

// hidden category to store did appeared once
@interface UIViewController (firstAppearPrivate)
@property (assign, nonatomic) BOOL willAppearCalled;
@property (assign, nonatomic) BOOL didAppearCalled;
@end
@implementation UIViewController (firstAppearPrivate)
@dynamic willAppearCalled, didAppearCalled;
- (void)setWillAppearCalled:(BOOL)willAppearCalled {
    objc_setAssociatedObject(self, @selector(willAppearCalled), @(willAppearCalled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)willAppearCalled {
    id o = objc_getAssociatedObject(self, @selector(willAppearCalled));
    return [o boolValue];
}
- (void)setDidAppearCalled:(BOOL)didAppearCalled {
    objc_setAssociatedObject(self, @selector(didAppearCalled), @(didAppearCalled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)didAppearCalled {
    id o = objc_getAssociatedObject(self, @selector(didAppearCalled));
    return [o boolValue];
}
@end

@implementation UIViewController (firstAppear)

+ (void)load {
    // swizzle appearance methods to insert first appearance callback & notifications

    Method willAppearOriginalMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method willAppearReplacementMethod = class_getInstanceMethod([self class], @selector(hbr_firstAppear_viewWillAppear:));
    method_exchangeImplementations(willAppearReplacementMethod, willAppearOriginalMethod);
    
    Method didAppearOriginalMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
    Method didAppearReplacementMethod = class_getInstanceMethod([self class], @selector(hbr_firstAppear_viewDidAppear:));
    method_exchangeImplementations(didAppearReplacementMethod, didAppearOriginalMethod);
}

- (void)hbr_firstAppear_viewWillAppear:(BOOL)animated {
    if(self.willAppearCalled == NO) {
        // call viewWillFirstAppear if implemented
        SEL viewWillFirstAppear = NSSelectorFromString(@"viewWillFirstAppear:");
        if([self respondsToSelector:viewWillFirstAppear]) {
            IMP imp = [self methodForSelector:viewWillFirstAppear];
            void (*func)(id, SEL, BOOL) = (void *)imp;
            func(self, viewWillFirstAppear, animated);
        }
        // send broadcast
        [[NSNotificationCenter defaultCenter] postNotificationName:UIViewControllerWillFirstAppearNotification object:@{@"animated": @(animated)}];
        // remember will appear
        self.willAppearCalled = YES;
    }
    [self hbr_firstAppear_viewWillAppear:animated];
}

- (void)hbr_firstAppear_viewDidAppear:(BOOL)animated {
    if(self.didAppearCalled == NO) {
        // call viewDidFirstAppear if implemented
        SEL viewDidFirstAppear = NSSelectorFromString(@"viewDidFirstAppear:");
        if([self respondsToSelector:viewDidFirstAppear]) {
            IMP imp = [self methodForSelector:viewDidFirstAppear];
            void (*func)(id, SEL, BOOL) = (void *)imp;
            func(self, viewDidFirstAppear, animated);
        }
        // send broadcast
        [[NSNotificationCenter defaultCenter] postNotificationName:UIViewControllerDidFirstAppearNotification object:@{@"animated": @(animated)}];
        // remember did appear
        self.didAppearCalled = YES;
    }
    [self hbr_firstAppear_viewDidAppear:animated];
}

- (BOOL)firstAppear {
    return (self.didAppearCalled == NO);
}

@end