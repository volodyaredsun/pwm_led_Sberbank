/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
� Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : PWM LED 4 CHANNELS
Version : 1.00
Date    : 08.09.2012
Author  : Volodya_VA
Company : 
Comments: 


Chip type               : ATmega48PA
AVR Core Clock frequency: 8,000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 128
*****************************************************/

#include <mega48a.h>
#include <pwm_led.h>
#include <delay.h>
// Declare your global variables here

void main(void)
{
    InitPort();
    InitMCU();
    PORTC.2 = 1;    // ������� 1 �����
    c = 0;
    PWM1 = pwm1;
    PWM2 = pwm2;
    PWM3 = pwm3;
    PWM4 = pwm4;
    if(PWM1 < 255)
    {
        if(PWM1 > 0)
        {
            max = 0;
            min = 0;
        }
        else
        {
            max = 0;
            min = 1;
        };    
    }
    else
    {
        max = 1;
        min = 0;
    };
while (1)
      {
          ReadKey();
          SW();
          PressedKey = KEY_NONE;
      };
};

void SW(void)
{
    unsigned char tmax, tmin;   // ������ max � min
    switch (PressedKey)
    {
        case KEY_UP:
        {
            switch (c)
            {
                case 0:
                {
                    if(PWM1 < 255)
                    {
                        PWM1++;
                        DDRD.5 = 1;
                        max = 0;
                        min = 0;
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    };
                    break;
                };
                case 1:
                {
                    if(PWM2 < 255)
                    {
                        PWM2++;
                        DDRD.6 = 1;
                        max = 0;
                        min = 0;                        
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    };
                    break;
                };
                case 2:
                {
                    if(PWM3 < 255)
                    {
                        PWM3++;
                        DDRB.3 = 1;
                        max = 0;
                        min = 0;
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    };
                    break;
                };
                case 3:
                {
                    if(PWM4 < 255)
                    {
                        PWM4++;
                        DDRD.3 = 1;
                        max = 0;
                        min = 0;
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    };
                    break;
                };
            };
            break;
        };
        case KEY_DWN:
        {
             switch (c)
            {
                case 0:
                {
                    if(PWM1 > 0)
                    {
                        PWM1--;
                        max = 0;
                        min = 0;
                    }
                    else
                    {
                        DDRD.5 = 0;
                        min = 1;
                        max = 0;
                    };
                    break;
                };
                case 1:
                {
                    if(PWM2 > 0)
                    {
                        PWM2--;
                        max = 0;
                        min = 0;
                    }
                    else
                    {
                        DDRD.6 = 0;
                        min = 1;
                        max = 0;
                    };
                    break;
                };
                case 2:
                {
                    if(PWM3 > 0)
                    {
                        PWM3--;
                        max = 0;
                        min = 0;
                    }
                    else
                    {
                        DDRB.3 = 0;
                        min = 1;
                        max = 0;
                    };
                    break;
                };
                case 3:
                {
                    if(PWM4 > 0)
                    {
                        PWM4--;
                        max = 0;
                        min = 0;
                    }
                    else
                    {
                        DDRD.3 = 0;
                        min = 1;
                        max = 0;
                    };
                    break;
                };
            };
            break;
        };
        case KEY_CHANNEL:
        {
            if(c<3)
            {
                c++;
            }
            else
            {
                c = 0;
            };
            switch (c)
            {
                case 0:
                {
                    PORTC.2 = 1;
                    PORTC.3 = 0;
                    PORTC.4 = 0;
                    PORTC.5 = 0;                        
                    if(PWM1 < 255)
                    {
                        if(PWM1 > 0)
                        {
                            max = 0;
                            min = 0;
                        }
                        else
                        {
                            max = 0;
                            min = 1;
                        };    
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    }; 
                    break;
                };
                case 1:
                {
                    if(PWM2 < 255)
                    {
                        if(PWM2 > 0)
                        {
                            max = 0;
                            min = 0;
                        }
                        else
                        {
                            max = 0;
                            min = 1;
                        };    
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    };
                    PORTC.2 = 0;
                    PORTC.3 = 1;
                    PORTC.4 = 0;
                    PORTC.5 = 0;
                    break;
                };
                case 2:
                {
                    if(PWM3 < 255)
                    {
                        if(PWM3 > 0)
                        {
                            max = 0;
                            min = 0;
                        }
                        else
                        {
                            max = 0;
                            min = 1;
                        };    
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    };
                    PORTC.2 = 0;
                    PORTC.3 = 0;
                    PORTC.4 = 1;
                    PORTC.5 = 0;
                    break;
                };
                case 3:
                {
                    if(PWM4 < 255)
                    {
                        if(PWM4 > 0)
                        {
                            max = 0;
                            min = 0;
                        }
                        else
                        {
                            max = 0;
                            min = 1;
                        };    
                    }
                    else
                    {
                        max = 1;
                        min = 0;
                    };
                    PORTC.2 = 0;
                    PORTC.3 = 0;
                    PORTC.4 = 0;
                    PORTC.5 = 1;
                    break;
                }; 
            };
            break;
        };
        case KEY_SAVE:
        {
            pwm1 = PWM1;
            pwm2 = PWM2;
            pwm3 = PWM3;
            pwm4 = PWM4;
            tmax = max;
            tmin = min;
            max = 1;
            min = 1;
            delay_ms(2000);
            max = tmax;
            min = tmin;                
            break;
        };
        case KEY_NONE: break;
    };
};

