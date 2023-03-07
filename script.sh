#!/bin/bash

echo -e "\e[1m\e[33m
          )               )         (              )
    (  ( /(   (        ( /(  (      )\    (     ( /(       )
    )\ )\()) ))\  (    )\())))\   (((_)  ))\ (  )\())(    (
 _ ((_)(_)\ /((_) )\ )(_))//((_)  )\___ /((_))\(_))/ )\   )\  '
| | | | |(_)_))( _(_/(| |_(_))(  ((/ __(_))(((_) |_ ((_)_((_))
| |_| | '_ \ || | ' \))  _| || |  | (__| || (_-<  _/ _ \ '  \()
 \___/|_.__/\_,_|_||_| \__|\_,_|   \___|\_,_/__/\__\___/_|_|_|\e[0m"


#Colori e caratteri
verde="\e[92m"
fine="\e[0m"
gras="\e[1m"
rosso="\e[31m"
#problemi con endeler colore


echo " "
echo " "
echo " "
echo " "
echo -n -e $verde"Procedo con la configurazione di ubuntu [y,n]?"$fine

read RISP

if [ $RISP == "y" ]
then
	
	#Unzip e Sposta tutti i file di container.zip nelle apposite cartelle
	echo " "
	echo -e $verde"[Unzip conteiner.zip]"$fine
	sudo unzip $PWD/container.zip
	echo -e $verde"[Sposta tutti i file Scaricati nelle cartelle interessate]"$fine
	sudo mv $PWD/container/*.jpg ~/Immagini
	
	echo " "
	echo -e $verde"[Update Upgrade]"$fine
	sudo apt-get update > /dev/null
	sudo apt-get upgrade -y > /dev/null

	#UNITY TWEAK TOOL:
	echo " "
	echo -e $verde"[INSTALLAZIONE UNITY TWEAK TOOL E DIPENDENZE]"$fine
	sudo apt-get install notify-osd -y
	sudo apt-get install unity-tweak-tool -y


	#PLANK
	echo " "
	echo -e $verde"[INSTALLAZIONE PLANK]"$fine
	sudo apt-get install plank -y
	echo -e $verde"[CONFIGURAZIONE AUTORUN PLANK]"$fine
	sudo mkdir ~/.config/autostart
	sudo chmod -R 777 ~/.config/autostart
	sudo touch ~/.config/autostart/plank.desktop
	sudo chmod 777 ~/.config/autostart/plank.desktop
	sudo echo "[Desktop Entry]" >> ~/.config/autostart/plank.desktop
	sudo echo "Name=plank" >> ~/.config/autostart/plank.desktop
	sudo echo "Exec=/usr/bin/plank" >> ~/.config/autostart/plank.desktop
	sudo echo "Type=Application" >> ~/.config/autostart/plank.desktop
	sudo chmod -R 700 ~/.config/autostart
	sudo chmod 664 ~/.config/autostart/plank.desktop




	#AGGIUNGI REPOSITORY
	echo -e $verde"[AGGIUNGI REPOSITORY]"$fine
	echo -e $verde"[Repository Tema1:]"$fine
	sudo add-apt-repository ppa:noobslab/macbuntu -y #TEMA1
	echo -e $verde"[Repository Tema2:]"$fine
	sudo add-apt-repository ppa:noobslab/themes -y #TEMA2
	echo -e $verde"[Repository Icone:]"$fine
	sudo add-apt-repository ppa:noobslab/icons -y #ICONE
	echo -e $verde"[Update:]"$fine
	sudo apt-get update > /dev/null
	sudo apt-get upgrade -y > /dev/null


	#TEMA
	echo " "
	echo -e $verde"[INSTALLAZIONE TEMI E ICONE]"$fine

	#Tema1
	sudo apt-get install macbuntu-os-plank-theme-v1804 -y
	sudo apt-get install macbuntu-os-icons-v1804 -y
	sudo apt-get install macbuntu-os-ithemes-v1804 -y
	sudo unzip $PWD/container/mac-fonts.zip -d /usr/share/fonts; sudo rm $PWD/container/mac-fonts.zip
	fc-cache -f -v

	#Tema2:
	sudo apt-get install stylish-themes -y


	#Icone:
	sudo apt-get install shadow-icon-theme
	sudo apt-get install obsidian-1-icons
	

	#Sfondo Login
	echo " "
	echo -e $verde"[CONFIGURAZIONE SFONDO LOGIN PAGE]"$fine		
	sudo rm /usr/share/gnome-shell/theme/ubuntu.css
	sudo chmod 664 ~/container/ubuntu.css
	sudo mv  $PWD/container/ubuntu.css /usr/share/gnome-shell/theme/

	#WIRESHARK(sniffing)
	echo " "
	echo -e $verde"[INSTALLAZIONE WIRESHARK(sniffing)]"$fine
	sudo apt-get install mimtproxy -y
	sudo apt install wireshark-qt -y
	
	#THUNDERBIRD(posta)
	sudo apt install thunderbird
	
	#PYCHARM
	sudo apt install -y python3-pip -y
	sudo snap install pycharm-community --classic -y
	
	#KEEPASS2
	sudo apt install keepass2 -y
	
	#VIRTUALBOX
	sudo apt install virtualbox -y


	echo " "
	echo " "
	echo -e "\e[92mConfigurazione effettuato con successo!\e[0m"
	echo " "
	echo -e "\e[5m\e[31m[ATTENZIONE!!!]\e[0m"
	echo -e "1. Prima di iniziare ad utilizzare Ubuntu andare in \e[1mUnity Tweak Tools \e[21m(si aprirà automaticamente alla fine dello script) e selezionare in Tema: \e[1mMacbuntu-sierra-dark \e[21m, Icone: \e[1mobsidian \e[21m, Puntatore: \e[1mDmz-black \e[21mTipi di carattere: \e[1mUbuntu Mono Regular 13\e[0m"
	echo -e "2. Inoltre, nelle impostazioni di Ubuntu andare in \e[1mimpostazioni->Dock->attivare \"Nascondi automaticamente la Dock\"\e[0m"
	echo "3. Per lo sfondo selezionare una delle immagini contenute nella cartella Immagini facendo click con tasto destro sul Desktop e selezionando \"Cambia Sfondo\""
	echo " "
	echo -e "\e[5m\e[31m[ATTENZIONE!!!]\e[0m"
	echo "Per applicare il tema alla Dock di Plank (Il menù in stile MacOS che esce sul fondo del Desktop), fare click sul menù con 'CTRL + tasto destro del mouse' e selezionare Preferenze -> Aspetto -> 'Tema' e selezionare MB-X-Dark; dopodichè sempre in Aspetto andare su 'Dimensioni icone' e settare a 55 il valore; in fine, attivare l''Ingrandimento icone' e settarlo a 170."
	echo "Per aggiungere i programmi alla Dock Plank, aprire il programma interessato e cliccare con il tasto destro sull'icona del programma nel Menù Plank; spuntare 'Mantieni sulla Dock'"
	
	#Apre il tool per modificare il tema
	unity-tweak-tool

	echo " "
	echo -e $verde$gras"Configurazione effettuata con Successo!"$fine

else
	echo " "
	echo " "
	echo -e $rosso$gras"Configurazione non effettuata!"$fine
	echo " "
	echo " "

fi
