#!/bin/bash

KS="$(dirname $(dirname "$0"))"

display_usage(){
	echo -e "Uso: ksource templates dest [opciones]\n"
	echo -e "Copia a dest las plantillas para utilizar KSource desde Python, o"
	echo -e "interactuar con otros codigos.\n"
	echo -e "Opciones:"
	echo -e "\t--mcstas:  copiar plantillas para utilizar McStas."
	echo -e "\t--tripoli: copiar plantillas para utilizar TRIPOLI-4."
	echo -e "\t--all:     copiar todas las plantillas."
}

opt_mcstas=0
opt_tripoli=0
DEST=""
while (( "$#" )); do
	case "$1" in
		"-h"|"--help")
			display_usage
			exit 0
			;;
		"--mcstas")
			opt_mcstas=1
			shift 1
			;;
		"--tripoli")
			opt_tripoli=1
			shift 1
			;;
		"--all")
			opt_mcstas=1
			opt_tripoli=1
			shift 1
			;;
		*)
			if [[ "$DEST" == "" ]]; then
				DEST="$1"
				shift 1
			else
				echo "Argumentos invalidos. Use -h o --help para ayuda."
				exit 1
			fi
			;;
	esac
done

if [[ "$DEST" == "" ]]; then
	echo "No se especifico destino. Use -h o --help para ayuda."
	exit 1
fi
if [ ! -d "$DEST" ]; then
	echo "Creado directorio $DEST"
	mkdir "$DEST"
else
	echo "Usando directorio existente $DEST"
fi

cp $KS/templates/*.ipynb "$DEST"
echo "Plantillas para preproc/postproc en Python (Jupyter Notebook) copiadas."
if [[ opt_mcstas ]]; then
	cp $KS/templates/mcstas/* "$DEST"
	echo "Plantillas para McStas copiadas."
fi 
if [[ opt_tripoli ]]; then
 	cp $KS/templates/tripoli/* "$DEST"
	echo "Plantillas para TRIPOLI-4 copiadas."
fi
