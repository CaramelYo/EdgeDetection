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



fid=fopen('sinpin.raw','r');
image=fread(fid, [427 427],'uint8');  
figure(1);

M=max(max(image));
C=image'/M;
n=size(C,2)-2;
matlabpool open ;   %為了平行處理 要把電腦其他核心叫醒 如果單核心的就只會跑一個core 四核心會開四個 可以在執行的時候看
                    %Starting matlabpool using the 'local' profile ... connected to n workers.
                    % n 代表activate幾顆核心
parfor i=1:size(C,1)-2      %平行處理用的for迴圈
    for j=1:n
        %Sobel mask for x-direction:
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
      
        %The gradient of the image
        %B(i,j)=abs(Gx)+abs(Gy);
        B(i,j)=sqrt(Gx.^2+Gy.^2);
      
    end
end
matlabpool close ;  %把為了平行處理而打開的核心關起來
imshow(B); title('Sobel gradient');

