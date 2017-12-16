echo "This script will automatically accept Steam SA on all accounts"

read -p "Press ENTER to continue"

for i in $(seq 1 $max)
do
	echo "catbot-$i has read the Steam SA"
	sudo -H -u catbot-$i bash -c "cp ~/.steam/steam/steam_install_agreement.txt ~/.steam"
done