         void InitMCU(void);
         void InitPort(void);
         void ReadKey(void);
         void SW(void); 

#define min PORTD.2
#define max PORTD.1

#define PWM1 OCR0A
#define PWM2 OCR0B
#define PWM3 OCR2A
#define PWM4 OCR2B

unsigned char c;            // �������� �����
unsigned char PressedKey;
eeprom unsigned char pwm1,pwm2,pwm3,pwm4; 
#define up      PIND.7
#define dwn     PINB.1
#define channel PINB.0
enum {KEY_NONE = 0, KEY_UP, KEY_DWN, KEY_CHANNEL, KEY_SAVE}; // KEY_SAVE ������� ���� ������� UP � DWN ������������ 
#define ONE_PRESS       1000
#define OLD_PRESS       20000
#define SPEED_OLD_PRESS 500   