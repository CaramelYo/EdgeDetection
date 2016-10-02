%fid=fopen('test.raw','r');
%image=fread(fid, [300 400],'uint8');  %大小256256 array 每個pixel為1個byte(uint8)
%figure(1);

%i1 = fread(fid, [300 400], 'uint8=>uint8'); %red channel
%i2 = fread(fid, [300 400], 'uint8=>uint8'); %g
%i3 = fread(fid, [300 400], 'uint8=>uint8'); %b

%i1 = i1.'; i2 = i2.'; i3 = i3.';
%final = cat(3, i1,i2,i3);

%M=max(max(image));
%K=image'/M;
%imshow(final);

%---------------------------------------------------
fid=fopen('sinpin.raw','r');            %打開檔案 圖檔和.m檔要放在同一個資料夾，不然就要打路徑
image=fread(fid, [427 427],'uint8');   
%把圖片的每個pixel讀入image這個array 圖片的大小是300(col)*400(row) 把圖片的每個pixel轉換成
% unsigned int 8 bit(1 byte)存入array
figure(1);  %開一個空白的圖檔

%-----------把圖片rgb值轉成灰階值----------------------%

M=max(max(image)); %找出每個image中最大的值 第一個max會找到col中最大的，第二個會從每個col裡最大的找出最大的
C=image'/M; %把array裡面每個值除以最大值

%----------- edge detection (sobel operation)--------------------%
for i=1:size(C,1)-2     %-2是因為在右邊邊緣的時候mask有可能會超出去
    for j=1:size(C,2)-2
        %Sobel mask for x-direction:
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
      
        %The gradient of the image
        %B(i,j)=abs(Gx)+abs(Gy);
        B(i,j)=sqrt(Gx.^2+Gy.^2);    
    end
end
imshow(B);  %image show