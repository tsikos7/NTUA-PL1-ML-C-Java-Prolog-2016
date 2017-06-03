//
//  main.c
//  simple solution
//
//  Created by Konstantinos Mitropoulos on 30/4/2016.
//  Copyright (c) 2016 NTUA. All rights reserved.
//

#include <stdio.h>
#include <math.h>
#include <time.h>
#include <string.h>
clock_t start, endofclock;
double cpu_time_used;

int reverse(char *a, int n)
{
    int c, d;
    char  b[100002];
    
    
    for (c = n - 1, d = 0; c >= 0; c--, d++)
        b[d] = a[c];
    
  
    
    for (c = 0; c < n; c++)
        a[c] = b[c];
    
    
    
    return 0;
}



int main(int argc, const char * argv[]) {
    start = clock();
    int j = 0, k = 0,count = 0;
    
    FILE *f;
    f = fopen(argv[1], "r");
    
    for (j = 0; j < 1; j++)  {
        
        int i = 0, len = 0;
        char c;
        char num[100002] = "", out[100002] = "";
        
        
        while ((c = fgetc(f)) != '\n'){         // newline before EOF
            
            num[i++] = c;
            len++;
        }
        num[i] = '\0';
        i = 0;
        if (strcmp(num, "0") == 0) {count++; fprintf(stdout, "0\n"); continue;}
        else if (strcmp(num, "1") == 0) {fprintf(stdout, "0\n"); continue;}
        int crr = 1;
        int previoussituation = 0;
        int end = 0;
        
        ////////////////////////////////////////////////                ////////////////////////////////////////////////
        
        
        
        if (num[0] == '1') {          //case where MSD is 1
            //do shit
            
            if (len % 2 == 1) {                                 //case with odd number of digits
                
                for (i = 0; i < len/2; i++) {
                    // Situation 1
                    if (num[i + 1] == num[len - 1 - i])   {
                        
                        if (previoussituation == 0) {
                            if (num[i + 1] == '9' && num[len - i - 1] == '9') continue;
                            out[i] = 9 + '0';
                            out[len - 2 - i] = num[len - 1 - i] + 1;
                            if (num[len - 1 - i] == '9') out[len - 2 - i] = '0';
                            crr = 1;
                        }
                        
                        else if (previoussituation == 1) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                out[len - 2 - i] = 9 + '0';
                                crr = 1;
                            }
                            
                        }
                        
                        else if (previoussituation == 2) {
                            
                            if (crr == 0)   {
                                out[i] = num[len - 1 - i] + 1;
                                if (num[len - 1 - i] == '9') out[i] = '0';
                                out[len - 2 - i] = 9 + '0';
                                crr = 1;
                                
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                //if (num[len - 1 - i] == '9') out[i] = '0';
                                out[len - i - 2] = 9 + '0';
                                crr = 1;
                            }
                        }
                        
                        
                        else if (previoussituation == 3) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                        }
                        
                        
                        previoussituation = 1;
                    }
                    // Situation 2
                    else if (num[i + 1] == num[len - 1 - i] + 1 || (num[i + 1] == '0' && num[len - 1 - i] == '9')) {
                        
                        if (previoussituation == 0) {
                            out[i] = 9 + '0';
                            out[len - 2 - i] = num[len - 1 - i] + 1;
                            if (num[len - 1 - i] == '9') out[len - 2 - i] = '0';
                            crr = 1;
                        }
                        
                        else if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                crr = 0;
                            }
                        }
                        // 2001010991
                        // 0001009991
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                if (num[len - 1 - i] != '9') {
                                    out[i] = num[len - 1 - i] + 1;
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 1;/////2221111 0215991            22200111 02000091
                                }
                                else {
                                    
                                    out[i] = '0';
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 0;/////2221111 0215991            22200111 02000091
                                    
                                }
                                
                            }
                            else {
                                if (num[len - i] =='9')  {
                                    
                                    out[i] = num[len - 1 - i] + 1;
                                    if (num[len - 1 - i] == '9') out[i] = '0';
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 1;
                                }
                                else {
                                    out[i] = num[len - 1 - i];
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 1;
                                }
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {                       //221021011112 --->  002001910912
                                out[i] = '0';
                                out[len - 2 - i] = num[i + 1] - 1;
                                crr = 0;
                            }
                            else {
                                //99% oxi last chance auto
                            }
                        }
                        
                        
                        previoussituation = 2;
                    }
                    
                    
                    
                    // Situation 3
                    else if (num[i + 1] == num[len - 1 - i] - 1 || (num[i + 1] == '9' && num[len - 1 - i] == '0')) {
                        if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                out[i-1] = num[len - i] + 1;
                                if (num[len - i] == '9') out[i - 1] = '0';
                                out[len - 1 - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                crr = 0;
                            }
                        }
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                //i think nothing 1 0 1 0 --->  1 0 0 9
                            }
                            else {
                                out[len - 2 - i] = '9';
                                out[i] = num[len - 1 - i];
                                
                                crr = 1;
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                out[i-1] = num[len - i];
                                out[len - 1 - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - i] == '0') out[len - 2 - i] = '9';
                                out[i] = 0 + '0';
                                crr = 0;
                            }
                        }
                        
                        previoussituation = 3;
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    ////////////////////////////////////////////////                ////////////////////////////////////////////////
                    
                    
                }
            }
            else    {                                           //case with even number of digits
                
                for (i = 0; i < len/2; i++) {
                    // Situation 1
                    if (num[i + 1] == num[len - 1 - i])   {
                        
                        if (previoussituation == 0) {
                            if (num[i + 1] == '9' && num[len - i - 1] == '9') continue;
                            out[i] = 9 + '0';
                            out[len - 2 - i] = num[len - 1 - i] + 1;
                            if (num[len - 1 - i] == '9') out[len - 2 - i] = '0';
                            crr = 1;
                        }
                        
                        else if (previoussituation == 1) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                out[len - 2 - i] = 9 + '0';
                                crr = 1;
                            }
                            
                        }
                        
                        else if (previoussituation == 2) {
                            
                            if (crr == 0)   {
                                out[i] = num[len - 1 - i] + 1;
                                if (num[len - 1 - i] == '9') out[i] = '0';
                                out[len - 2 - i] = 9 + '0';
                                crr = 1;
                                
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                //if (num[len - 1 - i] == '9') out[i] = '0';
                                out[len - 2 - i] = 9 + '0';
                                crr = 1;
                            }
                        }
                        
                        
                        else if (previoussituation == 3) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                        }
                        
                        if (i == (len - 1)/2) {
                            if (previoussituation == 1) {
                                if (crr == 0)   {
                                    
                                }
                                else {
                                    if (num[len/2]%2 == 0)   {
                                        
                                        out[i - 1] = '0';
                                        out[len - 1 - i] = num[len - i] - 1;
                                        if (num[len - i] == '0') out[len - 1 - i] = '9';
                                    }
                                }
                            }
                        }
                        previoussituation = 1;
                    }
                    // Situation 2
                    else if (num[i + 1] == num[len - 1 - i] + 1 || (num[i + 1] == '0' && num[len - 1 - i] == '9')) {
                        
                        if (previoussituation == 0) {
                            out[i] = 9 + '0';
                            out[len - 2 - i] = num[len - 1 - i] + 1;
                            crr = 1;
                            if (num[len - 1 - i] == '9') {out[len - 2 - i] = '0'; crr = 0;}
                            
                        }
                        
                        else if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else {			//
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                crr = 0;
                            }
                        }
                        // 2001010991
                        // 0001009991
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                if (num[len - 1 - i] != '9') {
                                    out[i] = num[len - 1 - i] + 1;
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 1;/////2221111 0215991            22200111 02000091
                                }
                                else {
                                    
                                    out[i] = '0';
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 0;/////2221111 0215991            22200111 02000091
                                    
                                }
                                
                            }
                            else {
                                if (num[len - i] =='9')  {
                                    
                                    out[i] = num[len - 1 - i] + 1;
                                    if (num[len - 1 - i] == '9') out[i] = '0';
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 1;
                                }
                                else {
                                    out[i] = num[len - 1 - i];
                                    out[len - 2 - i] = 9 + '0';
                                    crr = 1;
                                }
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {                       //221021011112 --->  002001910912
                                out[i] = '0';
                                out[len - 2 - i] = num[i + 1] - 1;
                                crr = 0;
                            }
                            else {
                                //99% oxi last chance auto
                            }
                        }
                        
                        
                        previoussituation = 2;
                    }
                    
                    
                    
                    // Situation 3
                    else if (num[i + 1] == num[len - 1 - i] - 1 || (num[i + 1] == '9' && num[len - 1 - i] == '0')) {
                        if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                out[i-1] = num[len - i] + 1;
                                if (num[len - i] == '9') out[i - 1] = '0';
                                out[len - 1 - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                crr = 0;
                            }
                        }
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                //i think nothing 1 0 1 0 --->  1 0 0 9
                            }
                            else {
                                out[len - 2 - i] = '9';
                                out[i] = num[len - 1 - i];
                                
                                crr = 1;
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                out[i-1] = num[len - i];
                                out[len - 1 - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[len - 2 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 2 - i] = '9';
                                out[i] = 0 + '0';
                                crr = 0;
                            }
                        }
                        
                        previoussituation = 3;
                    }
                }
            }
            
            
            
            ///////////////////////////////////// checking
            for (k = 0; k < 1; k++)  {
                int check = 0;
                int temp = -1;
                int temp2 = -1;
                int crr2 = 0;
                
                if (len%2 == 0) {
                    temp = num[len/2] - 48;
                    temp = temp/2;
                    out[len/2 - 1] = temp + '0';
                    temp = -1;
                    
                    for (i = 0; i < len - 1; i++) {
                        temp2 = out[i] + out[len - i - 2] - 96 + crr2;
                        temp = temp2%10;
                        if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                        crr2 = 0;
                        if (temp2 > 9) crr2 = 1;
                    }
                    
                    if (check == 1) {end = 1;}
                    
                    
                    if (end == 0 && (out[0] != '0' || out[len - 2] != '0') && (num[len/2 - 1] <= num[len/2 + 1] || (num[len/2 - 1] =='9' && num[len/2 + 1] == '0')))   {
                        fprintf(stdout, "%s\n", out);
                        count++;
                        break;
                    }
                    
                    
                    check = 0;
                    temp = -1;
                    temp2 = -1;
                    crr2 = 0;
                    end = 0;
                    
                    temp = num[len/2] - 38;
                    temp = temp/2;
                    out[len/2 - 1] = temp + '0';
                    temp = -1;
                    
                    
                    for (i = 0; i < len - 1; i++) {
                        temp2 = out[i] + out[len - i - 2] - 96 + crr2;
                        temp = temp2%10;
                        if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                        crr2 = 0;
                        if (temp2 > 9) crr2 = 1;
                    }
                    
                    if (check == 1) {end = 1;}
                    
                    
                    if (end == 0 && (out[0] != '0' || out[len - 2] != '0'))   {
                        fprintf(stdout, "%s\n", out);
                        count++;
                        break;
                    }
                    
                    
                    
                    check = 0;
                    temp = -1;
                    temp2 = -1;
                    crr2 = 0;
                    end = 0;
                    temp = num[len/2] - 49;
                    temp = temp/2;
                    out[len/2 - 1] = temp + '0';
                    temp = -1;
                    
                    
                    for (i = 0; i < len - 1; i++) {
                        temp2 = out[i] + out[len - i - 2] - 96 + crr2;
                        temp = temp2%10;
                        if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                        crr2 = 0;
                        if (temp2 > 9) crr2 = 1;
                    }
                    
                    if (check == 1) {end = 1;}
                    
                    
                    if (end == 0 && (out[0] != '0' || out[len - 2] != '0') && (num[len/2 - 1] <= num[len/2 + 1] || (num[len/2 - 1] =='9' && num[len/2 + 1] == '0')))   {
                        fprintf(stdout, "%s\n", out);
                        count++;
                        break;
                    }
                    
                    
                    
                    
                    check = 0;
                    temp = -1;
                    temp2 = -1;
                    crr2 = 0;
                    end = 0;
                    
                    temp = num[len/2] - 39;
                    temp = temp/2;
                    out[len/2 - 1] = temp + '0';
                    temp = -1;
                    
                    
                    for (i = 0; i < len - 1; i++) {
                        temp2 = out[i] + out[len - i - 2] - 96 + crr2;
                        temp = temp2%10;
                        if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                        crr2 = 0;
                        if (temp2 > 9) crr2 = 1;
                    }
                    
                    if (check == 1) {end = 1;}
                    
                    
                    if (end == 0 && (out[0] != '0' || out[len - 2] != '0'))   {
                        fprintf(stdout, "%s\n", out);
                        count++;
                        break;
                    }
                    
                    
                    
                }
                else {
                    
                    for (i = 0; i < len - 1; i++) {
                        temp2 = out[i] + out[len - i - 2] - 96 + crr2;
                        temp = temp2%10;
                        if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                        crr2 = 0;
                        if (temp2 > 9) crr2 = 1;
                    }
                    
                    if (check == 1) {end = 1;}
                    
                    
                    if (end == 0 && (out[0] != '0' || out[len - 2] != '0'))   {
                        fprintf(stdout, "%s\n", out);
                        count++;
                        break;
                    }
                    
                    
                    
                    
                }
                //else
                
                
                 //out[i] = 0 + '0';
                   //  out[len - 2 - i] = num[len - 1 - i];
                
                
            }
            
            if (end == 0) continue;
            
        }
        // if (end == 0) continue;
        previoussituation = 0;
        end = 0;
        crr = 0;
        for (k = 0; k < 100000; k++) out[k] = '\0';
        
        
        if (1 == 1)  {                   //case where MSD is not 1
            if (len % 2 == 0) {                                 //case with even number of digits
                
                for (i = 0; i < len/2; i++) {
                    // Situation 1
                    if (num[i] == num[len - 1 - i])   {
                        
                        if (previoussituation == 0) {
                            out[i] = 0 + '0';
                            out[len - 1 - i] = num[len - 1 - i];
                            crr = 0;
                        }
                        
                        else if (previoussituation == 1) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                out[len - 1 - i] = 9 + '0';
                                crr = 1;
                            }
                            
                        }
                        
                        else if (previoussituation == 2) {
                            
                            if (crr == 0)   {
                                out[i] = num[len - 1 - i] + 1;
                                if (num[len - 1 - i] == '9') out[i] = '0';
                                out[len - 1 - i] = 9 + '0';
                                crr = 1;
                                
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                out[len - 1 - i] = 9 + '0';
                                crr = 1;
                            }
                        }
                        
                        
                        else if (previoussituation == 3) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                        }
                        
                        
                        previoussituation = 1;
                    }
                    // Situation 2
                    else if (num[i] == num[len - 1 - i] + 1 || (num[i] == '0' && num[len - 1 - i] == '9')) {
                        
                        if (previoussituation == 0) {
                            out[i] = 0 + '0';
                            out[len - 1 - i] = num[len - 1 - i];
                            crr = 0;
                        }
                        
                        else if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - i - 1] = '9';
                                crr = 0;
                            }
                        }
                        // 2001010991
                        // 0001009991
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                if (num[len - 1 - i] != '9') {
                                    out[i] = num[len - 1 - i] + 1;
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 1;/////2221111 0215991            22200111 02000091
                                }
                                else {
                                    
                                    out[i] = '0';
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 0;/////2221111 0215991            22200111 02000091
                                    
                                }
                                
                            }
                            else {
                                if (num[len - i] =='9')  {
                                    
                                    out[i] = num[len - 1 - i] + 1;
                                    if (num[len - 1 - i] == '9') out[i] = '0';
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 1;
                                }
                                else {
                                    out[i] = num[len - 1 - i];
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 1;
                                }
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {                       //221021011112 --->  002001910912
                                out[i] = '0';
                                out[len - i - 1] = num[i] - 1;
                                crr = 0;
                            }
                            else {
                                //99% oxi last chance auto
                            }
                        }
                        
                        
                        previoussituation = 2;
                    }
                    
                    
                    
                    // Situation 3
                    else if (num[i] == num[len - 1 - i] - 1 || (num[i] == '9' && num[len - 1 - i] == '0')) {
                        if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 1 - i] = '9';
                                out[i-1] = num[len - i] + 1;
                                if (num[len - i] == '9') out[i - 1] = '0';
                                out[len - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 1 - i] = '9';
                                crr = 0;
                            }
                        }
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                //i think nothing 1 0 1 0 --->  1 0 0 9
                            }
                            else {
                                out[len - 1 - i] = '9';
                                out[i] = num[len - 1 - i];
                                
                                crr = 1;
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - i - 1] = '9';
                                out[i-1] = num[len - i];
                                out[len - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - i - 1] = '9';
                                out[i] = 0 + '0';
                                crr = 0;
                            }
                        }
                        
                        previoussituation = 3;
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    ////////////////////////////////////////////////                ////////////////////////////////////////////////
                    
                    
                }
            }
            else    {                                           //case with odd number of digits
                
                for (i = 0; i < len/2 + 1; i++) {
                    // Situation 1
                    if (num[i] == num[len - 1 - i])   {
                        
                        if (previoussituation == 0) {
                            out[i] = 0 + '0';
                            out[len - 1 - i] = num[len - 1 - i];
                            crr = 0;
                        }
                        
                        else if (previoussituation == 1) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                out[len - 1 - i] = 9 + '0';
                                crr = 1;
                            }
                            
                        }
                        
                        else if (previoussituation == 2) {
                            
                            if (crr == 0)   {
                                out[i] = num[len - 1 - i] + 1;
                                if (num[len - 1 - i] == '9') out[i] = '0';
                                out[len - 1 - i] = 9 + '0';
                                crr = 1;
                                
                            }
                            else   {
                                out[i] = num[len - 1 - i];
                                //if (num[len - 1 - i] == '9') out[i] = '0';
                                out[len - 1 - i] = 9 + '0';
                                crr = 1;
                            }
                        }
                        
                        
                        else if (previoussituation == 3) {
                            
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                        }
                        
                        if (i == len/2) {
                            if (previoussituation == 1) {
                                if (crr == 0)   {
                                    
                                }
                                else {
                                    if (num[len/2]%2 == 0)   {
                                        
                                        out[i - 1] = '0';
                                        out[len - i] = num[len - i] - 1;
                                        if (num[len - i] == '0') out[len - i] = '9';
                                    }
                                }
                            }
                        }
                        previoussituation = 1;
                    }
                    // Situation 2
                    else if (num[i] == num[len - 1 - i] + 1 || (num[i] == '0' && num[len - 1 - i] == '9')) {
                        
                        if (previoussituation == 0) {
                            out[i] = 0 + '0';
                            out[len - 1 - i] = num[len - 1 - i];
                            crr = 0;
                        }
                        
                        else if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i];
                                crr = 0;
                            }
                            else {			//
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - i - 1] = '9';
                                crr = 0;
                            }
                        }
                        // 2001010991
                        // 0001009991
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                if (num[len - 1 - i] != '9') {
                                    out[i] = num[len - 1 - i] + 1;
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 1;/////2221111 0215991            22200111 02000091
                                }
                                else {
                                    
                                    out[i] = '0';
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 0;/////2221111 0215991            22200111 02000091
                                    
                                }
                                
                            }
                            else {
                                if (num[len - i] =='9')  {
                                    
                                    out[i] = num[len - 1 - i] + 1;
                                    if (num[len - 1 - i] == '9') out[i] = '0';
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 1;
                                }
                                else {
                                    out[i] = num[len - 1 - i];
                                    out[len - 1 - i] = 9 + '0';
                                    crr = 1;
                                }
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {                       //221021011112 --->  002001910912
                                out[i] = '0';
                                out[len - i - 1] = num[i] - 1;
                                crr = 0;
                            }
                            else {
                                //99% oxi last chance auto
                            }
                        }
                        
                        
                        previoussituation = 2;
                    }
                    
                    
                    
                    // Situation 3
                    else if (num[i] == num[len - 1 - i] - 1 || (num[i] == '9' && num[len - 1 - i] == '0')) {
                        if (previoussituation == 1)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 1 - i] = '9';
                                out[i-1] = num[len - i] + 1;
                                if (num[len - i] == '9') out[i - 1] = '0';
                                out[len - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - 1 - i] = '9';
                                crr = 0;
                            }
                        }
                        
                        else if (previoussituation == 2)   {
                            if (crr == 0)   {
                                //i think nothing 1 0 1 0 --->  1 0 0 9
                            }
                            else {
                                out[len - 1 - i] = '9';
                                out[i] = num[len - 1 - i];
                                
                                crr = 1;
                            }
                        }
                        
                        else if (previoussituation == 3)   {
                            if (crr == 0)   {
                                out[i] = 0 + '0';
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - i - 1] = '9';
                                out[i-1] = num[len - i];
                                out[len - i] = 9 + '0';
                                crr = 0;
                            }
                            else {
                                out[len - 1 - i] = num[len - 1 - i] - 1;
                                if (num[len - 1 - i] == '0') out[len - i - 1] = '9';
                                out[i] = 0 + '0';
                                crr = 0;
                            }
                        }
                        
                        previoussituation = 3;
                    }
                }
            }
            
            int check = 0;
            int temp = -1;
            int temp2 = -1;
            int crr2 = 0;
            
            if (len%2 == 1) {
                temp = num[len/2] - 48;
                temp = temp/2;
                out[len/2] = temp + '0';
                temp = -1;
                
                for (i = 0; i < len; i++) {
                    temp2 = out[i] + out[len - i - 1] - 96 + crr2;
                    temp = temp2%10;
                    if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                    crr2 = 0;
                    if (temp2 > 9) crr2 = 1;
                }
                
                if (check == 1 || out[0] > num[0]) {end = 1;}
                
                
                if (end == 0 && (out[0] != '0' || out[len - 1] != '0'))   {
                    if (out[0] == '0') reverse(out, len);
                    fprintf(stdout, "%s\n", out);
                    count++;
                    continue;
                }
                
                check = 0;
                temp = -1;
                temp2 = -1;
                crr2 = 0;
                end = 0;
                
                temp = num[len/2] - 38;
                temp = temp/2;
                out[len/2] = temp + '0';
                temp = -1;
                
                
                for (i = 0; i < len; i++) {
                    temp2 = out[i] + out[len - i - 1] - 96 + crr2;
                    temp = temp2%10;
                    if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                    crr2 = 0;
                    if (temp2 > 9) crr2 = 1;
                }
                
                if (check == 1 || out[0] > num[0]) {end = 1;}
                
                
                if (end == 0 && (out[0] != '0' || out[len - 1] != '0'))   {
                    if (out[0] == '0') reverse(out, len);
                    fprintf(stdout, "%s\n", out);
                    count++;
                    continue;
                }
                
                
                
                check = 0;
                temp = -1;
                temp2 = -1;
                crr2 = 0;
                end = 0;
                temp = num[len/2] - 49;
                temp = temp/2;
                out[len/2] = temp + '0';
                temp = -1;
                
                
                for (i = 0; i < len; i++) {
                    temp2 = out[i] + out[len - i - 1] - 96 + crr2;
                    temp = temp2%10;
                    if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                    crr2 = 0;
                    if (temp2 > 9) crr2 = 1;
                }
                
                if (check == 1 || out[0] > num[0]) {end = 1;}
                
                
                if (end == 0 && (out[0] != '0' || out[len - 1] != '0'))   {
                    if (out[0] == '0') reverse(out, len);
                    fprintf(stdout, "%s\n", out);
                    count++;
                    continue;
                }
                
                
                
                
                check = 0;
                temp = -1;
                temp2 = -1;
                crr2 = 0;
                end = 0;
                
                temp = num[len/2] - 39;
                temp = temp/2;
                out[len/2 ] = temp + '0';
                temp = -1;
                
                
                for (i = 0; i < len; i++) {
                    temp2 = out[i] + out[len - i - 1] - 96 + crr2;
                    temp = temp2%10;
                    if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                    crr2 = 0;
                    if (temp2 > 9) crr2 = 1;
                }
                
                if (check == 1 || out[0] > num[0])  {end = 1;}
                
                
                if (end == 0 && (out[0] != '0' || out[len - 1] != '0'))   {
                    if (out[0] == '0') reverse(out, len);
                    fprintf(stdout, "%s\n", out);
                    count++;
                    continue;
                }
                else fprintf(stdout, "0\n");
                
            }
            else {
                
                for (i = 0; i < len; i++) {
                    temp2 = out[i] + out[len - i - 1] - 96 + crr2;
                    temp = temp2%10;
                    if (num[len - 1 - i] != temp + '0') {check = 1;  break;}
                    crr2 = 0;
                    if (temp2 > 9) crr2 = 1;
                }
                
                if (check == 1 || out[0] > num[0]) {end = 1;}
                
                
                if (end == 0 && (out[0] != '0' || out[len - 1] != '0'))   {
                    if (out[0] == '0') reverse(out, len);
                    fprintf(stdout, "%s\n", out);
                    count++;
                }
                else fprintf(stdout, "0\n");
            }
    
        }
        
        
    }
    endofclock = clock();
    cpu_time_used = ((double) (endofclock - start)) / CLOCKS_PER_SEC;
    //fprintf(stdout, "Count: %llu\n", count);
    //fprintf(stdout, "Time Spent: %f\n", cpu_time_used);
    fclose(f);
    
    return 0;
    
    
}