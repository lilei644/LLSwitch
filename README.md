LLSwitch
==================


This is a funny switch for iOS<br>
一个有趣的switch

Thanks [Dribbble](https://dribbble.com/shots/2706143-Dribbble-Debut-Boring-Funny-Slider-Animation) for providing inspiration

![LLSwitchDemo](https://github.com/lilei644/LLSwitch/blob/master/Preview/LLSwitchDemo.gif)

## Installation &nbsp;安装

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `LLSwitch` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'LLSwitch'
```
To get the full benefits import `LLSwitch` wherever you import UIKit

#### Manually
1. Download and drop ```/LLSwitch```folder in your project.  
2. Congratulations!  

## Usage &nbsp;用法

#### Initialization &nbsp;初始化
```
LLSwitch *llSwitch = [[LLSwitch alloc] initWithFrame:CGRectMake(100, 100, 120, 60)];
[self.view addSubview:llSwitch];
```

#### Reset Base Property &nbsp;重设基本属性
```
llSwitch.onColor = [UIColor blueColor];    // switch is open color    开关打开的颜色
llSwitch.offColor = [UIColor grayColor];    // switch is close color    开关关闭的颜色
llSwitch.faceColor = [UIColor whiteColor];    // switch face color    圆脸的颜色
llSwitch.animationDuration = 1.2f;    // switch open or close animation time    开关的动画时间
```

#### delegate &nbsp;代理监听
```
<LLSwitchDelegate>
llSwitch.delegate = self;

-(void)didTapLLSwitch:(LLSwitch *)llSwitch {
NSLog(@"start");
}

- (void)animationDidStopForLLSwitch:(LLSwitch *)llSwitch {
NSLog(@"stop");
}

- (void)valueDidChanged:(LLSwitch *)llSwitch on:(BOOL)on {
NSLog(@"stop --- on:%hhd", on);
}
```
#### support xib and storyboard&nbsp;支持xib和storyboard
![LLSwitchForXib](https://github.com/lilei644/LLSwitch/blob/master/Preview/LLSwitchForXib.png)

## Requirements &nbsp;版本要求
IOS 6.0 Above

## License
LLSwitch is provided under the MIT license. See LICENSE file for details.
