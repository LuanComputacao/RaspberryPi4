# RaspberryPi4
My Own Manual to set my _Raspberry Pi 4 Model B_ with _Kali Linux ARM64_

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


## Booting your Raspberry Pi
* Disconect verything from the board
* Put the SD Card into the SD Card Slot
* Connect the Energy Source and the other things
* Wait the boot happens

## Configuring your new awesome mini PC

If you have an HDMI Monitor with 1920x1080(1080p), then you can __copy__ this [config.txt](./boot/config.txt) to your `/boot/config.txt`

And than loog to this __config.txt guide__ to make your own adjusts following [THIS LINK](http://rpf.io/configtxt).

## Installing Docker

* Add Docker PGP key
  ```
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  ```
* Add __ONE__ Docker APT repository
  * 64 bits
    ```
    echo 'deb [arch=arm64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list
    ```
  * 32 bits
    ```
    echo 'deb [arch=armhf] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list
    ```
* Update APT
  ```
  sudo apt-get update
  ```
* Install Docker
  ```
  sudo apt-get install --no-install-recommends docker-ce
  ```
* Start Docker service
  ```
  sudo systemctl start docker
  ```
* Enable Docker service with boot
  ```
  sudo systemctl enable docker
  ```
* If you are __using a non-root user__, add this user to the docker user-group
  ```
  sudo usermod -aG docker $USER
  ```
* Test
  ```
  sudo docker run hello-world
  ```

# References
* [Raspberrypi config.txt](http://rpf.io/configtxt)
* [RPi-config](https://github.com/Evilpaul/RPi-config)
* [Installing Docker in Kali Linux](https://medium.com/@airman604/installing-docker-in-kali-linux-2017-1-fbaa4d1447fe)

# Regards 
* [Paul Young - Evilpaul](https://github.com/Evilpaul)
* [syb0rg](https://github.com/syb0rg)
* [Airman](https://github.com/airman604)
