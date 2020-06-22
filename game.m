
function [result]=game()
tableSize=input('Tablo Boyutu Giriniz: ');
if(tableSize <10)
    tableSize=10;
end

% oyuncunun oyun hakký
rightToPlay=round((tableSize*tableSize)/3);
% açýk tahtanýn tanýmlanmasý
openTable=zeros(tableSize+1,tableSize+1);% +1  sebebi 1 den tablo boyutuna kadar tablonun dýþ çerçevesinin oluþturulmasý(1 2 3 4 5 ..10)
% gizli tahtanýn tanýmlanmasý
secretTable(tableSize+1,tableSize+1)='?';

%gemi konumu için rastegele 1 sayý tanýmlanmasý
rast=randi([0,1],1,1);


%Gemi oluþturulmasý
% Not : 2 den baþlatmamýn sebebi 1 den tablo boyutuna kadar tablonun dýþ çerçevesinin oluþturulmasý(1 2 3 4 5 ..10)
fourthShip   = randi([2,tableSize-4+1],1,2); % 4 lük gemi için
thirdShip    = randi([2,tableSize-3+1],1,2);% 3 lük gemi için
secondShip   = randi([2,tableSize-2+1],1,2);% 2 lik gemi için
firstShip    = randi([2,tableSize],1,2);% 1 lik gemi için
%Oyun tahtasýnýn kurulumu
openTable(firstShip(1),firstShip(2))=1; % 1 lik gemi yerleþtirildi
if(rast==1)
    for i=0:3
        while(openTable(fourthShip(1)+1,fourthShip(2)+i+1) == 1 )
            fourthShip=randi(tableSize-2,1,2);
        end
        openTable(fourthShip(1),fourthShip(2)+i)=1;%yatay 4lük gemi
    end
    for i=0:2
        while(openTable(thirdShip(1)+i+1,thirdShip(2)+1) == 1)
            thirdShip=randi(tableSize-1,1,2);
        end
        openTable(thirdShip(1)+i,thirdShip(2))=1;%dikey 3lük gemi
    end
    for i=0:1
        while(openTable(secondShip(1)+i+1,secondShip(2)+1) == 1)
            secondShip=randi(tableSize,1,2);
        end
        openTable(secondShip(1)+i,secondShip(2))=1; %dikey 2lik gemi
    end
else
    for i=0:3
        
        while(openTable(fourthShip(1)+i+1,fourthShip(2)+1) == 1)
            fourthShip=randi(tableSize-2,1,2);
        end
        openTable(fourthShip(1)+i,fourthShip(2))=1;%dikey 4lük gemi
    end
    for i=0:2
        while(openTable(thirdShip(1)+1,thirdShip(2)+i+1) == 1  )
            thirdShip=randi(tableSize-1,1,2);
        end
        openTable(thirdShip(1),thirdShip(2)+i)=1; %yatay 3lük gemi
    end
    for i=0:1
        while(openTable(secondShip(1)+1,secondShip(2)+i+1) == 1)
            secondShip=randi(tableSize,1,2);
        end
        openTable(secondShip(1),secondShip(2)+i)=1;%yatay 2lik gemi
    end
end
%1 den tablo boyutuna kadar açýk tahtanýn dýþ çerçevesinin oluþturulmasý(1 2 3 4 5 ..10)
for j=1:tableSize+1
    openTable(j,1)=j-1;
    openTable(1,j)=j-1;
end


%gizli tablonun oluþturulmasý
% Not : 2 den baþlatmamýn sebebi 1 den tablo boyutuna kadar tablonun dýþ çerçevesinin oluþturulmasý(1 2 3 4 5 ..10)
for i=2:tableSize+1
    for j=2:tableSize+1
        secretTable(i,j)='?';
    end
end
%1 den tablo boyutuna kadar gizli tahtanýn dýþ çerçevesinin oluþturulmasý
for j=1:tableSize+1
    secretTable(j,1)='|';
    secretTable(1,j)='-';
end

%açýk tablonun yazdýrýlmasý.
for i=1:tableSize+1
    for j=1:tableSize+1
        fprintf('%d',openTable(i,j));
        fprintf('\t');
    end
    fprintf('\n');
end
fprintf('\n')
%gizli tablonun yazdýrýlmasý.
for i=1:tableSize+1
    for j=1:tableSize+1
        fprintf(secretTable(i,j));
        fprintf('\t');
    end
    fprintf('\n');
end

