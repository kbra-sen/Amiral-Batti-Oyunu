
function [result]=game()
tableSize=input('Tablo Boyutu Giriniz: ');
if(tableSize <10)
    tableSize=10;
end

% oyuncunun oyun hakk�
rightToPlay=round((tableSize*tableSize)/3);
% a��k tahtan�n tan�mlanmas�
openTable=zeros(tableSize+1,tableSize+1);% +1  sebebi 1 den tablo boyutuna kadar tablonun d�� �er�evesinin olu�turulmas�(1 2 3 4 5 ..10)
% gizli tahtan�n tan�mlanmas�
secretTable(tableSize+1,tableSize+1)='?';

%gemi konumu i�in rastegele 1 say� tan�mlanmas�
rast=randi([0,1],1,1);


%Gemi olu�turulmas�
% Not : 2 den ba�latmam�n sebebi 1 den tablo boyutuna kadar tablonun d�� �er�evesinin olu�turulmas�(1 2 3 4 5 ..10)
fourthShip   = randi([2,tableSize-4+1],1,2); % 4 l�k gemi i�in
thirdShip    = randi([2,tableSize-3+1],1,2);% 3 l�k gemi i�in
secondShip   = randi([2,tableSize-2+1],1,2);% 2 lik gemi i�in
firstShip    = randi([2,tableSize],1,2);% 1 lik gemi i�in
%Oyun tahtas�n�n kurulumu
openTable(firstShip(1),firstShip(2))=1; % 1 lik gemi yerle�tirildi
if(rast==1)
    for i=0:3
        while(openTable(fourthShip(1)+1,fourthShip(2)+i+1) == 1 )
            fourthShip=randi(tableSize-2,1,2);
        end
        openTable(fourthShip(1),fourthShip(2)+i)=1;%yatay 4l�k gemi
    end
    for i=0:2
        while(openTable(thirdShip(1)+i+1,thirdShip(2)+1) == 1)
            thirdShip=randi(tableSize-1,1,2);
        end
        openTable(thirdShip(1)+i,thirdShip(2))=1;%dikey 3l�k gemi
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
        openTable(fourthShip(1)+i,fourthShip(2))=1;%dikey 4l�k gemi
    end
    for i=0:2
        while(openTable(thirdShip(1)+1,thirdShip(2)+i+1) == 1  )
            thirdShip=randi(tableSize-1,1,2);
        end
        openTable(thirdShip(1),thirdShip(2)+i)=1; %yatay 3l�k gemi
    end
    for i=0:1
        while(openTable(secondShip(1)+1,secondShip(2)+i+1) == 1)
            secondShip=randi(tableSize,1,2);
        end
        openTable(secondShip(1),secondShip(2)+i)=1;%yatay 2lik gemi
    end
end
%1 den tablo boyutuna kadar a��k tahtan�n d�� �er�evesinin olu�turulmas�(1 2 3 4 5 ..10)
for j=1:tableSize+1
    openTable(j,1)=j-1;
    openTable(1,j)=j-1;
end


%gizli tablonun olu�turulmas�
% Not : 2 den ba�latmam�n sebebi 1 den tablo boyutuna kadar tablonun d�� �er�evesinin olu�turulmas�(1 2 3 4 5 ..10)
for i=2:tableSize+1
    for j=2:tableSize+1
        secretTable(i,j)='?';
    end
end
%1 den tablo boyutuna kadar gizli tahtan�n d�� �er�evesinin olu�turulmas�
for j=1:tableSize+1
    secretTable(j,1)='|';
    secretTable(1,j)='-';
end

%a��k tablonun yazd�r�lmas�.
for i=1:tableSize+1
    for j=1:tableSize+1
        fprintf('%d',openTable(i,j));
        fprintf('\t');
    end
    fprintf('\n');
