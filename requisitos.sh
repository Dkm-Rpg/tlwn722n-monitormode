#!/bin/bash
python3 banner.py
echo "

************* n o t a *************


se instalaran los archivos necesarios
para que este script funcione correctamente
los archivos se clonaran del repositorio
oficial de aircrack-ng/rtl8188eus, con esto
no pretendo robar derechos de autor, al contrario
parte de los creditos le pertenecen.

preciona enter para continuar...
"
read intro

#esto es para instalar bc
sudo apt-get install bc

#esto es el repositorio oficial con el que trabaja este script
git clone https://github.com/aircrack-ng/rtl8188eus.git

#quita los candados del sudo del repositorio clonado 
chmod 777 -R rtl8188eus

#esto obtiene los heades de linux
sudo apt-get install linux-headers-$(uname -r)