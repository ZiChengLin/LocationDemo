//
//  ViewController.h
//  LocationDemo
//
//  Created by 林梓成 on 15/6/23.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>    // 添加定位库的头文件

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic)CLLocationManager *locationManager;    // 属性：位置管理者

@end

