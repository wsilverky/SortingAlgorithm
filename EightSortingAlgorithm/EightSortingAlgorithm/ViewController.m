//
//  ViewController.m
//  EightSortingAlgorithm
//
//  Created by wangyin on 16/8/1.
//  Copyright © 2016年 silverk. All rights reserved.
//

#import "ViewController.h"

#define Max 20
#define Base 10

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1 升序
    NSArray *arr = @[@3,@45,@23,@43,@12,@34,@12,@11,@90,@0,@1,@2938,@9,@10,@2];
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:arr];
   // NSLog(@"1 快速排序 %@",[self insertSortArray:arr1]);
    //NSLog(@"2 希尔排序 %@",[self shellSortArray:arr1]);
   // NSLog(@"3 冒泡排序 %@",[self bubbleSortArray:arr1]);
   // NSLog(@"4 快速排序 %@",[self quickSortArray:arr1 Start:0 End:arr1.count-1]);
   // NSLog(@"5 直接选择排序 %@",[self selectSortArray:arr1]);
    //NSLog(@"6 堆排序 %@",[self heapSortArray:arr1]);
    NSLog(@"6 堆排序 %@",[self mergeSortArray:arr1]);

    
}

#pragma mark -1 插入排序
/*
 插入排序的基本操作就是将一个数据插入到已经排好序的有序数据中，从而得到一个新的、个数加一的有序数据，算法适用于少量数据的排序，时间复杂度为O(n^2)。是稳定的排序方法。插入算法把要排序的数组分成两部分：第一部分包含了这个数组的所有元素，但将最后一个元素除外（让数组多一个空间才有插入的位置），而第二部分就只包含这一个元素（即待插入元素）。在第一部分排序完成后，再将这个最后元素插入到已排好序的第一部分中。
 */

