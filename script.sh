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
	echo -e $verde"[Unzip container.zip]"$fine
	sudo unzip $PWD/container.zip
	echo " "
	echo -e $verde"[Sposta tutti i file Scaricati nelle cartelle interessate]"$fine
	sudo mv $PWD/container/*.jpg ~/Immagini
	
	echo " "
	echo -e $verde"[Update Upgrade]"$fine
	sudo apt-get update > /dev/null
	sudo apt-get upgrade -y > /dev/null

	#GNOME TWEAK:
	echo " "
	echo -e $verde"[INSTALLAZIONE GNOME TWEAKS E DIPENDENZE]"$fine
	sudo apt install gnome-tweaks
	sudo apt install gnome-shell-extension-manager


	#PLANK
	echo " "
	echo -e $verde"[INSTALLAZIONE PLANK]"$fine
	sudo apt-get install plank -y
	echo -e $verde"[CONFIGURAZIONE AUTORUN PLANK]"$fine
	sudo mkdir ~/.config/autostart
	sudo chown -R $USER:$USER ~/.config/autostart
	touch ~/.config/autostart/plank.desktop
	echo "[Desktop Entry]" >> ~/.config/autostart/plank.desktop
	echo "Name=plank" >> ~/.config/autostart/plank.desktop
	echo "Exec=/usr/bin/plank" >> ~/.config/autostart/plank.desktop
	echo "Type=Application" >> ~/.config/autostart/plank.desktop

	#TEMA
	echo " "
	echo -e $verde"[INSTALLAZIONE TEMI E ICONE]"$fine
	sudo $PWD/container/WhiteSur-gtk-theme-master/install.sh

	#ICONE
	sudo unzip $PWD/container/mac-fonts.zip -d /usr/share/fonts; sudo rm $PWD/container/mac-fonts.zip
	fc-cache -f -v

	#LOGIN:
	echo " "
	echo -e $verde"[INSTALLAZIONE E CONFIGURAZIONE PAGINA DI LOGIN"$fine
	wget -qO - https://github.com/PRATAP-KUMAR/ubuntu-gdm-set-background/archive/main.tar.gz | tar zx --strip-components=1 ubuntu-gdm-set-background-main/ubuntu-gdm-set-background
	sudo ./ubuntu-gdm-set-background --image /home/slevin/Immagini/login.jpg 

	#WIRESHARK(sniffing)
	echo " "
	echo -e $verde"[INSTALLAZIONE WIRESHARK(sniffing)]"$fine
	sudo apt-get install mimtproxy -y
	sudo apt install wireshark-qt -y
	
	#THUNDERBIRD(posta)
	echo " "
	echo -e $verde"[INSTALLAZIONE THUNDERBIRD]"$fine
	sudo apt install thunderbird -y
	
	#PYCHARM
	echo " "
	echo -e $verde"[INSTALLAZIONE PYCHARM COMMUNITY]"$fine
	sudo apt install -y python3-pip -y
	sudo snap install pycharm-community --classic
	
	#KEEPASS2
	echo " "
	echo -e $verde"[INSTALLAZIONE KEEPASS2]"$fine
	sudo apt install keepass2 -y
	
	#VIRTUALBOX
	echo " "
	echo -e $verde"[INSTALLAZIONE VIRTUALBOX]"$fine
	sudo apt install virtualbox -y
	
	#VLC
	echo " "
	echo -e $verde"[INSTALLAZIONE VLC]"$fine
	sudo apt install vlc -y

 	#TOR BROWSER
  	echo " " 
   	echo -e $verde"[INSTALLAZIONE TOR BROWSER]"$fine
    	tar -xvf $PWD/container/tor-browser-linux64-12.5.1_ALL.tar.xz
     	$PWD/container/tor-browser/start-tor-browser.desktop --register-app
	
	#TOR 
	echo " "
	echo -e $verde"[INSTALLAZIONE TOR E CONFIGURAZIONE SHELL]"$fine
	sudo apt install tor
	echo ". torsocks on" >> ~/.bashrc
	
	#STACER
	echo " "
	echo -e $verde"[INSTALLAZIONE STACER (Strumento di pulizia)]"$fine
	sudo sudo apt install stacer -y	
	
	echo " "
	echo " "
	echo -e "\e[92mConfigurazione effettuato con successo!\e[0m"
	echo " "
	echo -e "\e[5m\e[31m[ATTENZIONE!!!]\e[0m"
	echo -e "1. Prima di iniziare ad utilizzare Ubuntu andare in \e[1mGnome Tweak \e[21m(si aprirà automaticamente alla fine dello script) e selezionare in Aspetto: \e[1mApplicazioni -> WhiteSur-Dark \e[21m, Icone: \e[1mUbuntu-mono-dark\e[21m,poi cambiare gli sfondi manualmente.\e[0m"
	echo -e "2. Inoltre, nelle impostazioni di Ubuntu andare in \e[1mimpostazioni->Dock->attivare \"Nascondi automaticamente la Dock\"\e[0m"
	echo "3. Per lo sfondo selezionare una delle immagini contenute nella cartella Immagini facendo click con tasto destro sul Desktop e selezionando \"Cambia Sfondo\""
	echo " "
	echo -e "\e[5m\e[31m[ATTENZIONE!!!]\e[0m"
	echo "Per applicare il tema alla Dock di Plank, fare click sul menù con 'CTRL + tasto destro del mouse' e selezionare Preferenze -> Aspetto -> 'Tema' e selezionare MB-X-Dark; dopodichè sempre in Aspetto andare su 'Dimensioni icone' e settare a 55 il valore; in fine, attivare l''Ingrandimento icone' e settarlo a 170."
	echo "Per aggiungere i programmi alla Dock Plank, aprire il programma interessato e cliccare con il tasto destro sull'icona del programma nel Menù Plank; spuntare 'Mantieni sulla Dock'"
	
	#Apre il tool per modificare il tema
	gnome-tweaks

	echo " "
	echo -e $verde$gras"Configurazione effettuata con Successo!"$fine
 	
else
	echo " "
	echo " "
	echo -e $rosso$gras"Configurazione non effettuata!"$fine
	echo " "
	echo " "

fi
