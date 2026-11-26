---
sidebar_position: 14
authors: [luhuadong]
---

# PyModbus 软件库



```python
from pymodbus.client.sync import ModbusTcpClient

client = ModbusTcpClient('127.0.0.1')
client.write_coil(1, True)
result = client.read_coils(1,1)
print(result.bits[0])
client.close()
```



模拟器 [modbus-simulator](https://github.com/riptideio/modbus-simulator)





