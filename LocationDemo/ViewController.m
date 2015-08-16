//
//  ViewController.m
//  LocationDemo
//
//  Created by 林梓成 on 15/6/23.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /**
     *    三种定位方式
     *
     *   1、手机基站：信号塔越密集，定位越准确（根据手机上网选择的最近的手机基站来定位）
     *   2、GPS：卫星定位。这个精确度最高、但是费电费流量
     *   3、WIFI定位：根据上网的IP地址定位
     */
    
    
    // 创建一个位置管理者
    self.locationManager = [[CLLocationManager alloc] init];
    
    // 判断当前Iphone设备的版本号
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        // 由于IOS8中定位的授权机制改变、需要进行手动进行授权（同时还需要在info.plist里面添加两个键值对）
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 定位对一些设置（通常判断一下移动设备的移动速度从而设置其更新位置）
    // 实质：重走一遍代理方法
    self.locationManager.distanceFilter = 10.0f;    // 走10米更新一次位置
    self.locationManager.desiredAccuracy = 1.0f;    // 设置精确度
    // 设置代理
    self.locationManager.delegate = self;
    
    // 开启更新位置功能
    [self.locationManager startUpdatingLocation];
    // 开启手机朝向的更新功能（通常来做导航功能）
    [self.locationManager startUpdatingHeading];
}

/**
 *   需要在plist文件中添加默认缺省的字段“NSLocationAlwaysUsageDescription”，这个提示是:“允许应用程序在您并未使用该应用程序时访问您的位置吗？”NSLocationAlwaysUsageDescription对应的值是告诉用户使用定位的目的或者是标记。
 
     需要在plist文件中添加默认缺省的字段“NSLocationWhenInUseDescription”，这个时候的提示是:“允许应用程序在您使用该应用程序时访问您的位置吗？”
 */


#pragma mark CLLocationManagerDelegate代理方法

// 实现定位的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // 位置类
    CLLocation *location = (CLLocation *)[locations lastObject];
    
    NSLog(@"%f、%f",location.coordinate.latitude, location.coordinate.longitude);  // 打印经纬度（需要真机）
    
    // 位置反编码
    CLGeocoder *geocode = [[CLGeocoder alloc] init];
    // 使用位置反编码对象获取位置信息
    [geocode reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
       
        for (CLPlacemark *pl in placemarks) {
            
            NSLog(@"name = %@", pl.name);
            NSLog(@"thoroughface = %@", pl.thoroughfare);
            NSLog(@"subThoroughface = %@", pl.subThoroughfare);
            NSLog(@"locality = %@", pl.locality);
            NSLog(@"%@", pl.country);
        }
        
    }];
    
}


// 实现朝向的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    // 获得当前设备的地磁北极的夹角（需要真机）
    int heading = newHeading.magneticHeading;
    NSLog(@"heading = %d", heading);
    
    if ( (315 <= heading && heading <= 360) || (0 < heading && heading <= 45)) {
        
        NSLog(@"你现在的手机朝向为北");
        
    } else if ( 45 <= heading && heading <= 135 ) {
        
        NSLog(@"你现在的手机朝向为东");
        
    } else if ( 135 <= heading && heading <= 225 ) {
        
        NSLog(@"你现在的手机朝向为南");
        
    } else {
        
        NSLog(@"你现在的手机朝向为西");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
