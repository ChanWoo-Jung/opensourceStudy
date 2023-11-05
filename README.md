# opensourceStudy
초반 도입 부
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

초반 도입 부에서는 echo를 통해서 이름과 학번 메뉴를 출력한다. 
메뉴는 총 9개가 있으며 해당하는 메뉴에 대한 설명은 밑에서 이어질 예정이다.
과제 설명 pdf를 참고했을 때 반복문을 통해서 메뉴 입력을 받을 수 있기에 while문으로 계속 메뉴 입력을 받을 수 있게 했다. 
read -p "Enter your choice [1-9] :" choice 이 문장을 통해서 선택할 메뉴를 받는다. read -p 를 통해 choice 숫자를 받을 수 있을 뿐더러 그 전에 설명도 작성이 가능하다.
switch문을 통해서 1~9번으로 갈 수 있게 설정했다. 

1번
설명 : 영화의 아이디를 입력받은 후 u.item 파일에서 해당 movie id와 같은 영화의 데이터를 출력한다.
코드: 
1)
        read -p "Please enter 'movie id' (1~1682) :" movieId
        cat u.item | awk -v mov_ID="$movieId" -F\| '$1==mov_ID';;

1)을 통해서 switch case문의 1번을 입력 받았구나 알 수 있다. 
movie id를 입력 받는다.
후에 u.item파일에서 읽기 위해 cat u.item을 활용하고 pipe로 u.item의 출력을 awk – v..에 넣는다.
-F 옵션을 사용하여 | 로 나누면서 row를 탐색한다.
미리 입력을 받았던 mov_ID와 같다면 해당 row를 출력한다. 단 반복문이 없기 때문에 해당 movie id의 row만 출력한다.
2번
설명 : u.item 파일에서 액션 장르의 영화들의 이름을 출력한다.
코드: 
  2)
        read -p "Do you want to get the data of ‘action’genre movies from 'u.item’?(y/n) : " yn
        if [ $yn = "y" ];then
                cat u.item | awk -F\| '$7==1{print $1,$2}' | head -n 10
        fi;;
2)을 통해서 switch case문의 2번을 입력 받았구나 알 수 있다.
u.item파일로부터 액션 장르의 데이터만 추출하기를 원하냐에 대한 여부를 입력한다. y / n
입력받은 $yn이 “y”라면을 위해 if문을 사용한다.
u.item을 불러오기 위해 cat을 활용하고 pipe로 u.item의 출력을 pipe 오른쪽으로 넣는다.
u.item은 | 로 나눠져 있기 때문에 -F\|로 나눠주고 장르의 위치가 있는 7번째를 이용해 액션인지 아닌지를 판단한다.
awk문을 통해 ‘$7==1{print $1,$2}’ 7번째가 1이면 액션인데 1이라면 movie id와 제목을 출력한다.
| 파이프를 활용해 head – n 10을 통해 위 10개만 출력한다.

3번
설명 : movie id를 입력받고 u.data에서 해당 movie id에 맞는 rating들의 평균을 구한다.

코드: 
        3)
        read -p "Please enter 'movie id' (1~1682) :" movieID
        cat u.data | awk -v mov_ID="$movieID" '$2==mov_ID {((sum+=$3)); ((cnt+=1))} END {printf("average rating of %d: %.5f\n",mov_ID, ((sum/cnt)))}';;
3)을 통해서 switch case문의 3번을 입력 받았구나 알 수 있다.
과제 설명 영상에 있던 도움을 받아 완성시킬 수 있었다.
u.data는 | 로 나눠져 있지 않아 편하게 불러올 수 있어 -F 옵션을 사용하지 않았다.
u.data의 두번째 영역인 $2와 mov_ID가 같다면 movie id를 찾았기에 sum에 rating에 해당하는 $3을 더해주고 cnt에도 1을 더해준다. 더해줄 때 arithmetic Expansion을 사용하기 위해 (( )) 내에서 연산이 진행되게끔 했다.
과제설명영상에서 알려주셨듯이 awk의 출력문 안에 ; 를 통해 여러 계산을 진행하고 END로 끝났다는 표현을 해준 후 마지막에 평균 rating을 출력했다.

4번
설명 : u.item으로 부터 URL을 삭제하자
코드: 
4)
        read -p "Do you want to delete the ‘IMDb URL’ from ‘u.item’?(y/n): " yn
        if [ $yn = "y" ];then
                cat u.item | sed 's/|http[^|]*|//g' | head -n 10

        fi;;
4)을 통해서 switch case문의 4번을 입력 받았구나 알 수 있다.
할지 말지에 대한 입력을 read -p로 받고 $yn이 y라면
URL 부분을 sed 이용해서 대체하여 삭제하면 된다.
sed 's/|http[^|]*|//g' 이 부분을 통해서 URL부분을 아무것도 없는 것으로 대체한다.
URL은 모두 |http로 시작하고 | 전에 끝난다. 따라서 [^|]* 를 통해 |이 아닌 모든 문자를 찾고 *을 통해 0번 이상 발생한 문자열을 찾는다. 
즉 | http ...... | 내부의 문자열을 ||로 대체할 수 있다.
/g를 통해 문자열 내의 http ....같은 패턴을 대체하도록 한다.
파이프를 통해 head -n 10 하여 상위 10개만 출력하도록 한다.
5번
설명 : u.user에서 상위 10명의 정보를 문장으로 출력하기
코드: 
    5)
    read -p "Do you want to get the data about users from ‘u.user’?(y/n):" yn
    if [ $yn = "y" ];then
            cat u.user | awk -F\| '{printf("user %d is %d years old %s %s\n",$1,$2,$3,$4)}' | head -n 10
    fi;;
