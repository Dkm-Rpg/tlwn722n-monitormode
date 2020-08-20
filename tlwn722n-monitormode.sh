#!/bin/bash
#programada por Dkm Rpg - Pagina de Facebook: https://www.facebook.com/dkmhacking 
#Blog: https://dkmhacking.blogspot.com/
#tlwn722monitormode v1
#este script utiliza un repositorios de terceros.
#contactame perrevil5@gmail.com


#colores  que se utilizan
blanco="\033[1;37m"
magenta="\033[0;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
azul="\033[1;34m"



#opcion de menu
function menu (){

echo -e " "$verde"1)"$blanco" Compilar kernel (Primera vez)                                  "
echo -e " "$verde"2)"$blanco" Colocar en modo monitor (Despues de Compilar el kernel)        "
echo -e " "$verde"3)"$blanco" Restaurar procesos                                             "
echo -e " "$verde"4)"$blanco" Salir                                                          "
echo -n " #> "
read opcion

case "$opcion" in
"1")
	one
	;;
"2")
	ada
	;;
"3")
    procesisng
    ;;
"4") 
    salir
    ;;
*)
    sleep 0.1 && echo -e $rojo "Esa no es una opcion"
	sleep 2
    python3 banner.py 
	menu
	;;
esac
}

#esto compilara los archivos y cargara modulos

function one () {
    clear
    echo -e $verde"     Esto va a demorar poco, se paciente :D"
    sudo rmmod r8188eu.ko
    cd rtl8188eus
    sudo echo "blacklist r8188eu.ko" > "/etc/modprobe.d/realtek.conf"
    echo -e $azul"     Compilando ..."
    make
    sudo make install
    sudo modprobe 8188eu
    clear && cd ..
    echo -e $verde"     COmpliado ...      iras al menu ."
    sleep 3
    echo -e $verde " "
    python3 banner.py
    menu
}



#funcion de la antena
function ada () {
    sudo airmon-ng
    echo -e " "$verde" Coloca el nombre de tu tarjeta tl-wn722n (ej wlan0 o wlan1)"
    echo -n " #> "
    read antena
    echo -e " "$blanco"¿Estas seguro del nombre de tu antena? (s/n)"
    echo -e " "$blanco"Nombre de la antena: "$amarillo "$antena"
    echo -n " #> " 
    read opcion2
    if [ $opcion2 == "s" ]; then
        dos
    else
        clear 
        python3 banner.py && ada
    fi
}


#esto coloca la antena en modo monitor
function dos () {

    #nota: en esta parte es la que cambiaras el nombre de la antena, si es  wlan0 o wlan1

    clear && sleep 1
    sudo rmmod r8188eu.ko
    sudo modprobe 8188eu
    clear 
    echo -e $rojo "desconecta tu antena, despues conectala y preciona enter para continuar" && sleep 1
    read intro
    echo -e $rojo"  Matando Conecciones "
    sudo airmon-ng check kill
    sudo ifconfig $antena down  
    sudo iw dev $antena set type monitor 
    sudo ifconfig $antena up
    clear 
    echo -e $verde"   Modo Monitor Activado :D mira we " && sleep 1
    sudo airodump-ng $antena
    echo -e $verde"   Gracias por utilizar el script" && sleep 1
    clear_console 

}


#restauracion de los procesos matados 
function procesisng () {
$magenta
python3 banner.py
sudo airmon-ng
echo -e " "$verde" Coloca el nombre de tu tarjeta tl-wn722n (ej wlan0 o wlan1)"
echo -n " #> "
read antena
echo -e $verde" Restaurando procesos ..."
echo -e " "$verde" Recuerda que debes de conectar y desconectar tu antena :3"
sudo systemctl restart NetworkManager.service
sudo service wpa_supplicant start 
sudo ifconfig $antena down
sudo iw dev $antena set type managed
sudo ifconfig $antena up

}

#exit
function salir () {
    echo -e $verde" Saldras del script no olvides que los servicios no han sido restaurados :3" && sleep 2
    clear_console
}


#esto comprueba el root o el super usuario
if [ "$(id -u)" == "0" ]; then
 echo -e $azul " "
 python3 banner.py
 menu
else
    echo -e $rojo "es necesario ser root para que el script funcione D:"
fi
