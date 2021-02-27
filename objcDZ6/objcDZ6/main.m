//
//  main.m
//  objcDZ6
//
//  Created by Алексей Мальков on 28.10.2020.
//  Copyright © 2020 Alexey Malkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calculator.h"
#import "main.h"

void selectCalculatorOperation (Calculator *calc) {
    int menu_item = 0;
    
    
    printf("\nВыберете, что вы хотите сделать в введенными числами.");
    printf("\n___\n");
    printf(" 1: Сложение\n");
    printf(" 2: Вычитание\n");
    printf(" 3: Умножение\n");
    printf(" 4: Деление\n");
    printf(" 5: Среднее трёх чисел\n");
    printf("___\n");
    
    printf("Ваш выбор: ");
    scanf("%int", &menu_item);
    
    
    switch (menu_item) {
        case opPlus:
        case opMinus:
        case opMultipy:
        case opDivide:
        case opAvg:
            calc.operations = [NSNumber numberWithInteger:menu_item];
            break;
        default: {
            selectCalculatorOperation(calc);
        }
        
    }
}

void loadNumbers (Calculator *calc) {
    int first_entered = 0;
    int second_entered = 0;
    
    printf("\nВведите два числа.\n");
    printf("первое: ");
    scanf("%i", &first_entered);
    
    if (first_entered > -1) {
        printf("Второе: ");
        scanf("%i", &second_entered);
        
        [calc initWithNumbersFirst:[NSNumber numberWithInt:first_entered] Second:[NSNumber numberWithInt:second_entered]];
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Calculator *calc = [Calculator new];
        loadNumbers(calc);
    }
    return 0;
}