void InitPort(void)
{
    PORTB=0x00;
    DDRB = (0<<0)|(0<<1)|(0<<2)|(1<<3)|(0<<4)|(0<<5)|(0<<6)|(0<<7);

    PORTC=0x00;
    DDRC = 0xff;//(1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<4)|(1<<5);
     
    PORTD=0x00;
    DDRD = (0<<0)|(1<<1)|(1<<2)|(1<<3)|(0<<4)|(1<<5)|(1<<6)|(0<<7);
};

void InitMCU(void)
{
    // Crystal Oscillator division factor: 1
    #pragma optsize-
    CLKPR=0x80;
    CLKPR=0x00;
    #ifdef _OPTIMIZE_SIZE_
    #pragma optsize+
    #endif

    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: 0,977 kHz
    // Mode: Fast PWM top=0xFF
    // OC0A output: Non-Inverted PWM
    // OC0B output: Non-Inverted PWM
    TCCR0A=0xA3;
    TCCR0B=0x03;
    TCNT0=0x00;
    OCR0A=0x00;
    OCR0B=0x00;

    TCCR1A=0x00;
    TCCR1B=0x00;
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;

    // Timer/Counter 2 initialization
    // Clock source: System Clock
    // Clock value: 0,977 kHz
    // Mode: Fast PWM top=0xFF
    // OC2A output: Non-Inverted PWM
    // OC2B output: Non-Inverted PWM
    ASSR=0x00;
    TCCR2A=0xA3;
    TCCR2B=0x04;
    TCNT2=0x00;
    OCR2A=0x00;
    OCR2B=0x00;

    // External Interrupt(s) initialization
    // INT0: Off
    // INT1: Off
    // Interrupt on any change on pins PCINT0-7: Off
    // Interrupt on any change on pins PCINT8-14: Off
    // Interrupt on any change on pins PCINT16-23: Off
    EICRA=0x00;
    EIMSK=0x00;
    PCICR=0x00;

    // Timer/Counter 0 Interrupt(s) initialization
    TIMSK0=0x00;

    // Timer/Counter 1 Interrupt(s) initialization
    TIMSK1=0x00;

    // Timer/Counter 2 Interrupt(s) initialization
    TIMSK2=0x00;

    // USART initialization
    // USART disabled
    UCSR0B=0x00;

    // Analog Comparator initialization
    // Analog Comparator: Off
    // Analog Comparator Input Capture by Timer/Counter 1: Off
    ACSR=0x80;
    ADCSRB=0x00;
    DIDR1=0x00;

    // ADC initialization
    // ADC disabled
    ADCSRA=0x00;

    // SPI initialization
    // SPI disabled
    SPCR=0x00;

    // TWI initialization
    // TWI disabled
    TWCR=0x00;
};

void ReadKey(void)
{
    static unsigned char key;
    static int CountKey;                  
    if((up==0)&&(dwn==0)){key = KEY_SAVE;}else
    if(up==0){key = KEY_UP;}else 
    if(dwn==0){key = KEY_DWN;}else 
    if(channel==0){key = KEY_CHANNEL;}
    else{key = KEY_NONE;};
    
    if(key)
    {
        if(CountKey > OLD_PRESS)
        {
            CountKey = OLD_PRESS - SPEED_OLD_PRESS;
            PressedKey = key;
        }
        else 
        {
            CountKey++;
        };
        if(CountKey == ONE_PRESS)
        {
            PressedKey = key;
        };
    }
    else {CountKey = 0;};      
};

