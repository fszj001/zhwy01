package com.fszj.utils;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateDiff {

    static int[] getDiff(LocalDate start, LocalDate end) {

        if (!start.isBefore(end)) {
            throw new IllegalArgumentException("Start must not be before end.");
        }

        int year1 = start.getYear();
        int month1 = start.getMonthValue();
        int day1 = start.getDayOfMonth();

        int year2 = end.getYear();
        int month2 = end.getMonthValue();
        int day2 = end.getDayOfMonth();

        int yearDiff = year2 - year1;     // yearDiff >= 0
        int monthDiff = month2 - month1;

        int dayDiff = day2 - day1;

        if (dayDiff < 0) {
            LocalDate endMinusOneMonth = end.minusMonths(1);   // end 的上一个月
            int monthDays = endMinusOneMonth.lengthOfMonth();  // 该月的天数

            dayDiff += monthDays;  // 用上一个月的天数补上这个月差掉的日子

            if (monthDiff > 0) {   // eg. start is 2018-04-03, end is 2018-08-01
                monthDiff--;

            } else {  // eg. start is 2018-04-03, end is 2019-02-01
                monthDiff += 11;
                yearDiff--;

            }
        }

        int[] diff = new int[2];

        diff[0] = yearDiff * 12 + monthDiff;
        diff[1] = dayDiff;

        return diff;
    }

    public static void main(String[] args) {
        LocalDate startDate = LocalDate.of(2018, 4, 3);

        LocalDate[] endDates = {
                LocalDate.of(2018, 4, 5),
                LocalDate.of(2018, 10, 6),
                LocalDate.of(2019, 4, 5),
                LocalDate.of(2019, 10, 6),
                LocalDate.of(2019, 3, 3),
                LocalDate.of(2019, 3, 1),
                LocalDate.of(2019, 2, 1),
                LocalDate.of(2019, 2, 2),
        };

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (LocalDate end : endDates) {
            int[] diff = getDiff(startDate, end);
            System.out.printf("%s - %s = %2d 个月零 %-2d 天\n",
                    formatter.format(end), formatter.format(startDate), diff[0], diff[1]);
        }
    }
}