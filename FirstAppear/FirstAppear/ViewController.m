//
//  ViewController.m
//  FirstAppear
//
//  Created by Hugues Bernet-Rollande on 3/11/15.
//  Copyright © 2015 Hugues Bernet-Rollande. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillFirstAppear:(BOOL)animated {
    NSLog(@"viewWillFirstAppear");
}

- (void)viewDidFirstAppear:(BOOL)animated {
    NSLog(@"viewDidFirstAppear");
}

- (IBAction)presentModal {
    UIViewController *newController = [UIViewController new];
    newController.view.backgroundColor = [UIColor blueColor];
    [self presentViewController:newController animated:YES completion:^{
        [newController dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
