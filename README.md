# Camera Filter on FPGA

FPGA camera filter project for 102109 Digital Logic, Fall 2022, Tongji University.

同济大学数字逻辑大作业-基于颜色传感器与 OV2640 摄像头的图像处理及显示系统

## 简介

本实验采用 VGA、颜色传感器、OV2640 摄像头三个外围模块，实现带滤镜的摄像头系统。通过摄像头采集图像数据，以颜色传感器读取到的颜色决定图像的处理方式，最后由 VGA 显示指定滤镜处理后的图像。

## **使用说明**

1. 将开发板和三个外围部件连接，其中颜色传感器带灯一面朝下，并在下方垫一张白纸供白平衡使用。
2. 接下来将比特流写入开发板，下板成功后颜色传感器自动进行白平衡，当开发板上右边第二个灯亮起时表明白平衡完成。
3. 白平衡完成后，拨动右边第一个开关（J15），开启摄像头。此时 VGA 显示的是原始图像，数码管上显示“init”字样。最左边 8 个灯不断闪烁，表明摄像头数据传输正在传输，从左往右数第 10 个灯（U17）亮起，表明开发板正在接受摄像头的数据。
4. 接着拨动右边第二个开关（L16），开启滤镜，此时数码管显示颜色传感器读取到的颜色，如“white”、“black”等，VGA 显示指定滤镜处理后的图像。黑白红绿蓝 5色对应 5 种滤镜，改变颜色传感器下物体的颜色，即可观察到不同颜色对应的滤镜效果。
5. 按住 N17 可使画面暂停。

## 系统展示

1. 初始状态

   <img src="https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/init.png" alt="Example Image" width="400">

   <img src="https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/init2.png" alt="Example Image" width="400">

2. 颜色检测及对应滤镜

   白色

   <img src="https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/white.png" alt="Example Image" width="500">

   <img src="https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/filter_edge_white.png" alt="Example Image" width="500">

   黑色

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/black.png)

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/filter_edge_black.png)

   红色

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/red.png)

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/filter_red.png)

   绿色

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/green.png)

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/filter_green.png)

   蓝色

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/blue.png)

   ![image](https://github.com/rulihongran/Camera-Filter-FPGA/blob/main/image/filter_blue.png)

   