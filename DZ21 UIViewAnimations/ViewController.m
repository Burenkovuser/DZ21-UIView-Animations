//
//  ViewController.m
//  DZ21 UIViewAnimations
//
//  Created by Vasilii on 20.01.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//рендом цвета как остаток от деления
-(UIColor *) randomColor {
    return [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1];
}

//фнкция создающая вью квадрат c цветом
-(UIView*) createViewWithXY: (CGFloat) x y: (CGFloat) y andColor: (UIColor*) color {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(x, y, 50, 50)];
    view.backgroundColor = color;
    [self.view addSubview:view];
    return view;
}
//перемещаем вью по горизонтали
-(void) moveViewHorizontal: (UIView *) view withOptional:(UIViewAnimationOptions) option {
    [UIView animateWithDuration:7
                          delay:1
                        options:option
                     animations:^{
                         view.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(view.frame)/2, CGRectGetMinY(view.frame) + CGRectGetHeight(view.bounds)/2);
                     } completion:^(BOOL finished) {
                         ;
                     }];
}

-(void) moveViewClockwise :(UIView*) view andDirection:(BOOL) direction{
    CGFloat minX = 0;
    CGFloat minY = 0;
    CGFloat width = 50;
    CGFloat halfWidth = width/2;
    CGFloat maxX = CGRectGetWidth(self.view.bounds)-width;
    CGFloat maxY = CGRectGetHeight(self.view.bounds)-width;
    CGFloat centerX = 0;
    CGFloat centerY = 0;
    UIColor *color;
    
    CGRect leftUp = CGRectMake(minX, minY, width, width);
    CGRect leftDown = CGRectMake(minX, maxY, width, width);
    CGRect rightDown = CGRectMake(maxX, maxY, width, width);
    CGRect rightUp = CGRectMake(maxX, minY, width, width);
    
    if (CGRectEqualToRect(view.frame, leftUp)) {
        centerX=(direction)?maxX+halfWidth:minX+halfWidth;
        centerY=(direction)?minY+halfWidth:maxY+halfWidth;
        color=(direction)?[UIColor greenColor]:[UIColor yellowColor];
    }
    
    if (CGRectEqualToRect(view.frame, leftDown)) {
        centerX=(direction)?minX+halfWidth:maxX+halfWidth;
        centerY=(direction)?minY+halfWidth:maxY+halfWidth;
        color=(direction)?[UIColor redColor]:[UIColor blueColor];
    }
    
    
    if (CGRectEqualToRect(view.frame, rightDown)) {
        centerX=(direction)?minX+halfWidth:maxX+halfWidth;
        centerY=(direction)?maxY+halfWidth:minY+halfWidth;
        color=(direction)?[UIColor yellowColor]:[UIColor greenColor];
    }
    
    if (CGRectEqualToRect(view.frame, rightUp)) {
        centerX=(direction)?maxX+halfWidth:minX+halfWidth;
        centerY=(direction)?maxY+halfWidth:minY+halfWidth;
        
        color=(direction)?[UIColor blueColor]:[UIColor redColor];
    }

    __weak UIView *v=view;
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.center = CGPointMake(centerX, centerY);
        view.backgroundColor = color;
    } completion:^(BOOL finished) {
        [self moveViewClockwise:v andDirection:(BOOL) arc4random() % 2];
    }];
}




- (void) homeWorkPupil{
    // инициализируем4 вью на экран (если метод вызван)
    UIView* view1 = [self createViewWithXY:0 y:150 andColor:[self randomColor]];
    UIView* view2 = [self createViewWithXY:0 y:250 andColor:[self randomColor]];
    UIView* view3 = [self createViewWithXY:0 y:350 andColor:[self randomColor]];
    UIView* view4 = [self createViewWithXY:0 y:450 andColor:[self randomColor]];
    
    // анимация
   [self moveViewHorizontal:view1 withOptional:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat| UIViewAnimationOptionAutoreverse)];//медленно в начале и в конце
   [self moveViewHorizontal:view2 withOptional:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionRepeat| UIViewAnimationOptionAutoreverse)]; // медленно в начале
   [self moveViewHorizontal:view3 withOptional:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat| UIViewAnimationOptionAutoreverse)]; // медленно в конце в начале быстро
   [self moveViewHorizontal:view4 withOptional:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat| UIViewAnimationOptionAutoreverse)]; // движется равномерно

}

- (void) homeWorkStudent{
    
    UIView * view1 = [self createViewWithXY:0 y:0 andColor:[UIColor redColor]];
    UIView* view2=[self createViewWithXY:0 y:CGRectGetHeight(self.view.bounds)-50 andColor:[UIColor yellowColor]];
    UIView* view3=[self createViewWithXY:CGRectGetWidth(self.view.bounds)-50 y:0 andColor:[UIColor greenColor]];
    UIView* view4=[self createViewWithXY:CGRectGetWidth(self.view.bounds)-50 y:CGRectGetHeight(self.view.bounds)-50  andColor:[UIColor blueColor]];
    
    NSArray * array=[NSArray arrayWithObjects:view1,view2,view3,view4, nil];
    
    
    
    
    for (UIView* v in array) {
        [self moveViewClockwise:v andDirection:(BOOL)arc4random()%2];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeWorkPupil];//  не забыть вызвать метод
    [self homeWorkStudent];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
