EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:tinkerforge
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Ambient Light Bricklet"
Date "18 jan 2013"
Rev "1.2"
Comp "Tinkerforge GmbH"
Comment1 "Licensed under CERN OHL v.1.1"
Comment2 "Copyright (©) 2013, B.Nordmeyer <bastian@tinkerforge.com>"
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 550  7200 0    40   ~ 0
Copyright Tinkerforge GmbH 2013.\nThis documentation describes Open Hardware and is licensed under the\nCERN OHL v. 1.1.\nYou may redistribute and modify this documentation under the terms of the\nCERN OHL v.1.1. (http://ohwr.org/cernohl). This documentation is distributed\nWITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF\nMERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A\nPARTICULAR PURPOSE. Please see the CERN OHL v.1.1 for applicable\nconditions\n
NoConn ~ 4000 3100
Wire Wire Line
	4150 3050 4150 3300
Wire Wire Line
	4150 3300 4000 3300
Wire Wire Line
	7700 4450 7700 4400
Wire Wire Line
	7300 4450 7300 4400
Wire Wire Line
	4000 3900 4350 3900
Wire Wire Line
	7500 3850 7500 3900
Wire Wire Line
	5150 4650 5150 4550
Connection ~ 7700 3850
Wire Wire Line
	7700 3900 7700 3800
Wire Wire Line
	5150 4850 5600 4850
Wire Wire Line
	4000 3500 4350 3500
Connection ~ 4250 4950
Wire Wire Line
	4250 4750 4350 4750
Wire Wire Line
	4350 4850 4150 4850
Wire Wire Line
	4150 4850 4150 3600
Wire Wire Line
	4150 3600 4000 3600
Wire Wire Line
	3550 4250 3550 4150
Wire Wire Line
	4250 4950 4350 4950
Wire Wire Line
	4250 5050 4250 4650
Wire Wire Line
	4250 4650 4350 4650
Connection ~ 4250 4750
Wire Wire Line
	4000 3400 4350 3400
Wire Wire Line
	5150 4950 5600 4950
Wire Wire Line
	4000 3700 4350 3700
Wire Wire Line
	7700 3400 7700 3350
Wire Wire Line
	5600 4550 5600 4650
Wire Wire Line
	5150 4550 5200 4550
Connection ~ 5150 4550
Wire Wire Line
	4000 3800 4350 3800
Wire Wire Line
	7300 3850 8200 3850
Wire Wire Line
	7300 3850 7300 3900
Connection ~ 7500 3850
Wire Wire Line
	7500 4450 7500 4400
Wire Wire Line
	4000 4000 4350 4000
Wire Wire Line
	4000 3200 4250 3200
Wire Wire Line
	4250 3200 4250 3350
Text GLabel 4350 4000 2    60   Output ~ 0
OUT_3
$Comp
L R R1
U 1 1 4D37E80B
P 7300 4150
F 0 "R1" V 7380 4150 50  0000 C CNN
F 1 "68k" V 7300 4150 50  0000 C CNN
F 2 "0603" H 7300 4150 60  0001 C CNN
F 3 "" H 7300 4150 60  0001 C CNN
	1    7300 4150
	1    0    0    -1  
$EndComp
Text GLabel 7300 4450 3    60   Input ~ 0
OUT_3
Text GLabel 7500 4450 3    60   Input ~ 0
OUT_2
Text GLabel 7700 4450 3    60   Input ~ 0
OUT_1
Text GLabel 4350 3900 2    60   Output ~ 0
OUT_2
Text GLabel 4350 3800 2    60   Output ~ 0
OUT_1
$Comp
L R R2
U 1 1 4D37E7C6
P 7500 4150
F 0 "R2" V 7580 4150 50  0000 C CNN
F 1 "47k" V 7500 4150 50  0000 C CNN
F 2 "0603" H 7500 4150 60  0001 C CNN
F 3 "" H 7500 4150 60  0001 C CNN
	1    7500 4150
	1    0    0    -1  
$EndComp
NoConn ~ 5150 4750
$Comp
L GND #PWR6
U 1 1 4CE147DC
P 5600 4650
F 0 "#PWR6" H 5600 4650 30  0001 C CNN
F 1 "GND" H 5600 4580 30  0001 C CNN
F 2 "" H 5600 4650 60  0001 C CNN
F 3 "" H 5600 4650 60  0001 C CNN
	1    5600 4650
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4CE147C5
P 5400 4550
F 0 "C1" V 5200 4550 50  0000 L CNN
F 1 "100nF" V 5550 4550 50  0000 L CNN
F 2 "0603" H 5400 4550 60  0001 C CNN
F 3 "" H 5400 4550 60  0001 C CNN
	1    5400 4550
	0    1    1    0   
$EndComp
$Comp
L DRILL U3
U 1 1 4C692B9B
P 10600 6350
F 0 "U3" H 10650 6400 60  0001 C CNN
F 1 "DRILL" H 10600 6350 60  0000 C CNN
F 2 "DRILL_NP" H 10600 6350 60  0001 C CNN
F 3 "" H 10600 6350 60  0001 C CNN
	1    10600 6350
	1    0    0    -1  
$EndComp
$Comp
L DRILL U2
U 1 1 4C692B9A
P 10600 6150
F 0 "U2" H 10650 6200 60  0001 C CNN
F 1 "DRILL" H 10600 6150 60  0000 C CNN
F 2 "DRILL_NP" H 10600 6150 60  0001 C CNN
F 3 "" H 10600 6150 60  0001 C CNN
	1    10600 6150
	1    0    0    -1  
$EndComp
$Comp
L DRILL U4
U 1 1 4C692B98
P 10900 6150
F 0 "U4" H 10950 6200 60  0001 C CNN
F 1 "DRILL" H 10900 6150 60  0000 C CNN
F 2 "DRILL_NP" H 10900 6150 60  0001 C CNN
F 3 "" H 10900 6150 60  0001 C CNN
	1    10900 6150
	1    0    0    -1  
$EndComp
$Comp
L DRILL U5
U 1 1 4C692B94
P 10900 6350
F 0 "U5" H 10950 6400 60  0001 C CNN
F 1 "DRILL" H 10900 6350 60  0000 C CNN
F 2 "DRILL_NP" H 10900 6350 60  0001 C CNN
F 3 "" H 10900 6350 60  0001 C CNN
	1    10900 6350
	1    0    0    -1  
$EndComp
Text GLabel 8200 3850 2    60   Output ~ 0
IN_1
$Comp
L VCC #PWR7
U 1 1 4C692AFC
P 7700 3350
F 0 "#PWR7" H 7700 3450 30  0001 C CNN
F 1 "VCC" H 7700 3450 30  0000 C CNN
F 2 "" H 7700 3350 60  0001 C CNN
F 3 "" H 7700 3350 60  0001 C CNN
	1    7700 3350
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 4C692AEE
P 7700 4150
F 0 "R3" V 7780 4150 50  0000 C CNN
F 1 "10k" V 7700 4150 50  0000 C CNN
F 2 "0603" H 7700 4150 60  0001 C CNN
F 3 "" H 7700 4150 60  0001 C CNN
	1    7700 4150
	1    0    0    -1  
$EndComp
$Comp
L OPTO_NPN Q1
U 1 1 4C692AE1
P 7600 3600
F 0 "Q1" H 7750 3650 50  0000 L CNN
F 1 "TEMT6000" H 7750 3500 50  0000 L CNN
F 2 "TEMT6000" H 7600 3600 60  0001 C CNN
F 3 "" H 7600 3600 60  0001 C CNN
	1    7600 3600
	1    0    0    -1  
$EndComp
Text GLabel 4350 3700 2    60   Input ~ 0
IN_1
Text GLabel 5600 4950 2    60   Input ~ 0
SDA
Text GLabel 5600 4850 2    60   Input ~ 0
SCL
Text GLabel 4350 3500 2    60   Output ~ 0
SDA
Text GLabel 4350 3400 2    60   Output ~ 0
SCL
$Comp
L VCC #PWR5
U 1 1 4C5FD35E
P 5150 4550
F 0 "#PWR5" H 5150 4650 30  0001 C CNN
F 1 "VCC" H 5150 4650 30  0000 C CNN
F 2 "" H 5150 4550 60  0001 C CNN
F 3 "" H 5150 4550 60  0001 C CNN
	1    5150 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR4
U 1 1 4C5FD34E
P 4250 5050
F 0 "#PWR4" H 4250 5050 30  0001 C CNN
F 1 "GND" H 4250 4980 30  0001 C CNN
F 2 "" H 4250 5050 60  0001 C CNN
F 3 "" H 4250 5050 60  0001 C CNN
	1    4250 5050
	1    0    0    -1  
$EndComp
$Comp
L CAT24C U1
U 1 1 4C5FD337
P 4750 5050
F 0 "U1" H 4600 5550 60  0000 C CNN
F 1 "M24C64" H 4750 5050 60  0000 C CNN
F 2 "TSSOP8" H 4750 5050 60  0001 C CNN
F 3 "" H 4750 5050 60  0001 C CNN
	1    4750 5050
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR2
U 1 1 4C5FCFB4
P 4150 3050
F 0 "#PWR2" H 4150 3150 30  0001 C CNN
F 1 "VCC" H 4150 3150 30  0000 C CNN
F 2 "" H 4150 3050 60  0001 C CNN
F 3 "" H 4150 3050 60  0001 C CNN
	1    4150 3050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR3
U 1 1 4C5FCF5E
P 4250 3350
F 0 "#PWR3" H 4250 3350 30  0001 C CNN
F 1 "GND" H 4250 3280 30  0001 C CNN
F 2 "" H 4250 3350 60  0001 C CNN
F 3 "" H 4250 3350 60  0001 C CNN
	1    4250 3350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR1
U 1 1 4C5FCF4F
P 3550 4250
F 0 "#PWR1" H 3550 4250 30  0001 C CNN
F 1 "GND" H 3550 4180 30  0001 C CNN
F 2 "" H 3550 4250 60  0001 C CNN
F 3 "" H 3550 4250 60  0001 C CNN
	1    3550 4250
	1    0    0    -1  
$EndComp
$Comp
L CON-SENSOR P1
U 1 1 4C5FCF27
P 3550 3550
F 0 "P1" H 3300 4100 60  0000 C CNN
F 1 "CON-SENSOR" V 3700 3550 60  0000 C CNN
F 2 "CON-SENSOR" H 3550 3550 60  0001 C CNN
F 3 "" H 3550 3550 60  0001 C CNN
	1    3550 3550
	-1   0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 50F951B8
P 8050 4150
F 0 "C2" V 7900 4150 50  0000 L CNN
F 1 "DNP" V 8200 4150 50  0000 L CNN
F 2 "0805" H 8050 4150 60  0001 C CNN
F 3 "" H 8050 4150 60  0001 C CNN
	1    8050 4150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR8
U 1 1 50F951C8
P 8050 4750
F 0 "#PWR8" H 8050 4750 30  0001 C CNN
F 1 "GND" H 8050 4680 30  0001 C CNN
F 2 "" H 8050 4750 60  0001 C CNN
F 3 "" H 8050 4750 60  0001 C CNN
	1    8050 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4750 8050 4350
Wire Wire Line
	8050 3850 8050 3950
Connection ~ 8050 3850
$EndSCHEMATC
