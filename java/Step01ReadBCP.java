package org.example;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Step01ReadBCP {

    static String filePath= "D:\\gs\\Desktop\\STOCK\\old\\tbl_stk_pd1";
    static private String separetor = "\t";
    static String dateFormatStr = "yyyy-MM-dd";// "MMM d yyyy"

    static Map<Float,Integer> symbolIdx = new HashMap<Float,Integer>();
    static Map<Float,Integer> dateIdx = new HashMap<Float,Integer>();

    static float[][][] data = new float[4000][5000][7];

    public static void main(String[] args) {

        System.out.println(convertDateStringToFloat("Nov 12 2016"));

        try {
            java.io.File file = new java.io.File(filePath);

            LineIterator iterator = FileUtils.lineIterator(file, "UTf-8");
            while (iterator.hasNext()) {
                String inputText = iterator.nextLine();
                String[] tokens = inputText.split(separetor);
                System.out.println(convertDateStringToFloat(tokens[1]));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 输入的float日期数组
        Float[] floatDates = {21201f, 161102f, 230101f, 970113f};

        Arrays.sort(floatDates, new Step01ReadBCP.CustomDateComparator());

        for (float date : floatDates) {
            System.out.println(date);
        }
    }

    private static float convertDateStringToFloat(String dateString) {

        dateString.replaceAll(" {2}", " ");

        try {

                SimpleDateFormat sdf = new SimpleDateFormat(dateFormatStr, Locale.ENGLISH);
                Date date = sdf.parse(dateString);

                SimpleDateFormat sdfOutput = new SimpleDateFormat("yyMMdd");
                String formattedDate = sdfOutput.format(date);

                return Float.parseFloat(formattedDate);

        } catch (ParseException ignored) {
        }

        return 0.0f;
    }

    static class CustomDateComparator implements Comparator<Float> {
        @Override
        public int compare(Float date1, Float date2) {
            // 提取年份
            int year1 = getYear(date1);
            int year2 = getYear(date2);

            // 按年份比较
            if (year1 != year2) {
                return Integer.compare(year1, year2);
            }

            // 年份相同时，按照原始float值比较
            return Float.compare(date1, date2);
        }

        private int getYear(float date) {
            int yearPrefix = (int) (date / 10000); // 取前三位
            if (yearPrefix >= 70 && yearPrefix <= 99) {
                return 1900 + yearPrefix;
            } else {
                return 2000 + yearPrefix;
            }
        }
    }
}