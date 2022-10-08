#!/bin/bash

verifica_archivos(){
if ! test -f "./reiniciadorlog.log"; then
  echo "creando reniciadorlog.log"
  touch reiniciadorlog.log
fi
if ! test -f "./sip.conf"; then
  echo "creando sip.conf"
  touch sip.conf
  echo "s1:xx.xx.xx.xx" | tee -a ./sip.conf
  echo "Archivo sip.conf sin setear, ingrese los datos respetando la nomenclatura y vuelva a intentarlo"
  exit
fi
}

op_confirma(){
  while true; do
    read -p "Desea Continuar S/N?" op
    case $op in
      [Ss]* ) echo "Continua la Ejecución. !"; break;;
      [Nn]* ) echo "Finaliza la Ejecución. !"; exit;;
          * ) echo "Seleccione Si o No.";;
    esac
done
}

verificar_estado(){
  while read sip;
  do
      echo $sip;
      s=${sip%%:*};
      ip=${sip##*\:};
      #echo $s
      #echo $ip
      echo "Verificando estado de $s con ip: $ip";
      if ping -c 1 $ip; then
          continue
      else
          echo "servidor inaccesible!"
          #op_confirma;
      fi
  done <sip.conf
}

verifica_archivos
verificar_estado
printf "DATOS: sip.conf\n"
while read sip;
do
    echo $sip;
    s=${sip%%:*};
    ip=${sip##*\:};
    #echo $s
    #echo $ip
    echo "Reinciando $s con ip: $ip";
    $(ssh -i ./pkey/$s reiniciador@$ip "sudo /sbin/reboot") &> reiniciadorlog.log
    wait

done <sip.conf

echo "LISTO"
