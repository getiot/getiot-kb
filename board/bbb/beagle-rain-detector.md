---
sidebar_position: 3
draft: true
---

# Beagle 雨量探测器

![](https://static.getiot.tech/peru-rain.jpg)



## Story

### The Problem:

My country (Perú) is known for its varied climate, and in these winter / summer weather is misleading, because in the morning sun out much but at night (early morning) starts to rain, some yes, some no.

And this is a problem when one tends laundry clothes to dry (usually do in outside the house), because one usually leaves the washing in the evening and during the night expected to finish drying, but when it rains it gets wet again. It might seem that it is easy to see the rain, but is not, because the rains are usually mild (so are the rains in my country) being inside the house you can not hear or feel the rain (except sometimes it rains strong).



## Solution

### Step One: Capturing Data

Connect the sensor to Analog Input Pin, in this case P9_39.

Testing data read for sensor

```python
import Adafruit_BBIO.ADC as ADC
ADC.setup()
value = ADC.read_raw("P9_39")
print value
```

We put the sensor inside a litle plastic cup, at rain, the water will be acumulated and value reading will change.



### Step Two: Creating Store for Data

In this case, for easy collecting of data. I gonna use Ubidots Service

Don't forget to copy the ID for Variable

For show the data collected, we will create a widget on dashboard

![Creating widget on dashboard](https://hackster.imgix.net/uploads/image/file/137313/bbg_rain_detector_009.jpg?auto=compress%2Cformat&w=740&h=555&fit=max)



### Step Three: Sending Data

Ubidots Free Service, is limited to 500,000 pushes for month, then for not raise that cantity we going to limit the data sending only when the data readed raise a fix value.

```python
import Adafruit_BBIO.ADC as ADC
from ubidots import ApiClient
def send_data(val):
   #Create an "API" object
   api = ApiClient("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
   #Create a "Variable" object
   test_variable = api.get_variable("56f5fdb17625426671c22716")
   #Write the value to your variable in Ubidots
   test_variable.save_value({'value':val})
ADC.setup()
alertval = 1600
over = False
value = 0
while True:
   nvalue = ADC.read_raw("P9_39")
   if nvalue != value:
       value = nvalue
       print value
   if nvalue > alertval and over == False:
       print 'up alert value ',value
       over = True
       send_data(nvalue)
   if nvalue < alertval and over == True:
       print 'down alert value ',value
       over = False
       send_data(nvalue)
```

You will need install the [python library](http://ubidots.com/docs/libraries/python.html#libraries-python-official).

### Step Four: Configurating Trigger

We will to create un trigger event, for send a email when the value of sensor is less than 1,600 (when water will accumulate).

### Step Five: Get Fun

Now you can monitoring more sensor, as temperature, (:



## 系统架构

### 硬件连接

![](https://static.getiot.tech/BBG-Rain-Detector-Schema.png)



### 安装 Ubidot 库

```shell
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install python-setuptools
sudo easy_install pip
sudo pip install ubidots
```





