package com.common;

import java.text.DecimalFormat;

public class NumberToWords{
         private static final String[] tens = {
                                                "",
                                                " Ten",
                                                " Twenty",
                                                " Thirty",
                                                " Forty",
                                                " Fifty",
                                                " Sixty",
                                                " Seventy",
                                                " Eighty",
                                                " Ninety"
          };

          private static final String[] numbers = {
                                                "",
                                                " One",
                                                " Two",
                                                " Three",
                                                " Four",
                                                " Five",
                                                " Six",
                                                " Seven",
                                                " Eight",
                                                " Nine",
                                                " Ten",
                                                " Eleven",
                                                " Twelve",
                                                " Thirteen",
                                                " Fourteen",
                                                " Fifteen",
                                                " Sixteen",
                                                " Seventeen",
                                                " Eighteen",
                                                " Nineteen"
          };

          private static String convertNumberLessThanOneThousand(int number) {
            String rest;

            if (number % 100 < 20){
              rest = numbers[number % 100];
              number /= 100;
            }
            else {
              rest = numbers[number % 10];
              number /= 10;

              rest = tens[number % 10] + rest;
              number /= 10;
            }
            if (number == 0) return rest;
            return numbers[number] + " Hundred" + rest;
          }


          public static String convertNumber(long number) {
            if (number == 0) { return "Zero"; }

            String snumber = Long.toString(number);

            String zeroMask = "000000000000";
            DecimalFormat df = new DecimalFormat(zeroMask);
            snumber = df.format(number);

            int billions = Integer.parseInt(snumber.substring(0,3));
            int millions  = Integer.parseInt(snumber.substring(3,6)); 
            int hundredThousands = Integer.parseInt(snumber.substring(6,9)); 
            int thousands = Integer.parseInt(snumber.substring(9,12));    

            String billionsString;
            switch (billions) {
            case 0:
                billionsString = "";
              break;
            case 1 :
                billionsString = convertNumberLessThanOneThousand(billions) 
              + " billion ";
              break;
            default :
                billionsString = convertNumberLessThanOneThousand(billions) 
              + " billion ";
            }
            String result =  billionsString;

            String millionsString;
            switch (millions) {
            case 0:
                millionsString = "";
              break;
            case 1 :
                millionsString = convertNumberLessThanOneThousand(millions) 
              + " million ";
              break;
            default :
                millionsString = convertNumberLessThanOneThousand(millions) 
              + " million ";
            }
            result =  result + millionsString;

            String hundredThousandsString;
            switch (hundredThousands) {
            case 0:
                hundredThousandsString = "";
              break;
            case 1 :
                hundredThousandsString = "One Thousand ";
              break;
            default :
                hundredThousandsString = convertNumberLessThanOneThousand(hundredThousands) 
              + " Thousand ";
            }
            result =  result + hundredThousandsString;

            String thousandString;
            thousandString = convertNumberLessThanOneThousand(thousands);
            result =  result + thousandString;

            return result.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
          }
		  }