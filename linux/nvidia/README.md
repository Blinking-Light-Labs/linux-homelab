<!-- # Author Joshua Ross -->
<!-- # Purpose: README for nvidia drivers scripts  -->
<!-- # created on 05-02-2024 -->

# How to Install

- Clone the repo

```
https://github.com/ColoredBytes/LabAutomation.git
```
- Change into dir.
```
cd LabAutomation/linux/nvidia
```
- Make scripts executable.
```
chmod + x *.sh
```


- Run the nvidia_install.sh script.
```
./nvidia_install.sh
```
> [!NOTE]
> This will reboot the server when the script is finished.


After that go ahead an run the **nvidia_finish** script.

```
./nvidia_finish.sh
```


> [!NOTE]
> This will disable the nouveau drivers and then check to make sure the driver is running correclty with **nvidia-smi**.
> After that, All is good. Enjoy your nvidia card.