5)을 통해서 switch case문의 5번을 입력 받았구나 알 수 있다.
할지 말지에 대한 입력을 read -p로 받고 $yn이 y라면
u.user 파일을 cat으로 접근하고 awk -F\| 를 통해 u.user의 data를 |로 구분하여 $ parameter로 접근한다. u.user에서 $1 = user id, $2 = age, $3 = gender , $4 = 직업을 parameter로 받아서 printf("user %d is %d years old %s %s\n",$1,$2,$3,$4)에 집어넣어 출력한다.
| head -n 10을 통해 상위 10개를 출력하도록 한다.

6번
설명 : u.item에서 release data를 년도/월/일로 변경한다.
코드: 
        read -p "Do you want to Modify the format of ‘release data’ in ‘u.item’?(y/n):" yn
        if [ $yn = "y" ];then
                cat u.item | sed -E 's/([0-9]+)-Jan-([0-9]+)/\201\1/g;s/([0-9]+)-Feb-([0-9]+)/\202\1/g;s/([0-9]+)-Mar-([0-9]+)/\203\1/g;s/([0-9]+)-Apr-([0-9]+)/\204\1/g;s/([0-9]+)-May-([0-9]+)/\205\1/g;s/([0-9]+)-Jun-([0-9]+)/\206\1/g;s/([0-9]+)-Jul-([0-9]+)/\207\1/g;s/([0-9]+)-Aug-([0-9]+)/\208\1/g;s/([0-9]+)-Sep-([0-9]+)/\209\1/g;s/([0-9]+)-Oct-([0-9]+)/\210\1/g;s/([0-9]+)-Nov-([0-9]+)/\211\1/g;s/([0-9]+)-Dec-([0-9]+)/\212\1/g;' | tail -n 10
        fi;;
6)을 통해서 switch case문의 6번을 입력 받았구나 알 수 있다.
할지 말지에 대한 입력을 read -p로 받고 $yn이 y라면
u.item파일에서 불러온다 = cat u.item
사실 교수님께서 의도한신 지는 모르겠지만 12달의 정보를 모두 입력하여 년도/월/일로 변경했다.
 's/([0-9]+)-Jan-([0-9]+)/\201\1/g;s/([0-9]+)-Feb-([0-9]+)/\202\1/g;
위의 코드만 분석해보면 ([0-9]+)를 통해 – 전에 숫자들 모두를 \1로 세팅, -Jan-은 01로 대체한다.
그 뒤의 ([0-9]+)를 \2로 대체하여 /\201\1/g 새롭게 출력한다.
01-Jan-1995가 19950101로 대체할 수 있게 된다. 
위의 과정을 1월 ~ 12월 까지 ;로 나누어서 선택되게 한다.
| tail -n 10을 통해 맨 뒤 10개만 출력한다.

7번
설명 : user id를 입력받고 그 user id가 평가한 movie id를 출력하고 movie id와 제목을 출력한다.
코드: 
7)
        read -p "Please enter the ‘user id’(1~943):" userID
        ids=$(cat u.data | awk -v UID="$userID" '$1==UID{print $2}' | sort -n)
        echo $ids | tr ' ' '|'

        for i in $ids
        do
                cat u.item | awk -v num="$i" -F\| '$1==num {print $1, $2}'
        done | head -n 10
        ;;
좀 만 생각해보면 간단한 코드이다. 
7)을 통해서 switch case문의 7번을 입력 받았구나 알 수 있다. 우선 userID를 입력을 받았다.
u.data파일에서 UID와 같은 $1을 비교하여 같다면 평가한 movie id를 정렬한 상태로 변수로 만든다. $ids안을 탐색하기 위해 for문을 사용했다. for문을 통해 u.item에 있는 movie id와 같은 것들을 찾는데 딱 상위 10개만 찾았다. $ids에 있는 $i로 받아가고 u.item에 있는 $1과 num이 같다면 
print $1 , $2를 진행한다.
이렇게 7번이 종료된다.


8번
설명 : 
read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as programmer'?(y/n)" yn
        if [ $yn = "y" ];then
                cat u.user | awk -F\| '$4=="programmer"&&$2>=20&&$2<=29{print $1, $2 ,$3 ,$4}'
                idx=$(cat u.user | awk -F\| '$4=="programmer"&&$2>=20&&$2<=29{print $1}')
                arr=$( for i in $idx
                        do
                                cat u.data | awk -v num="$i" 'num==$1{print$2"|"$3}'
                        done|sort -n )
                echo $arr
                sum=0
                cnt=0 코드: 

8)을 통해서 switch case문의 8번을 입력 받았구나 알 수 있다.
8번은 전부 완성하지 못했다.
20~29살까지 프로그래머들의 정보를 바탕으로 영화들의 rating들을 받아오는 것 까지 진행했다.
받아와서 arr이라는 변수에 |을 분기점으로 movie id와 점수들을 받아왔다. 후에 sort로 정렬까지 진행했다. 

9번
설명 : 9번이 선택되면 “BYE”가 출력되고 종료된다.
코드: 
 9)
                echo "BYE"
                break
9)을 통해서 switch case문의 9번을 입력 받았구나 알 수 있다.
echo를 통해 “BYE” 문장을 출력하고
while문으로 계속해서 돌고 있던 반복문을 탈출한다.
