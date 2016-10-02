%fid=fopen('test.raw','r');
%image=fread(fid, [300 400],'uint8');  %�j�p256256 array �C��pixel��1��byte(uint8)
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
fid=fopen('sinpin.raw','r');            %���}�ɮ� ���ɩM.m�ɭn��b�P�@�Ӹ�Ƨ��A���M�N�n�����|
image=fread(fid, [427 427],'uint8');   
%��Ϥ����C��pixelŪ�Jimage�o��array �Ϥ����j�p�O300(col)*400(row) ��Ϥ����C��pixel�ഫ��
% unsigned int 8 bit(1 byte)�s�Jarray
figure(1);  %�}�@�Ӫťժ�����

%-----------��Ϥ�rgb���ন�Ƕ���----------------------%

M=max(max(image)); %��X�C��image���̤j���� �Ĥ@��max�|���col���̤j���A�ĤG�ӷ|�q�C��col�̳̤j����X�̤j��
C=image'/M; %��array�̭��C�ӭȰ��H�̤j��

%----------- edge detection (sobel operation)--------------------%
for i=1:size(C,1)-2     %-2�O�]���b�k����t���ɭ�mask���i��|�W�X�h
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