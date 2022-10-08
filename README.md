# reiniciador-script
Script en Bash para el reinicio de servidores.

## INSTRUCCIONES:
1. Se debe crear un usuario de sistema "reiniciador" en cada servidor.

$ sudo adduser --disabled-password reiniciador

- se le asigna un password temporal a la cuenta reiniciador.
$ sudo passwd reiniciador


2. Se le debe asignar el permiso de "reiniciar = /sbin/reboot" en cada servidor al usuario "reiniciador".

$ sudo nano /etc/sudoers

- agregar las siguientes lineas en sus bloques correspondientes:
Cmnd_Alias REINICIAR = /sbin/reboot
reiniciador ALL=(ALL:ALL) NOPASSWD: REINICIAR

3. En el terminal remoto desde donde se va a ejecutar el script, se debe
generar la clave publica para la conexión remota por ssh y almacenarla en
la carpeta "pkey" respetando la nomenclatura en el nombre del archivo.

- genera las llaves . (sin clave)
$ ssh-keygen -t rsa

- copiar la llave publica en el servidor.
$ ssh-copy-id -i sX.pub reiniciador@xx.xx.xx.xx

- copiar las llaves en la carpeta "pkey"
$ cp sX /"dir_script"/pkey
$ cp sX.pub /"dir_script"/pkey

4. Se borra el password del usuario reiniciador en el servidor.
sudo passwd -d reiniciador


5. Se deben cargar la dirección IP del servidor en el archivo sip.conf respetando
la nomenclatura en la referencia (clave/valor) del nombre y la IP.


Recomendaciones:
- El disco o el directorio donde se almacenará el script, sus archivos y directorios, es recomendable que se encuentren cifrados.

- Es muy probable que en el NOC se deba montar una maquina virtual en cada estación de trabajo para la instalación y ejecución del script.

- Configuración de permisos:
El directorio /home/reiniciador/.ssh  permisos (700)  --> $sudo chmod 700 /home/reiniciador/.ssh
Las Keys permisos (600)                       --> $sudo chmod 600 ~/.shh/sX
Las Keys permisos (600)                       --> $sudo chmod 600 /"dir_script"/pkey/*.pub
La lista de host conocidos permisos (644)     --> $sudo chmod 644 ~/.shh/known_hosts
