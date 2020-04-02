# RaspberryPi4
My Own Manual to set my _Raspberry Pi 4 Model B_ with _Kali Linux ARM64_

Tradução para __Português(Brasil)__ [neste LINK](https://translate.google.com/translate?hl=&sl=en&tl=pt&u=https%3A%2F%2Fgithub.com%2FLuanComputacao%2FRaspberryPi4)

## You can find a place to __Buy One__
* [FlipFlop - Brazil](https://www.filipeflop.com/?s=Raspberry+Pi+4&post_type=product)
* [Raspberry Pi Approved Resellers - countries](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/#find-reseller)
* [AliExpress - international](https://pt.aliexpress.com/wholesale?SearchText=raspberry+pi+4)
___
## Creating your runnable SD Card

### Getting the OS and SD buider

#### Kali

* Go to the Offensive Securitity from [HERE](https://www.offensive-security.com/kali-linux-arm-images/)
* RaspberryPi Foundation options
* Find your board model
* Download the compressed file
* Uncompress the `.img` file
* Don't forget where you had uncompressed the img

#### Etcher
* Download the "flash OS images to SD cards tool" from Belena [HERE](https://www.balena.io/etcher/)

### Flashing the OS to the SD
* Choose a very good SD card. There are many options like _SanDisk Ultra_
* Insert the SD in the computer slot
* Open the Etcher software.
  * It will request actions on each step. Follow them.
* Safe remove your SD card ajecting It or umounting It from your SO(Windows/Linux)

___
## Booting your Raspberry Pi
* Disconect verything from the board
* Put the SD Card into the SD Card Slot
* Connect the Energy Source and the other things
* Wait the boot happens
___
## Configuring your new awesome mini PC


### Enable cgroup
Edit the `/boot/cmdline.txt` and ad the following text at the end of line (use a space before it)
```
 cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory
```

### Other settings 
> To see the modifications, you need to reboot the system.
>
> Ok?

If you have an HDMI Monitor with 1920x1080(1080p), then you can __copy__ this [config.txt](./boot/config.txt) to your `/boot/config.txt`

And take a look in the official __config.txt guide__ to make your own adjusts under [THIS LINK](http://rpf.io/configtxt).

___
## Installing Docker

* Add Docker PGP key
  ```
  $ curl -fsSL https://download.docker.com/linux/debian/gpg | $ sudoapt-key add -
  ```
* Add __ONE__ Docker APT repository
  * 64 bits
    ```
    $ echo 'deb [arch=arm64] https://download.docker.com/linux/debian buster stable' | $ sudotee /etc/apt/sources.list.d/docker.list
    ```
  * 32 bits
    ```
    $ echo 'deb [arch=armhf] https://download.docker.com/linux/debian buster stable' | $ sudotee /etc/apt/sources.list.d/docker.list
    ```
* Update APT
  ```
  $ sudoapt-get update
  ```
* Install Docker
  ```
  $ sudoapt-get install --no-install-recommends docker-ce
  ```
* Start Docker service
  ```
  $ sudosystemctl start docker
  ```
* Enable Docker service with boot
  ```
  $ sudosystemctl enable docker
  ```
* If you are __using a non-root user__, add this user to the docker user-group
  ```
  $ sudousermod -aG docker $USER
  ```
* Test
  ```
  $ sudodocker run hello-world
  ```

___
## References
* [Raspberrypi config.txt](http://rpf.io/configtxt)
* [RPi-config](https://github.com/Evilpaul/RPi-config)
* [Installing Docker in Kali Linux](https://medium.com/@airman604/installing-docker-in-kali-linux-2017-1-fbaa4d1447fe)

___
## Regards 
* [Paul Young - Evilpaul](https://github.com/Evilpaul)
* [syb0rg](https://github.com/syb0rg)
* [Airman](https://github.com/airman604)
