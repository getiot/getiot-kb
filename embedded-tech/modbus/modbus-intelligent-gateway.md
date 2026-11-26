---
sidebar_position: 16
authors: [luhuadong]
---

# Modbus 智能网关



案例分析：Modbus intelligent gateway / MQTT gateway 6-way isolated 485 serial port GY-G6A



Support MQTT/Modbus connection cloud, upload the collected data directly to the cloud.

![](https://static.getiot.tech/modbus-gateway-to-mqtt-cloud.png#center)



When the Modbus TCP master station collects dozens of Modbus RTU slaves through the serial port server, the acquisition speed is slow, and multiple master stations simultaneously collect unstable problems that occur at the slave station.

![](https://static.getiot.tech/modbus-gateway-to-modbus-tcp-master.png#center)



Solve the problem that the RS-485 bus can only have one Modbus master. PLC can only collect 32 instruments. Through our collector, PLC can collect up to 192 instruments.

![](https://static.getiot.tech/modbus-gateway-to-modbus-rtu-master.png#center)



Solve the problem that the Modbus RTU master without a network port cannot collect data from the Modbus TCP slave.

![](https://static.getiot.tech/modbus-gateway-to-modbus-rtu-master-2.png#center)





