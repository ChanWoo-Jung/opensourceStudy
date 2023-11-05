#$ u.item u.data u.user
echo "-------------------------"
echo "User Name: $(whoami)"
echo "Student Number: 12191823"
echo "[ MENU ]"
echo "
1. Get the data of the movie identified by a specific
'movie id' from 'u.item'
2. Get the data of action genre movies from 'u.item’
3. Get the average 'rating’ of the movie identified by
specific 'movie id' from 'u.data’
4. Delete the ‘IMDb URL’ from ‘u.item
5. Get the data about users from 'u.user’
6. Modify the format of 'release date' in 'u.item’
7. Get the data of movies rated by a specific 'user id'
from 'u.data'
8. Get the average 'rating' of movies rated by users with
'age' between 20 and 29 and 'occupation' as 'programmer'
9. Exit
--------------------------"
while true
do
read -p "Enter your choice [1-9] :" choice

case $choice in

	1) 
	read -p "Please enter 'movie id' (1~1682) :" movieId
	cat u.item | awk -v mov_ID="$movieId" -F\| '$1==mov_ID';;
	   
   	2)	   
	read -p "Do you want to get the data of ‘action’genre movies from 'u.item’?(y/n) : " yn
	if [ $yn = "y" ];then
		cat u.item | awk -F\| '$7==1{print $1,$2}' | head -n 10
	fi;;
		
	3)
	read -p "Please enter 'movie id' (1~1682) :" movieID
	cat u.data | awk -v mov_ID="$movieID" '$2==mov_ID {((sum+=$3)); ((cnt+=1))} END {printf("average rating of %d: %.5f\n",mov_ID, ((sum/cnt)))}';;
	
	4)
	read -p "Do you want to delete the ‘IMDb URL’ from ‘u.item’?(y/n): " yn
	if [ $yn = "y" ];then
		cat u.item | sed 's/|http[^|]*|//g' | head -n 10

	fi;;
	
	5)
	read -p "Do you want to get the data about users from ‘u.user’?(y/n):" yn
	if [ $yn = "y" ];then
		cat u.user | awk -F\| '{printf("user %d is %d years old %s %s\n",$1,$2,$3,$4)}' | head -n 10
	fi;;
	
	6)
	read -p "Do you want to Modify the format of ‘release data’ in ‘u.item’?(y/n):" yn
	if [ $yn = "y" ];then
	 	cat u.item | sed -E 's/([0-9]+)-Jan-([0-9]+)/\201\1/g;s/([0-9]+)-Feb-([0-9]+)/\202\1/g;s/([0-9]+)-Mar-([0-9]+)/\203\1/g;s/([0-9]+)-Apr-([0-9]+)/\204\1/g;s/([0-9]+)-May-([0-9]+)/\205\1/g;s/([0-9]+)-Jun-([0-9]+)/\206\1/g;s/([0-9]+)-Jul-([0-9]+)/\207\1/g;s/([0-9]+)-Aug-([0-9]+)/\208\1/g;s/([0-9]+)-Sep-([0-9]+)/\209\1/g;s/([0-9]+)-Oct-([0-9]+)/\210\1/g;s/([0-9]+)-Nov-([0-9]+)/\211\1/g;s/([0-9]+)-Dec-([0-9]+)/\212\1/g;' | tail -n 10
	fi;;

	7)
	read -p "Please enter the ‘user id’(1~943):" userID
	ids=$(cat u.data | awk -v UID="$userID" '$1==UID{print $2}' | sort -n)
	echo $ids | tr ' ' '|'
	
	for i in $ids
	do
		cat u.item | awk -v num="$i" -F\| '$1==num {print $1, $2}'
	done | head -n 10
	;;


	8)
	read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as programmer'?(y/n)" yn
	if [ $yn = "y" ];then
		idx=$(cat u.user | awk -F\| '$4=="programmer"&&$2>=20&&$2<=29{print $1}')
		arr=$( for i in $idx 
			do 
				cat u.data | awk -v num="$i" 'num==$1{print$2"-"$3}'
			done|sort -n )

		sum=0
	       	cnt=0
		

	fi;;


	9)
		echo "BYE"
		break	

esac

done





















