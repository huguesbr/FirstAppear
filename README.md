# FirstAppear
Extend all view controller to support a view[Will/Did]FirstAppear called only once

# Usage

Simply implements either methods `viewWillFirstAppear:(BOOL)animated` or `viewDidFirstAppear:(BOOL)animated` and you will be call back once on each of this method.

Perfect spot to initialize some view related stuff, as view are then dimension.

# Example

```
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
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
```

will log

```
viewWillFirstAppear
viewWillAppear
viewDidFirstAppear
viewDidAppear
viewWillDisappear
viewDidDisappear
viewWillAppear
viewDidAppear
```