unity=0;duality=0;trinity=0;verse=0;puan=0;
for a=1:rightToPlay
    if(unity >0 && duality >0 && trinity >0 && verse >0)
        fprintf('Tebrikler Oyunu Tamamladýnýz! Puanýnýz : %d\n',puan);
        result=input('Oyuna tekrar baþlamak için 1 e, oyundan çýkmak için 0 a basýnýz : ');
        break;
        
    elseif(rightToPlay-a+1 == 0)
        result=3; break;
    else
        coor_x=input('Atýþ Ýçin X Koordinatý Belirtiniz: ');
        coor_y=input('Atýþ Ýçin Y Koordinatý Belirtiniz: ');
        if(isempty(coor_x)==1  || isempty(coor_y)==1)
            if(rightToPlay-a == 0)
                result=3; break;
            else
                fprintf('Kalan hakkýnýz : %d\n',rightToPlay-a);
                fprintf('Lütfen bir deðer giriniz.\n');
                continue;
            end
        end
        if(coor_x > tableSize  || coor_y > tableSize)
            if(rightToPlay-a == 0)
                result=3; break;
            else
                fprintf('Lütfen oyun alaný içerisinde bir deðer giriniz.\n');
                fprintf('Kalan hakkýnýz : %d\n',rightToPlay-a);
                continue;
            end
        end
        if(openTable(coor_x+1,coor_y+1) == 1)         % dýþ çerceve sebebiyle +1
            if(secretTable(coor_x+1,coor_y+1) == 'X') % dýþ çerceve sebebiyle +1
                fprintf('Daha Önce Bu Konuma Atýþ Yaptýnýz!\n');
                fprintf('Kalan hakkýnýz : %d\n',rightToPlay-a);
            else
                secretTable(coor_x+1,coor_y+1)='X';   % dýþ çerceve sebebiyle +1
                if(unity==0 && secretTable(firstShip(1),firstShip(2))=='X')
                    unity=unity+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi batýrdýnýz! \n');
                    
                elseif(duality==0     &&  secretTable(secondShip(1),secondShip(2)) =='X'  &&  secretTable(secondShip(1),secondShip(2)+1)=='X')
                    duality=duality+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi batýrdýnýz! \n');
                elseif(duality==0     &&  secretTable(secondShip(1),secondShip(2)) =='X'  &&   secretTable(secondShip(1)+1,secondShip(2))=='X')
                    duality=duality+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi batýrdýnýz! \n');
                elseif(trinity ==0     &&  secretTable(thirdShip(1),thirdShip(2))=='X'   &&   secretTable(thirdShip(1),thirdShip(2)+1)=='X' &&  secretTable(thirdShip(1),thirdShip(2)+2)=='X')
                    trinity=trinity+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi batýrdýnýz! \n');
                elseif(trinity ==0     &&  secretTable(thirdShip(1),thirdShip(2))=='X'   &&    secretTable(thirdShip(1)+1,thirdShip(2))=='X' &&  secretTable(thirdShip(1)+2,thirdShip(2))=='X')
                    trinity=trinity+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi batýrdýnýz! \n');
                elseif(verse == 0  &&  secretTable(fourthShip(1),fourthShip(2)) =='X'      &&    secretTable(fourthShip(1)+1,fourthShip(2))=='X'    &&   secretTable(fourthShip(1)+2,fourthShip(2))=='X'   &&  secretTable(fourthShip(1)+3,fourthShip(2))=='X' )
                    verse=verse+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi batýrdýnýz! \n');
                elseif(verse == 0  &&  secretTable(fourthShip(1),fourthShip(2)) =='X'      &&    secretTable(fourthShip(1),fourthShip(2)+1)=='X'    &&   secretTable(fourthShip(1),fourthShip(2)+2)=='X'  && secretTable(fourthShip(1),fourthShip(2)+3)=='X' )
                    verse=verse+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi batýrdýnýz! \n');
                else
                    fprintf('Tebrikler Bir Gemi Vurdunuz!\n');
                end
                
                if(rightToPlay-a == 0)
                    result=3; break;
                else
                    fprintf('Kalan hakkýnýz : %d\n',rightToPlay-a);
                end
            end
        elseif(openTable(coor_x+1,coor_y+1) == 0)       % dýþ çerceve sebebiyle +1
            if(secretTable(coor_x+1,coor_y+1) == '*')    % dýþ çerceve sebebiyle +1
                fprintf('Daha Önce Bu Konuma Atýþ Yaptýnýz!\n');
                
                if(rightToPlay-a == 0)
                    result=3; break;
                else
                    fprintf('Kalan hakkýnýz : %d\n',rightToPlay-a);
                end
            else
                secretTable(coor_x+1,coor_y+1)='*';
                fprintf('Maalesef isabet edemediniz!\n');
                if(rightToPlay-a == 0)
                    result=3; break;
                else
                    fprintf('Kalan hakkýnýz : %d\n',rightToPlay-a);
                end;
            end
        else
            secretTable(coor_x+1,coor_y+1)='?';
        end
        
        if(rightToPlay-a+1 ~=0)
            %açýk tablonun yazdýrýlmasý.
            for i=1:tableSize+1
                for j=1:tableSize+1
                    fprintf('%d',openTable(i,j));
                    fprintf('\t');
                end
                fprintf('\n');
            end
            fprintf('\n')
            %gizli tablonun yazdýrýlmasý.
            for i=1:tableSize+1
                for j=1:tableSize+1
                    fprintf(secretTable(i,j));
                    fprintf('\t');
                end
                fprintf('\n');
            end
        end
    end
end
end


