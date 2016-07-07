LLSwitch
==================


This is a funny switch for iOS<br>
一个有趣的switch

Thank [Dribbble](https://dribbble.com/shots/2706143-Dribbble-Debut-Boring-Funny-Slider-Animation) for providing inspiration

----------


Preview  预览
-------------
![LLSwitchDemo](https://github.com/lilei644/LLSwitch/blob/master/Preview/LLSwitchDemo.gif)

## Installation &nbsp;安装
* pod
```
1.pod "LLSwitch"
2.pod install       // 若获取失败请重新 pod setup
3.#import "LLSwitch.h"
```
* Common
```
1.Add "LLSwitch" files to your Project   // 直接导入“LLSwitch”文件夹到项目中
2.#import "LLSwitch.h"
```

## Usage &nbsp;用法
* Init &nbsp;初始化
```
LLSwitch *llSwitch = [[LLSwitch alloc] initWithFrame:CGRectMake(100, 100, 120, 60)];
[self.view addSubview:llSwitch];
```
* Reset Base Property &nbsp;重设基本属性
```
llSwitch.onColor = [UIColor blueColor];    // switch is open color    开关打开的颜色
llSwitch.offColor = [UIColor grayColor];    // switch is close color    开关关闭的颜色
llSwitch.faceColor = [UIColor whiteColor];    // switch face color    圆脸的颜色
llSwitch.animationDuration = 1.2f;    // switch open or close animation time    开关的动画时间

[llSwitch setOn:YES];                 // set on and off     设置开关
[llSwitch setOn:YES animated:YES];
```

* delegate &nbsp;代理监听
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
* support xib and storyboard&nbsp;支持xib和storyboard
![LLSwitchForXib](https://github.com/lilei644/LLSwitch/blob/master/Preview/LLSwitchForXib.png)

## Requirements &nbsp;版本要求
IOS 6.0 Above

## License
LLSwitch is provided under the MIT license. See LICENSE file for details.
