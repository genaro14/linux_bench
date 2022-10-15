#! /bin/bash
ROUTE="~/.cache/kcbench/linux-5.19.9"
echo -e 'Linux benchmarking'
echo -e 'Hola' $USER
echo -e -n "Instalar Herramientas (s/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ns]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^s" ;then
    echo 'Instalando herramientas'
    sudo apt install bc bison curl flex util-linux make time perl-base pkg-config procps libssl-dev libelf-dev gcc binutils
else
    echo 'No instalar herramientas'
fi
echo -e "Descargar Fuentes de Kernel.org(s/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ns]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^s" ;then
    echo 'Descargando Fuentes'
    if [ ! -d "~/.cache/kcbench" ]
    then
	mkdir -p ~/.cache/kcbench
    fi
    wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.19.9.tar.xz -P ~/.cache/kcbench
    tar -xf ~/.cache/kcbench/linux-5.19.9.tar.xz -C ~/.cache/kcbench
else
    echo 'Fuentes no descargadas'
fi
if [ ! -d "kcbench" ]
then
git clone https://gitlab.com/knurd42/kcbench
fi
echo -e "Ejecutar KCbench?"
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ns]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^s" ;then
	echo -e 'Ejecutando bench en ' $ROUTE
	./kcbench/kcbench -s $ROUTE
else
    echo -e 'Terminado'
fi

