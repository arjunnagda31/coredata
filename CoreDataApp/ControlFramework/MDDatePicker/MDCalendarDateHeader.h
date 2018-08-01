// The MIT License (MIT)
//
// Copyright (c) 2015 FPT Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#ifndef iOSUILib_MDCalendarHeader_h
#define iOSUILib_MDCalendarHeader_h

#import <UIKit/UIKit.h>

@protocol MDCalendarDateHeaderDelegate
- (void)didSelectCalendar;
- (void)didSelectYear;
@end

typedef NS_OPTIONS(NSInteger, MDCalendarTheme);

NS_ASSUME_NONNULL_BEGIN
@interface MDCalendarDateHeader : UIView

typedef NS_OPTIONS(NSInteger, MDCalendarMonthSymbolsFormat) {
    MDCalendarMonthSymbolsFormatShort = 0,
    MDCalendarMonthSymbolsFormatFull = 1,
    MDCalendarMonthSymbolsFormatShortUppercase = 2,
    MDCalendarMonthSymbolsFormatFullUppercase = 3
};

@property(nonatomic, strong) UILabel* labelDayName;
@property(nonatomic, strong) UILabel* labelMonthName;
@property(nonatomic, strong) UILabel* labelDate;
@property(nonatomic, strong) UILabel* labelYear;

@property(assign, nonatomic) MDCalendarTheme theme;
@property(nonatomic, strong) UIColor* textColor;
@property(nonatomic, strong) UIColor* headerColor;
@property(nonatomic, strong) UIColor* headerBackgroundColor;

@property(nonatomic) MDCalendarMonthSymbolsFormat monthFormat;
@property(nonatomic, strong) NSDate* date;
@property(nonatomic, strong) NSDateFormatter* dateFormatter;
@property(weak, nonatomic) id<MDCalendarDateHeaderDelegate> delegate;

- (void)showYearSelector;
- (void)showCalendar;
@end
NS_ASSUME_NONNULL_END
#endif
