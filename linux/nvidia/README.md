<!-- # Author Joshua Ross -->
<!-- # Purpose: README for nvidia drivers scripts  -->
<!-- # created on 05-02-2024 -->

# Table of Contents  <!-- omit in toc -->

1. [Purpose](#purpose)
   1. [How to Install](#how-to-install)
   2. [Conclusion](#conclusion)


## Purpose

These scripts are used to isntall Nvidia Drivers on Alma Linux mostly. But should work on RHEL based as well.

### How to Install

<details>
  <summary>Click me</summary>


- Clone the repo

```
git clone git@github.com:ross-jm/Homelab-Scripts.git
```
- Change into dir.
```
cd Homelab-Scripts/random/nvidia_drivers
```
- Make scripts executable.
```
chmod + x *.sh
```


- Run the nvidia_install.sh script.
```
./nvidia_install.sh
```
> This will reboot the server when the script is finished.


After that go ahead an run the **nvidia_finish** script.

```
./nvidia_finish.sh
```
</details>

### Conclusion 
This will disable the nouveau drivers and then check to make sure the driver is running correclty with **nvidia-smi**.

After that, All is good. Enjoy your nvidia card.


