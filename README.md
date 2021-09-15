# MSSegmentedControl [![Build Status](https://camo.githubusercontent.com/e948575bb276fa2ffac99e1491d13e1ad8e28d7cc5e17153d3ea5bfa8b9784a6/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f706c6174666f726d2d6d61634f532d6c69676874677265792e737667)](https://travis-ci.org/atmos/camo)

MSSegmentedControl can implement without border NSSegmentedControl


## Config menu style

without border NSSegmentedControl

```Objective-C
NSArray *items = @[
    [MSSegmentedControlItem initWithImageName:NSImageNameTouchBarGetInfoTemplate],
    [MSSegmentedControlItem initWithImageName:NSImageNameHomeTemplate],
    [MSSegmentedControlItem initWithImageName:NSImageNameActionTemplate],
];
[self.menuCtl setItems:items];
```

## Config button style

```Objective-C
NSArray *menuItems = @[
    [MSSegmentedControlItem initWith:@"Home" imageName:NSImageNameHomeTemplate],
    [MSSegmentedControlItem initWith:@"Setting" imageName:@"gearshape"],
    [MSSegmentedControlItem initWith:@"Help" imageName:@"questionmark.circle"]
];

// button style with title show
[self.btnWithTitle setItems:menuItems]; 
[self.btnWithTitle setDisplayStyle:MSSCDisplayStyleButton];
```