end
fprintf('\n')
%gizli tablonun yazd�r�lmas�.
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
        fprintf('Tebrikler Oyunu Tamamlad�n�z! Puan�n�z : %d\n',puan);
        result=input('Oyuna tekrar ba�lamak i�in 1 e, oyundan ��kmak i�in 0 a bas�n�z : ');
        break;
        
    elseif(rightToPlay-a+1 == 0)
        result=3; break;
    else
        coor_x=input('At�� ��in X Koordinat� Belirtiniz: ');
        coor_y=input('At�� ��in Y Koordinat� Belirtiniz: ');
        if(isempty(coor_x)==1  || isempty(coor_y)==1)
            if(rightToPlay-a == 0)
                result=3; break;
            else
                fprintf('Kalan hakk�n�z : %d\n',rightToPlay-a);
                fprintf('L�tfen bir de�er giriniz.\n');
                continue;
            end
        end
        if(coor_x > tableSize  || coor_y > tableSize)
            if(rightToPlay-a == 0)
                result=3; break;
            else
                fprintf('L�tfen oyun alan� i�erisinde bir de�er giriniz.\n');
                fprintf('Kalan hakk�n�z : %d\n',rightToPlay-a);
                continue;
            end
        end
        if(openTable(coor_x+1,coor_y+1) == 1)         % d�� �erceve sebebiyle +1
            if(secretTable(coor_x+1,coor_y+1) == 'X') % d�� �erceve sebebiyle +1
                fprintf('Daha �nce Bu Konuma At�� Yapt�n�z!\n');
                fprintf('Kalan hakk�n�z : %d\n',rightToPlay-a);
            else
                secretTable(coor_x+1,coor_y+1)='X';   % d�� �erceve sebebiyle +1
                if(unity==0 && secretTable(firstShip(1),firstShip(2))=='X')
                    unity=unity+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi bat�rd�n�z! \n');
                    
                elseif(duality==0     &&  secretTable(secondShip(1),secondShip(2)) =='X'  &&  secretTable(secondShip(1),secondShip(2)+1)=='X')
                    duality=duality+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi bat�rd�n�z! \n');
                elseif(duality==0     &&  secretTable(secondShip(1),secondShip(2)) =='X'  &&   secretTable(secondShip(1)+1,secondShip(2))=='X')
                    duality=duality+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi bat�rd�n�z! \n');
                elseif(trinity ==0     &&  secretTable(thirdShip(1),thirdShip(2))=='X'   &&   secretTable(thirdShip(1),thirdShip(2)+1)=='X' &&  secretTable(thirdShip(1),thirdShip(2)+2)=='X')
                    trinity=trinity+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi bat�rd�n�z! \n');
                elseif(trinity ==0     &&  secretTable(thirdShip(1),thirdShip(2))=='X'   &&    secretTable(thirdShip(1)+1,thirdShip(2))=='X' &&  secretTable(thirdShip(1)+2,thirdShip(2))=='X')
                    trinity=trinity+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi bat�rd�n�z! \n');
                elseif(verse == 0  &&  secretTable(fourthShip(1),fourthShip(2)) =='X'      &&    secretTable(fourthShip(1)+1,fourthShip(2))=='X'    &&   secretTable(fourthShip(1)+2,fourthShip(2))=='X'   &&  secretTable(fourthShip(1)+3,fourthShip(2))=='X' )
                    verse=verse+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi bat�rd�n�z! \n');
                elseif(verse == 0  &&  secretTable(fourthShip(1),fourthShip(2)) =='X'      &&    secretTable(fourthShip(1),fourthShip(2)+1)=='X'    &&   secretTable(fourthShip(1),fourthShip(2)+2)=='X'  && secretTable(fourthShip(1),fourthShip(2)+3)=='X' )
                    verse=verse+1;
                    puan=rightToPlay-a;
                    fprintf('Tebrikler bir gemi bat�rd�n�z! \n');
                else
                    fprintf('Tebrikler Bir Gemi Vurdunuz!\n');
                end
                
                if(rightToPlay-a == 0)
                    result=3; break;
                else
                    fprintf('Kalan hakk�n�z : %d\n',rightToPlay-a);
                end
            end
        elseif(openTable(coor_x+1,coor_y+1) == 0)       % d�� �erceve sebebiyle +1
            if(secretTable(coor_x+1,coor_y+1) == '*')    % d�� �erceve sebebiyle +1
                fprintf('Daha �nce Bu Konuma At�� Yapt�n�z!\n');
                
                if(rightToPlay-a == 0)
                    result=3; break;
                else
                    fprintf('Kalan hakk�n�z : %d\n',rightToPlay-a);
                end
            else
                secretTable(coor_x+1,coor_y+1)='*';
                fprintf('Maalesef isabet edemediniz!\n');
                if(rightToPlay-a == 0)
                    result=3; break;
                else
                    fprintf('Kalan hakk�n�z : %d\n',rightToPlay-a);
                end;
            end
        else
            secretTable(coor_x+1,coor_y+1)='?';
        end
        
        if(rightToPlay-a+1 ~=0)
            %a��k tablonun yazd�r�lmas�.
            for i=1:tableSize+1
                for j=1:tableSize+1
                    fprintf('%d',openTable(i,j));
                    fprintf('\t');
                end
                fprintf('\n');
            end
            fprintf('\n')
            %gizli tablonun yazd�r�lmas�.
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


