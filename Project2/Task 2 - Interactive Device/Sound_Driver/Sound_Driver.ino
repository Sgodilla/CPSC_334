#include "arduino.h"
#include "soc/sens_reg.h"
#include "soc/rtc.h"
#include "driver/dac.h"

int clk_8m_div = 7;      // RTC 8M clock divider (division is by clk_8m_div+1, i.e. 0 means 8MHz frequency)
int frequency_step = 8;  // Frequency step for CW generator
int scale = 0;           // 50% of the full scale
int offset;              // leave it default / 0 = no any offset
int invert = 2;          // invert MSB to get sine waveform

const int joyXPin = 34;
const int joyYPin = 35;
const int joyBPin = 32;
int joyX = 0;
int joyY = 0;
int joyB = 0;
int scaleFactor = 0;

/*
 * Enable cosine waveform generator on a DAC channel
 */
void dac_cosine_enable(dac_channel_t channel)
{
  // Enable tone generator common to both channels
  SET_PERI_REG_MASK(SENS_SAR_DAC_CTRL1_REG, SENS_SW_TONE_EN);
  switch(channel) 
  {
      case DAC_CHANNEL_1:
          // Enable / connect tone tone generator on / to this channel
          SET_PERI_REG_MASK(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_CW_EN1_M);
          // Invert MSB, otherwise part of waveform will have inverted
          SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_INV1, 2, SENS_DAC_INV1_S);
          break;
      case DAC_CHANNEL_2:
          SET_PERI_REG_MASK(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_CW_EN2_M);
          SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_INV2, 2, SENS_DAC_INV2_S);
          break;
  }
}


/*
 * Set frequency of internal CW generator common to both DAC channels
 *
 * clk_8m_div: 0b000 - 0b111
 * frequency_step: range 0x0001 - 0xFFFF
 *
 */
void dac_frequency_set(int clk_8m_div, int frequency_step)
{
    REG_SET_FIELD(RTC_CNTL_CLK_CONF_REG, RTC_CNTL_CK8M_DIV_SEL, clk_8m_div);
    SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL1_REG, SENS_SW_FSTEP, frequency_step, SENS_SW_FSTEP_S);
}

/*
 * Scale output of a DAC channel using two bit pattern:
 *
 * - 00: no scale
 * - 01: scale to 1/2
 * - 10: scale to 1/4
 * - 11: scale to 1/8
 *
 */
void dac_scale_set(dac_channel_t channel, int scale)
{
  switch(channel) 
  {
      case DAC_CHANNEL_1:
          SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_SCALE1, scale, SENS_DAC_SCALE1_S);
          break;
      case DAC_CHANNEL_2:
          SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_SCALE2, scale, SENS_DAC_SCALE2_S);
          break;
  }
}


/*
 * Offset output of a DAC channel
 *
 * Range 0x00 - 0xFF
 *
 */
void dac_offset_set(dac_channel_t channel, int offset)
{
  switch(channel) 
  {
      case DAC_CHANNEL_1:
          SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_DC1, offset, SENS_DAC_DC1_S);
          break;
      case DAC_CHANNEL_2:
          SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_DC2, offset, SENS_DAC_DC2_S);
          break;
  }
}


/*
 * Invert output pattern of a DAC channel
 *
 * - 00: does not invert any bits,
 * - 01: inverts all bits,
 * - 10: inverts MSB,
 * - 11: inverts all bits except for MSB
 *
 */
void dac_invert_set(dac_channel_t channel, int invert)
{
    switch(channel) 
    {
        case DAC_CHANNEL_1:
            SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_INV1, invert, SENS_DAC_INV1_S);
            break;
        case DAC_CHANNEL_2:
            SET_PERI_REG_BITS(SENS_SAR_DAC_CTRL2_REG, SENS_DAC_INV2, invert, SENS_DAC_INV2_S);
            break;
    }
}


void setup(void)
{
  Serial.begin(9600);
  Serial.println("Cosine Generator Test starting");
  dac_frequency_set(clk_8m_div, 2);

  dac_cosine_enable(DAC_CHANNEL_1);
  dac_cosine_enable(DAC_CHANNEL_2);

  dac_output_enable(DAC_CHANNEL_1);
  dac_output_enable(DAC_CHANNEL_2);

  pinMode(joyXPin, INPUT);
  pinMode(joyYPin, INPUT);
  pinMode(joyBPin, INPUT_PULLUP);
}

void loop(void)
{
  joyX = analogRead(joyXPin);
  joyY = analogRead(joyYPin);
  joyB = digitalRead(joyBPin);
  double X = (4095.0/2) - (double)joyY;
  double Y = (4095.0/2) - (double)joyX;
  double magnitude = sqrt((double)(X*X + Y*Y));
  double angle = atan2(Y, X) * 180.0 / PI;

  if (joyB == LOW && scaleFactor == 0)
    scaleFactor = 8;
  else if (joyB == LOW && scaleFactor == 8)
    scaleFactor = 0;

  int f = 0;
  double sec = 45.0/2.0;
  if (magnitude > 1500.0)
  {
    if (angle >= -sec && angle < sec)
      f = 1 + scaleFactor;
    else if (angle >= (45-sec) && angle < (45+sec))
      f = 2 + scaleFactor;
    else if (angle >= (90-sec) && angle < (90+sec))
      f = 3 + scaleFactor;
    else if (angle >= (135-sec) && angle < (135+sec))
      f = 4 + scaleFactor;
    else if ((angle >= (180-sec) && angle < 180) || (angle > -180 && angle < (-180+sec)))
      f = 5 + scaleFactor;
    else if (angle >= (-135-sec) && angle < (-135+sec))
      f = 6 + scaleFactor;
    else if (angle >= (-90-sec) && angle < (-90+sec))
      f = 7 + scaleFactor;
    else if (angle >= (-45-sec) && angle < (-45+sec))
      f = 8 + scaleFactor;
  }

  //int f = (int)(30 * ((double)joyX / 4095.0)); // 750 = 100Khz, 1000 = 132Khz,  (Much higher and it starts to distort)
  dac_frequency_set(clk_8m_div, f);
  
  Serial.print("X: ");
  Serial.print(X);
  Serial.print(" Y: ");
  Serial.print(Y);
  Serial.print(" B: ");
  Serial.print(joyB);
  Serial.print(" F: ");
  Serial.print(f);
  Serial.print(" M: ");
  Serial.print(magnitude);
  Serial.print(" A: ");
  Serial.print(angle);
  Serial.println();
}