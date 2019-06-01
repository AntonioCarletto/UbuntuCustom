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

	#Sposta tutti i file Scaricati nelle cartelle interessate
	echo " "
	echo -e $verde"[Sposta tutti i file Scaricati nelle cartelle interessate]"$fine
	sudo mv $PWD/Immagini/* ~/Immagini
	sudo mv $PWD/Scaricati/* ~/Scaricati
	
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
	sudo chmod -R 700 ~/.config/autostart
	sudo touch ~/.config/autostart/plank.desktop
	sudo chmod 664 ~/.config/autostart/plank.desktop
	sudo echo "[Desktop Entry]" >> ~/.config/autostart/plank.desktop
	sudo echo "Name=plank" >> ~/.config/autostart/plank.desktop
	sudo echo "Exec=/usr/bin/plank" >> ~/.config/autostart/plank.desktop
	sudo echo "Type=Application" >> ~/.config/autostart/plank.desktop


	#AGGIUNGI REPOSITORY
	echo -e $verde"[AGGIUNGI REPOSITORY]"$fine
	echo -e $verde"[Repository Tema1:]"$fine
	sudo add-apt-repository ppa:noobslab/macbuntu -y #TEMA1
	echo -e $verde"[Repository Tema2:]"$fine
	sudo add-apt-repository ppa:noobslab/themes -y #TEMA2
	echo -e $verde"[Repository Icone:]"$fine
	sudo add-apt-repository ppa:noobslab/icons -y #ICONE
	echo -e $verde"[Repository Java7:]"$fine
	sudo add-apt-repository ppa:openjdk-r/ppa -y #JAVA7
	echo -e $verde"[Repository Java11:]"$fine
	sudo add-apt-repository ppa:linuxuprising/java -y #JAVA11
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
	wget -O mac-fonts.zip http://drive.noobslab.com/data/Mac/macfonts.zip
	sudo unzip mac-fonts.zip -d /usr/share/fonts; sudo rm mac-fonts.zip
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
	sudo chmod 664 ~/Scaricati/ubuntu.css
	sudo mv  ~/Scaricati/ubuntu.css /usr/share/gnome-shell/theme/
	
	
	#JAVA(IMPORTANTE PER INSTALLAZIONI SUCCESSIVE):
	echo " "
	echo -e $verde"[INSTALLAZIONE JAVA]"$fine
	sudo apt-get install openjdk-7-jdk
	sudo apt install default-jre -y
	sudo apt-get install oracle-java11-installer -y



	#METASPLOIT(Exploitation)
	echo " "
	echo -e $verde"[INSTALLAZIONE METASPLOIT(Exploitation)]"$fine
	#Installare dipendenze, gemme di ruby e scaricare Metasploit:
		sudo apt-get update > /dev/null
		sudo apt-get install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev  subversion git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev  libyaml-dev ruby ruby-dev nmap xtightvncviewer -y
		sudo gem install --verbose --debug pcaprub wirble pg sqlite3 msgpack activerecord redcarpet rspec simplecov yard bundler
		cd /opt
		sudo git clone https://github.com/rapid7/metasploit-framework.git
		cd metasploit-framework
		sudo bash -c 'for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF;done'
		sudo gem update --system
		bundle install #non eseguire da root
	#Su Postgres (database):
		echo -e $verde"Inserire come password: msf"$fine
		sudo -u postgres createuser msf -P -S -R -D
		sudo -u postgres createdb -O msf msf
	#Creare file di configurazione:
		sudo touch /opt/metasploit-framework/database.yml
		sudo chmod 666 /opt/metasploit-framework/database.yml
		#Dentro scrivere:
		sudo echo "production:" >> /opt/metasploit-framework/database.yml
		sudo echo "adapter: postgresql" >> /opt/metasploit-framework/database.yml
		sudo echo "database: msf" >> /opt/metasploit-framework/database.yml
		sudo echo "username: msf" >> /opt/metasploit-framework/database.yml
		sudo echo "password: msf" >> /opt/metasploit-framework/database.yml
		sudo echo "host: 127.0.0.1" >> /opt/metasploit-framework/database.yml
		sudo echo "port: 5432" >> /opt/metasploit-framework/database.yml
		sudo echo "pool: 75" >> /opt/metasploit-framework/database.yml
		sudo echo "timeout: 5" >> /opt/metasploit-framework/database.yml
	#Creare variabile d'ambiente:
		sudo sh -c "echo export MSF_DATABASE_CONFIG=/opt/metasploit-framework/database.yml >> ~/.bashrc"
	#Aviare postgres e msfconsole:
		sudo service postgresql start
	#Connettere al database Metasploit:
		msfconsole < ~/Scaricati/input.txt
	
	#DMITRY(Recupero Informazioni)
	echo " "
	echo -e $verde"[INSTALLAZIONE DMITRY(Recupero Informazioni)]"$fine
	sudo apt-get update > /dev/null
	sudo apt-get upgrade -y > /dev/null
	sudo apt-get install -y dmitry

	#NETDISCOVER(Recupero Informazioni)
	echo " "
	echo -e $verde"[INSTALLAZIONE NETDISCOVER(Recupero Informazioni)]"$fine
	sudo apt-get install netdiscover -y

	#NMAP(Recupero Informazioni)
	echo " "
	echo -e $verde"[INSTALLAZIONE NMAP(Recupero Informazioni)]"$fine
	sudo apt-get install nmap -y

	#P0F(Recupero Informazioni)
	echo " "
	echo -e $verde"[INSTALLAZIONE P0F(Recupero Informazioni)]"$fine
	sudo apt-get install p0f -y

	#MALTEGO(Recupero Informazioni)
	echo " "
	echo -e $verde"[INSTALLAZIONE MALTEGO(Recupero Informazioni)]"$fine
	sudo apt-get install openjdk-8-jdk -y
	sudo dpkg -i ~/Scaricati/Maltego.v4.2.3.12223.deb

	#LEAFPAD(Editor)
	echo " "
	echo -e $verde"[INSTALLAZIONE LEAFPAD(Editor)]"$fine
	sudo apt-get install leafpad

	#NIKTO(Analisi Vulnerabilita')
	echo " "
	echo -e $verde"[INSTALLAZIONE NIKTO(Analisi Vulnerabilita')]"$fine
	sudo apt-get install nikto -y
	sudo nikto -update

	#BURPSUITE(Applicazioni web)
	echo " "
	echo -e $verde"[INSTALLAZIONE BURPSUITE(Applicazioni web)]"$fine
	sudo bash ~/Scaricati/burpsuite_community_linux_v1_7_36.sh

	#JOHN THE RIPPER(Attacchi alle password)
	echo " "
	echo -e $verde"[INSTALLAZIONE JOHN THE RIPPER(Attacchi alle password)]"$fine
	sudo apt-get install john -y

	#CEWL(Attacchi alle password)
	echo " "
	echo -e $verde"[INSTALLAZIONE CEWL(Attacchi alle password)]"$fine
	sudo apt-get install cewl -y

	#CRUNCH(Attacchi alle password)
	echo " "
	echo -e $verde"[INSTALLAZIONE CRUNCH(Attacchi alle password)]"$fine
	sudo tar -zxvf ~/Scaricati/crunch-3.6.tgz -C /opt/
	cd /opt/crunch-3.6
	sudo make
	sudo make install	

	#BEEF-XXS(Exploitation)
	echo " "
	echo -e $verde"[INSTALLAZIONE BEEF-XXS(Exploitation)]"$fine
	sudo apt install ruby ruby-dev
	sudo apt install git
	cd /opt/
	sudo git clone https://github.com/beefproject/beef
	cd /opt/beef
	sudo bundle install
	sudo ./install
	sudo ./update-geoipdb
	sudo ./update-beef
	sudo rm /opt/beef/config.yaml
	sudo mv ~/Scaricati/config.yaml /opt/beef/

	#AIRCRACK-NG(Attacchi wireless)
	sudo apt-get install aircrack-ng

	#WIFITE(Attacchi wireless)
	echo " "
	echo -e $verde"[INSTALLAZIONE WIFITE(Attacchi wireless)]"$fine
	sudo apt install libcanberra-gtk-module libcanberra-gtk3-module
	sudo apt-get update  > /dev/null 
	sudo apt-get upgrade -y  > /dev/null
	sudo apt-get install wifite -y

	#MACCHANGER(sniffing)
	echo " "
	echo -e $verde"[INSTALLAZIONE MACCHANGER(sniffing)]"$fine
	sudo apt-get install macchanger -y

	#DRIFTNET(sniffing)
	echo " "
	echo -e $verde"[INSTALLAZIONE DRIFTNET(sniffing)]"$fine
	sudo apt-get install driftnet -y

	#WIRESHARK(sniffing)
	echo " "
	echo -e $verde"[INSTALLAZIONE WIRESHARK(sniffing)]"$fine
	sudo apt-get install mimtproxy -y
	sudo apt install wireshark-qt -y

	#VERACRYPT(criptare disco)
	echo " "
	echo -e $verde"[INSTALLAZIONE VERACRYPT(criptare disco)]"$fine
	sudo add-apt-repository ppa:unit193/encryption -y
	sudo apt-get update  > /dev/null
	sudo apt install veracrypt -y

	#MAT(exif data)
	echo " "
	echo -e $verde"[INSTALLAZIONE MAT(exif data)]"$fine
	sudo apt-get install mat -y

	#BLEACHBIT(Come CCleaner)
	echo " "
	echo -e $verde"[INSTALLAZIONE BLEACHBIT(Come CCleaner)]"$fine
	sudo apt install bleachbit -y

	#SECURE DELETED (SHRED)
	echo " "
	echo -e $verde"[INSTALLAZIONE SECURE DELETED (SHRED)]"$fine
	sudo apt-get install secure-delete -y

	#TOR BROWSER
	echo " "
	echo -e $verde"[INSTALLAZIONE TOR BROWSER]"$fine
	sudo touch /etc/apt/sources.list.d/tor.list
	sudo chmod 664 /etc/apt/sources.list.d/tor.list
	sudo echo "deb https://deb.torproject.org/torproject.org bionic main" >> /etc/apt/sources.list.d/tor.list
	sudo echo "deb-src https://deb.torproject.org/torproject.org bionic main" >> /etc/apt/sources.list.d/tor.list
	sudo curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | sudo gpg --import 
	sudo gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt install tor deb.torproject.org-keyring -y
	#non installato

	#GOOGLE CHROME BROWSER
	echo " "
	echo -e $verde"[INSTALLAZIONE GOOGLE CHROME BROWSER]"$fine
	sudo dpkg -i ~/Scaricati/google-chrome-stable_current_amd64.deb

	#VEIL
	echo " "
	echo -e $verde"[INSTALLAZIONE VEIL]"$fine
	cd /opt/
	sudo git clone https://github.com/Veil-Framework/Veil.git
	cd /opt/Veil
	sudo ./config/setup.sh --force --silent


	#SHELTER
	echo " "
	echo -e $verde"[INSTALLAZIONE SHELTER]"$fine
	sudo unzip ~/Scaricati/shellter.zip -d /opt/	


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
	echo "Per Metasploit nel caso durante la ricerca di un modulo si presentasse il messaggio [!] Module database cache not built yet, using slow search, possiamo correggere l’errore e beneficiare della ricerca veloce eseguendo i seguenti passaggi:"
	echo "msfconsole
	#	db_rebuild_cache
	#	quit
	#	service postgresql restart
	#	msfconsole"
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