//
- (NSMutableArray *)insertSortArray:(NSMutableArray<NSNumber *> *)array {
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    NSInteger  key;
    NSInteger j;
    for (NSUInteger i=1; i<arr.count; i++) {
        key = [arr[i] integerValue];
        for ( j=i-1; j>=0 && key <= [arr[j] integerValue]; j--) {
            [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
        }
    }

    return arr;
}

#pragma mark -2 希尔排序
/*
 希尔排序(Shell Sort)是插入排序的一种。也称缩小增量排序，是直接插入排序算法的一种更高效的改进版本。希尔排序是非稳定排序算法。该方法因DL．Shell于1959年提出而得名。 希尔排序是把记录按下标的一定增量分组，对每组使用直接插入排序算法排序；随着增量逐渐减少，每组包含的关键词越来越多，当增量减至1时，整个文件恰被分成一组，算法便终止。
 */
- (NSMutableArray *)shellSortArray:(NSMutableArray<NSNumber *>*)array {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    NSInteger count = arr.count;
    NSInteger step = 2;
    NSInteger group = count/step;
    
    while (group>0) {
        NSInteger  key;

        for (NSInteger i=0; i<group; i++) {
            for (NSInteger j= i; j<count; j= j+group) {
                key = [arr[j] integerValue];
                for (NSInteger k=j-group; k>=0 && key <= [arr[k] integerValue]; k= k-group) {
                    [arr exchangeObjectAtIndex:k withObjectAtIndex:k+group];
                }
                
            }
            
        }
        
        group = group/step;
    }
    return arr;

}

#pragma mark -3 冒泡排序
/*
 它重复地走访过要排序的数列，一次比较两个元素，如果他们的顺序错误就把他们交换过来。走访数列的工作是重复地进行直到没有再需要交换，也就是说该数列已经排序完成。
 */
- (NSMutableArray *)bubbleSortArray:(NSMutableArray *)array {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    for (NSInteger i=0; i<arr.count; i++) {
        for (NSInteger j=i+1; j<arr.count; j++) {
            if ([arr[i] integerValue] > [arr[j] integerValue]) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
            
        }
    }
    return arr;
}

#pragma mark -4 快速排序
/*
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
 */

//递归法
- (NSMutableArray * )quickSortArray:(NSMutableArray <NSNumber *>*)arr Start:(NSInteger)start End:(NSInteger)end {
    if (start >= end) {
        return nil;
    }
    //NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    NSInteger mid = [[arr objectAtIndex:end] integerValue];
    NSInteger left = start;
    NSInteger right = end-1;//取得最后个作为基种，所以要end－1 左右最后个，否则死循环
    while (left < right) {
        while ([arr[left]integerValue] < mid && left < right) {
            left ++;
        }
        while ([arr[right]integerValue] > mid && left < right) {
            right --;
        }
        [arr exchangeObjectAtIndex:left withObjectAtIndex:right];
        
    }
    if ([arr[left]integerValue] >= [arr[end]integerValue]) {
        [arr exchangeObjectAtIndex:left withObjectAtIndex:end];
    }else {
        left ++;
    }
    [self quickSortArray:arr Start:start End:left -1];
    [self quickSortArray:arr Start:left +1  End:end];
    
    return arr;
}

#pragma mark -5 直接选择排序
/*
 基本思想：第1趟，在待排序记录r1 ~ r[n]中选出最小的记录，将它与r1交换；第2趟，在待排序记录r2 ~ r[n]中选出最小的记录，将它与r2交换；以此类推，第i趟在待排序记录r[i] ~ r[n]中选出最小的记录，将它与r[i]交换，使有序序列不断增长直到全部排序完毕。

 */
- (NSMutableArray *)selectSortArray:(NSMutableArray <NSNumber *>*)array{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    NSInteger count = arr.count;
    NSInteger min =0;
    
    for (NSInteger i=0; i<count-1; i++) {
            min  = i;
        for (NSInteger j = i+1; j<count; j++) {
            if (arr[min] > arr[j]) {
                min = j;
            }
        }
        [arr exchangeObjectAtIndex:min withObjectAtIndex:i];

    }
    
    return arr;
}

#pragma mark -6 堆排序
/*
 堆排序(Heapsort)是指利用堆积树（堆）这种数据结构所设计的一种排序算法，它是选择排序的一种。可以利用数组的特点快速定位指定索引的元素。堆分为大根堆和小根堆，是完全二叉树。大根堆的要求是每个节点的值都不大于其父节点的值，即A[PARENT[i]] >= A[i]。在数组的非降序排序中，需要使用的就是大根堆，因为根据大根堆的要求可知，最大的值一定在堆顶
 
 */


- (void)maxHeapify:(NSMutableArray <NSNumber *> *)array Start:(NSInteger)start End:(NSInteger)end {
    
    NSInteger dad = start;
    NSInteger son = dad *2 +1;
    while (son < end) {
        
        if (son +1 < end && [array[son]integerValue] < [array[son +1]integerValue]) {
            son ++;
        }
        if ([array[dad]integerValue] > [array[son]integerValue]) {
            return;
        }else {
            [array exchangeObjectAtIndex:son withObjectAtIndex:dad];
            dad = son;
            son = dad *2 +1;
        }
        
    }
    
    

}

- (NSMutableArray *)heapSortArray:(NSMutableArray *)array {
    NSInteger count = array.count;
    NSInteger i;
    for (i =count/2 -1 ; i>=0; i--) {
        [self maxHeapify:array Start:i End:count];
    }
    for (i = count-1; i>0; i--) {
        [array exchangeObjectAtIndex:0 withObjectAtIndex:i];
        [self maxHeapify:array Start:0 End:i];
    }

    
    return array;
}


#pragma mark -7 归并排序

/*
 归并排序是建立在归并操作上的一种有效的排序算法,该算法是采用分治法（Divide and Conquer）的一个非常典型的应用。将已有序的子序列合并，得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。若将两个有序表合并成一个有序表，称为二路归并。 归并过程为：比较a[i]和a[j]的大小，若a[i]≤a[j]，则将第一个有序表中的元素a[i]复制到r[k]中，并令i和k分别加上1；否则将第二个有序表中的元素a[j]复制到r[k]中，并令j和k分别加上1，如此循环下去，直到其中一个有序表取完，然后再将另一个有序表中剩余的元素复制到r中从下标k到下标t的单元。归并排序的算法我们通常用递归实现，先把待排序区间[s,t]以中点二分，接着把左边子区间排序，再把右边子区间排序，最后把左区间和右区间用一次归并操作合并成有序的区间[s,t]。

 */

- (void)mergeSortRecursive:(NSMutableArray *)arr RegArr:(NSMutableArray *)reg Start:(NSInteger)start End:(NSInteger)end {
    if (start >= end) {
        return;
    }
    NSInteger len = end- start;
    NSInteger mid = (len >>1) + start;
    NSInteger start1 = start;
    NSInteger end1 = mid;
    NSInteger start2 = mid +1;
    NSInteger end2 = end;
    
    [self mergeSortRecursive:arr RegArr:reg Start:start1 End:end1];
    [self mergeSortRecursive:arr RegArr:reg Start:start2 End:end2];
    NSInteger k = start;
    
    while (start1 <= end1 && start2 <= end2) {
        reg[k++] = arr[start1] < arr[start2] ? arr[start1++] : arr[start2++];
    }
    while (start1 <= end1) {
        reg[k++] = arr[start1 ++];
    }

    while (start2 <= end2) {
        reg[k++] = arr[start2++];
    }
    for (k=start; k<=end; k++) {
        arr[k] = reg[k];
    }
    
}

- (NSMutableArray *)mergeSortArray:(NSMutableArray <NSNumber *>*)array {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];

    NSMutableArray *reg = [NSMutableArray arrayWithCapacity:0];
    [self mergeSortRecursive:arr RegArr:reg Start:0 End:arr.count-1];
    
    return arr;
}


#pragma mark -8 基数排序
/*
 基数排序（radix sort）属于“分配式排序”（distribution sort），又称“桶子法”（bucket sort）或bin sort，顾名思义，它是透过键值的部份资讯，将要排序的元素分配至某些“桶”中，藉以达到排序的作用，基数排序法是属于稳定性的排序，其时间复杂度为O (nlog(r)m)，其中r为所采取的基数，而m为堆数，在某些时候，基数排序法的效率高于其它的稳定性排序法。
 */





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
