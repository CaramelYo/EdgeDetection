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



fid=fopen('sinpin.raw','r');
image=fread(fid, [427 427],'uint8');  
figure(1);

M=max(max(image));
C=image'/M;
n=size(C,2)-2;
matlabpool open ;   %���F����B�z �n��q����L�֤ߥs�� �p�G��֤ߪ��N�u�|�]�@��core �|�֤߷|�}�|�� �i�H�b���檺�ɭԬ�
                    %Starting matlabpool using the 'local' profile ... connected to n workers.
                    % n �N��activate�X���֤�
parfor i=1:size(C,1)-2      %����B�z�Ϊ�for�j��
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
matlabpool close ;  %�⬰�F����B�z�ӥ��}���֤����_��
imshow(B); title('Sobel gradient');

