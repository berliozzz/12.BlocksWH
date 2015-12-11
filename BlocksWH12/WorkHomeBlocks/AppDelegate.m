//
//  AppDelegate.m
//  WorkHomeBlocks
//
//  Created by Nikolay Berlioz on 19.09.15.
//  Copyright (c) 2015 Nikolay Berlioz. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreGraphics/CoreGraphics.h>
#import "Student.h"

//-----  type block   ------
typedef void (^emptyBlockType)(void);

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //----------------------- Ученик ---------------------------------------
    NSLog(@"----------------------- Ученик ---------------------------------------");

    
    //**********************   firstBlock   **************************
    void (^firstBlock)(void);
    
    firstBlock = ^{
        NSLog(@"Call firstBlock");
    };
    
    firstBlock();
    
    //**********************   secondBlockWithParam   *****************

    void (^secondBlockWithParam)(NSString*);
    
    secondBlockWithParam = ^(NSString* string){
        NSLog(@"secondBlockWithParam out string: %@", string);
    };
    
    secondBlockWithParam(@"Call secondBlockWithParam");
    
    //**********************   thirdBlock   *****************

    emptyBlockType thirdBlock = ^{
        
        for (int i = 1; i < 6; i++) // заспечатывает елочку
        {
            for (int j = 0; j < i; j++)
            {
                putchar('*');
            }
            putchar('\n');
        }
    };
    
    [self methodWithBlock:thirdBlock];   // вызов метода принимающего блок
    
    //----------------------- Студент ---------------------------------------
    NSLog(@"----------------------- Студент ---------------------------------------");
    //----------------------- Создаем объекты ---------------------------------------
    
    Student *student1 = [[Student alloc] init];
    Student *student2 = [[Student alloc] init];
    Student *student3 = [[Student alloc] init];
    Student *student4 = [[Student alloc] init];

    //----------------------- Присваиваем объектам имена и фамилии --------------------
    
    student1.firstName = @"Vasya";
    student1.laststName = @"Abramov";
    student1.temperature = 39.f;

    student2.firstName = @"Asya";
    student2.laststName = @"Egorova";
    student2.temperature = 37.2f;

    
    student3.firstName = @"Fedor";
    student3.laststName = @"Abramov";
    student3.temperature = 39.5f;


    student4.firstName = @"Maria";
    student4.laststName = @"Egorova";
    student4.temperature = 40.2f;

    
    //----------------------- Создаем массив с объектами ---------------------------------------------
    
    NSArray *arrayNotSort = [[NSArray alloc] initWithObjects:student4, student1, student2, student3, nil];
    
    NSLog(@"----------    вывод неотсортированного массива    ----------");

    //----------------------- Печатаем содержимое массива --------------------------------------------

    for (id student in arrayNotSort)
    {
        NSLog(@"student %@ %@", [student laststName], [student firstName]); //вывод неотсортированного массива
    }
    
    //---------- Создаем отсортированный массив, добавляя в него неотсотированный arrayNotSort -------

    NSLog(@"-------   вывод ОТСОРТИРОВАННОГО по фамилии массива   ------");

    //---------- сначала сортируем по свойству laststName --------------------------------------------

    NSArray *sortedArray = [arrayNotSort sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([[obj1 laststName] isEqualToString: [obj2 laststName]])
        {
            return [[obj1 firstName] compare:[obj2 firstName]]; // сортируем по свойству laststName
            
        }
        else
        {
            return [[obj1 laststName] compare:[obj2 laststName]]; // сортируем по свойству firstName
        }    }];
    

    for (id student in sortedArray)
    {
        NSLog(@"student %@ %@", [student laststName], [student firstName]); //вывод отсортированного массива
    }
    
    //----------------------- Мастер ---------------------------------------
    NSLog(@"----------------------- Мастер ---------------------------------------");
    
    // запускаем цикл, в нем создаем блок и назначаем лечение, если студенту плохо
    
    for (id student in sortedArray)
    {
        //---------- Создаем блок --------------------------------------------

        emptyBlockType blockWithHelp = ^{
            if ([student temperature] >= 37.f && [student temperature] <= 39.f) // если темпер от 37.7 до 39 даем табл
            {
                [student takePill];
            }
            else if ([student temperature] > 39.f)      // если темпер от 39 делаем укол
            {
                [student makeShot];
            }
            else                            // если меньше 37, отправляем отдыхать
                NSLog(@"Patient %@ %@ should rest!", [student firstName], [student laststName]);
        };
        
        //---------- узнаем самочувствие студента --------------------------------------------

        NSLog(@"%@ %@ are you ok? ", [student firstName], [student laststName]);

        if ([student howAreYou])
        {
            NSLog(@"%@ say: Yes", [student firstName]);    // если хорошо ничего не делаем
            NSLog(@"--------------------");
        }
        else
        {
            NSLog(@"%@ say: No", [student firstName]);     // если плохо - вызываем метод
            NSLog(@"%@ temperature is %.1f", [student firstName], [student temperature]);
            [self methodIfStudentIsBad:blockWithHelp];
            NSLog(@"--------------------");
        }
    }
    
        return YES;
}

//---------   метод принимающий блок если студенту плохо   ------
- (void) methodIfStudentIsBad: (emptyBlockType) block
{
    block(); //просто запускает принятый блок, а лечение в самом блоке
}


//---------   метод принимающий блок и вызывающий его же   ------
- (void) methodWithBlock: (emptyBlockType) block
{
    block();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
