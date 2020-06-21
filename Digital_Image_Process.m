function varargout = Digital_Image_Process(varargin)
% DIGITAL_IMAGE_PROCESS MATLAB code for Digital_Image_Process.fig
%      DIGITAL_IMAGE_PROCESS, by itself, creates a new DIGITAL_IMAGE_PROCESS or raises the existing
%      singleton*.
%
%      H = DIGITAL_IMAGE_PROCESS returns the handle to a new DIGITAL_IMAGE_PROCESS or the handle to
%      the existing singleton*.
%
%      DIGITAL_IMAGE_PROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIGITAL_IMAGE_PROCESS.M with the given input arguments.
%
%      DIGITAL_IMAGE_PROCESS('Property','Value',...) creates a new DIGITAL_IMAGE_PROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Digital_Image_Process_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Digital_Image_Process_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Digital_Image_Process

% Last Modified by GUIDE v2.5 08-Jun-2020 12:10:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Digital_Image_Process_OpeningFcn, ...
                   'gui_OutputFcn',  @Digital_Image_Process_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Digital_Image_Process is made visible.
function Digital_Image_Process_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Digital_Image_Process (see VARARGIN)

% Choose default command line output for Digital_Image_Process
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Digital_Image_Process wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Digital_Image_Process_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dakai_Callback(hObject, eventdata, handles)
% hObject    handle to dakai (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%获取图片的名称和路径
[imgfilename imgpathname]=uigetfile({'*.jpg;*.png'},'Select a RGB image');

if imgfilename
    %读取图片
    imgdata=imread([imgpathname '\' imgfilename]); 
    %显示图片
    %大小为原图的大小
    axes(handles.axes1)
    imshow(imgdata)
    %以下的写法显示的图片被限制在axes框的大小中了
   %image(handles.axes1,imgdata);
    %设置全局变量：打开的图片名称
    handles.imgfilename=imgfilename;
    %设置全局变量：打开的图片路径
    handles.imgdata=imgdata;    

end
%更新全局变量
[r,c] = size(imgdata)
set(handles.edit7,'String',num2str(r));
set(handles.edit8,'String',num2str(c));
guidata(hObject,handles)

% --------------------------------------------------------------------
function saveGray_Callback(hObject, eventdata, handles)
% hObject    handle to saveGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%保存灰度图

%获取保存图片的名称和路径
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';
                                 '*.bmp','Bitmap(*.bmp)';
                                 '*.gif','GIF(*.gif)';
                                 '*.*',  'All Files (*.*)'},'Save Picture','Untitled');

if FileName==0
    return;

else
    %这么写保存的图像的大小与打开的原图像的大小相同
    imwrite(handles.imggray,[PathName,FileName]);

%     这种写法是保存axes2的内容，图像的大小和axes2的大小一致
%     h=getframe(handles.axes2);
% 
%     imwrite(h.cdata,[PathName,FileName]);

end;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示灰度图
if ~isempty(handles.imgfilename)
    %将彩色图片变成灰色
    imgoutput=rgb2gray(handles.imgdata);
    %绘制灰度图
    %image(handles.axes2,imgoutput)
    axes(handles.axes2);imshow(imgoutput)
    %选择颜色映射
    colormap(handles.axes2,gray(256))
    %全局变量：原始图转换为的灰度图
    handles.imggray=imgoutput;

end
guidata(hObject,handles)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示灰度图的直方图	
axes(handles.axes4)
[nk,rk]=imhist(handles.imggray);
bar(rk,nk,0.3);%0.3是柱子的宽度
%以下写法是显示指定区间的
%histogram(handles.imggray,100:125); 

% --------------------------------------------------------------------
function saveTrans_Callback(hObject, eventdata, handles)
% hObject    handle to saveTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%保存变换后的图片

%获取保存图片的名称和路径
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';
                                 '*.bmp','Bitmap(*.bmp)';
                                 '*.gif','GIF(*.gif)';
                                 '*.*',  'All Files (*.*)'},'Save Picture','Untitled');

if FileName==0
    return;

else
%     %这么写保存的图像的大小与打开的原图像的大小相同
%     imwrite(handles.imggray,[PathName,FileName]);

   % 这种写法是保存axes2的内容，图像的大小和axes3的大小一致
    h=getframe(handles.axes3);

    imwrite(h.cdata,[PathName,FileName]);

end;


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function junhenghua_Callback(hObject, eventdata, handles)
% hObject    handle to junhenghua (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%直方图均衡化操作

after_img = histeq(handles.imggray);  %均衡化操作

%显示均衡化后的图片
axes(handles.axes3);
imshow(after_img)
% image(handles.axes3,after_img)
%选择颜色映射
% colormap(handles.axes3,gray(256))
%保存为全局变量:直方图均衡化后的图像
handles.after_img = after_img
guidata(hObject,handles)

% --------------------------------------------------------------------
function junhenghuahouzhifnagtu_Callback(hObject, eventdata, handles)
% hObject    handle to junhenghuahouzhifnagtu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示均衡化后的直方图
axes(handles.axes4)
[new0,x0]=imhist(handles.after_img); 
bar(x0,new0,0.3);%0.3是柱子的宽度


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

th = get(handles.slider1,'Value')%0~1之间的一个数值
%滑动条最大值为1.0，最小值为0.0是因为im2bw函数的阈值输入在0~1之间
%所以在文本框中显示的时候*255
set(handles.edit1,'String',num2str(round(th*255)));

%全局变量 二值化时自定义拖动选择的阈值
handles.binary_thresh = th;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示所选择的阈值大小

% th = get(handles.slider1,'Value');%0~1之间的一个数值
% %滑动条最大值为1.0，最小值为0.0是因为im2bw函数的阈值输入在0~1之间
% %所以在文本框中显示的时候*255
% set(handles.edit1,'String',num2str(round(th*255)));
% 
% %全局变量 二值化时自定义拖动选择的阈值
% handles.binary_thresh = th;
% guidata(hObject,handles)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示二值化图片


a=im2double(handles.imggray);
binary_img = im2bw(a,handles.binary_thresh);
%显示二值化后的图片
axes(handles.axes3)
imshow(binary_img)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function add_noise_Callback(hObject, eventdata, handles)
% hObject    handle to add_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function gaussi_Callback(hObject, eventdata, handles)
% hObject    handle to gaussi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%添加高斯噪声

prompt={'请设置高斯噪声的均值' '请设置高斯噪声的方差' };
name='设置高斯噪声';
numlines=1;
defaultanswer={'0.04' '0.01'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});
x2=str2num(anss{2});

gaussi=imnoise(handles.imggray,'gaussian',x1,x2);
axes(handles.axes3)
imshow(gaussi)

% %保存全局变量：添加了高斯噪声的灰度图
% handles.imggray_add_gaus = gaussi
%保存全局变量：添加了噪声的灰度图
handles.imggray_add_noise = gaussi
guidata(hObject,handles)



% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%对截取区域图像几何变换

%判断是否存在截取区域，如果不存在就==0，弹出提示框
if exist('handles.roi') ==0
   disp('请先截取感兴趣的区域!');
end
var = get(handles.listbox1,'Value');
axes(handles.axes3);
switch var
    case 1    %按比例放大2倍
        a = imresize(handles.roi,2);
        image(handles.axes3,a);colormap(handles.axes3,gray(256))
    case 2      %按比例缩小0.5倍
        a = imresize(handles.roi,0.5);
        image(handles.axes3,a);colormap(handles.axes3,gray(256))
    case 3     %非比例放大
        a = imresize(handles.roi,[420,348],'nearest');
        image(handles.axes3,a);colormap(handles.axes3,gray(256))
    case 4     %非比例缩小
        a = imresize(handles.roi,[150,180],'nearest');
        image(handles.axes3,a); colormap(handles.axes3,gray(256))
    case 5      %双线性放大2
        a = imresize(handles.roi,2,'bilinear');
        image(handles.axes3,a); colormap(handles.axes3,gray(256))
     case 6      %双线性缩小0.5 
        a = imresize(handles.roi,0.5,'bilinear');
        image(handles.axes3,a); colormap(handles.axes3,gray(256))
    case 7      %逆时针旋转45度
        a = imrotate(handles.roi,45);
        imshow(a)
    case 8      %顺时针旋转90度
        a = imrotate(handles.roi,-90);imshow(a)
    case 9      %上下翻转
        a = flipud(handles.roi);imshow(a)
    case 10      %顺时针旋转90度
        a = fliplr(handles.roi);imshow(a)
end
[r,c] = size(a)
set(handles.edit9,'String',num2str(r));
set(handles.edit10,'String',num2str(c));        
% --------------------------------------------------------------------
function saltpepper_Callback(hObject, eventdata, handles)
% hObject    handle to saltpepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%添加椒盐噪声

prompt={'请设置椒盐噪声的密度'};
name='设置椒盐噪声';
numlines=1;
defaultanswer={'0.04'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});

saltpepper=imnoise(handles.imggray,'salt & pepper',x1);
axes(handles.axes3)
imshow(saltpepper)

%保存全局变量：添加了椒盐噪声的灰度图
%handles.imggray_add_saltpepper = saltpepper
%保存全局变量：添加了噪声的灰度图
handles.imggray_add_noise = saltpepper
guidata(hObject,handles)

% --------------------------------------------------------------------
function speckle_Callback(hObject, eventdata, handles)
% hObject    handle to speckle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%添加乘性噪声

prompt={'请设置乘性噪声的密度'};
name='设置乘性噪声';
numlines=1;
defaultanswer={'0.04'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});

speckle=imnoise(handles.imggray,'speckle',x1);
axes(handles.axes3)
imshow(speckle)

% %保存全局变量：添加了乘性噪声的灰度图
% handles.imggray_add_speckle = speckle
%保存全局变量：添加了噪声的灰度图
handles.imggray_add_noise = speckle
guidata(hObject,handles)


% --------------------------------------------------------------------
function zhongzhi3_Callback(hObject, eventdata, handles)
% hObject    handle to zhongzhi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
e=medfilt2(handles.imggray_add_noise,[3,3]);  
axes(handles.axes3);imshow(e)

% --------------------------------------------------------------------
function zhongzhi5_Callback(hObject, eventdata, handles)
% hObject    handle to zhongzhi5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%中值滤波

prompt={'中值滤波：请设置卷积核的大小'};%对话框的提示内容
%另外弹出一个提示框
msgbox('建议输入以下几种大小，3或5，输入一个数字即可');
name='设置卷积核大小'; %对话框的名称
numlines=1;
defaultanswer={'3'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});

e=medfilt2(handles.imggray_add_noise,[x1,x1]);  
axes(handles.axes3);imshow(e);

% --------------------------------------------------------------------
function junzhi3_Callback(hObject, eventdata, handles)
% hObject    handle to junzhi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%先创建一个均值mask  
average_mask=fspecial('average',[3,3]);%创建一个均值模板,默认的大小是3*3  
f=imfilter(handles.imggray_add_noise,average_mask);%前面是图片，后面是模板  
axes(handles.axes3);imshow(f)

% --------------------------------------------------------------------
function junzhi5_Callback(hObject, eventdata, handles)
% hObject    handle to junzhi5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
average_mask=fspecial('average',[5,5]);%创建一个均值模板,默认的大小是3*3  
f=imfilter(handles.imggray_add_noise,average_mask);%前面是图片，后面是模板  
axes(handles.axes3);imshow(f)


% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fushi_Callback(hObject, eventdata, handles)
% hObject    handle to fushi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pegnzhang_Callback(hObject, eventdata, handles)
% hObject    handle to pegnzhang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function pengzhang3_Callback(hObject, eventdata, handles)
% hObject    handle to pengzhang3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(3,3); 
a = imdilate(handles.imggray,mask);
axes(handles.axes3);imshow(a);

% --------------------------------------------------------------------
function pengzhang5_Callback(hObject, eventdata, handles)
% hObject    handle to pengzhang5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(5,5); 
a = imdilate(handles.imggray,mask);
axes(handles.axes3);imshow(a);


% --------------------------------------------------------------------
function fushi3_Callback(hObject, eventdata, handles)
% hObject    handle to fushi3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(3,3); 
a = imerode(handles.imggray,mask);
axes(handles.axes3);imshow(a);

% --------------------------------------------------------------------
function fushi5_Callback(hObject, eventdata, handles)
% hObject    handle to fushi5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask=ones(5,5); 
a = imerode(handles.imggray,mask);
axes(handles.axes3);imshow(a);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
val = get(handles.checkbox1,'Value');
if val == 1.0
   Th=graythresh(handles.imggray); %OTSU阈值
   set(handles.edit2,'String',num2str(round(Th*255)));
   handles.Th = Th;
else
   set(handles.edit2,'String','  ');
end

%保存全局变量：大津阈值
% handles.Th = Th;
guidata(hObject,handles)
    
    

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= im2bw(handles.imggray,handles.Th);
axes(handles.axes3);imshow(a);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%边缘检测按钮组

%获取当前选中的按钮的tag（是字符串哦）
current_obj = get(eventdata.NewValue,'Tag');
switch current_obj
    case 'radiobutton_Canny'
        a = edge(handles.imggray,'canny'); 
        image(handles.axes3,a);
        colormap(handles.axes2,gray(100));
%         axes(handles.axes3);imshow(a);
    case 'radiobutton_Roberts'
        a = edge(handles.imggray,'Roberts'); 
        axes(handles.axes3);imshow(a);
    case 'radiobutton_Sobel'
        a = edge(handles.imggray,'Sobel'); 
        axes(handles.axes3);imshow(a);
    case 'radiobutton_Prewitt'
        a = edge(handles.imggray,'Prewitt'); 
        axes(handles.axes3);imshow(a);
    case 'radiobutton_LoG'
        a = edge(handles.imggray,'LoG'); 
        axes(handles.axes3);imshow(a);
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%线性灰度变换

a = str2num(get(handles.edit3,'String'));
b = str2num(get(handles.edit4,'String'));
c = str2num(get(handles.edit5,'String'));
d = str2num(get(handles.edit6,'String'));

img = imadjust(handles.imggray,[a b],[c d]); 
axes(handles.axes3);imshow(img);


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
%显示轮廓

val = get(handles.radiobutton6,'Value');
if val == 1.0
    Th = graythresh(handles.imggray);
    binary_img = im2bw(handles.imggray,Th);
    a= bwperim(binary_img);
    axes(handles.axes3);imshow(a);
else 
    %未选中时显示灰度图
    axes(handles.axes3);imshow(handles.imggray);
end


% --------------------------------------------------------------------
function junzhizidingyi_Callback(hObject, eventdata, handles)
% hObject    handle to junzhizidingyi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置卷积核的大小'};%对话框的提示内容
name='设置卷积核大小'; %对话框的名称
numlines=1;
defaultanswer={'3'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});

average_mask=fspecial('average',[x1,x1]);%创建一个均值模板,默认的大小是3*3  
f=imfilter(handles.imggray_add_noise,average_mask);%前面是图片，后面是模板  
axes(handles.axes3);imshow(f)


% --------------------------------------------------------------------
function Untitled_18_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'均值滤波，请设置卷积核的大小'};%对话框的提示内容
%另外弹出一个提示框
msgbox('建议输入以下几种大小，3或5，输入一个数字即可');
name='设置卷积核大小'; %对话框的名称
numlines=1;
defaultanswer={'3'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
x1=str2num(anss{1});

average_mask=fspecial('average',[x1,x1]);%创建一个均值模板,默认的大小是3*3  
f=imfilter(handles.imggray_add_noise,average_mask);%前面是图片，后面是模板  
axes(handles.axes3);imshow(f)


% --------------------------------------------------------------------
function Untitled_19_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_24_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想带通滤波器的低半径' '请设置理想带通滤波器的高半径'};
name='理想带通滤波器的带宽设置';
numlines=1;
defaultanswer={'5' '15'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
D1=str2num(anss{2});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=double(D>=D0&D<=D1);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_25_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想带阻滤波器的低半径' '请设置理想带阻滤波器的高半径'};
name='理想带阻滤波器的带宽设置';
numlines=1;
defaultanswer={'5' '15'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
D1=str2num(anss{2});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1-double(D>=D0&D<=D1);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想高通滤波器的半径' };
name='理想高通滤波器的半径';
numlines=1;
defaultanswer={'10'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=double(D>=D0);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置巴特沃斯高通滤波器的截止频率半径' '请设置巴特沃斯高通滤波器的阶数'};
name='巴特沃斯高通滤波器的截止频率半径和阶数';
numlines=1;
defaultanswer={'10' '1'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
n=str2num(anss{2});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1-1./(1+(D./D0).^(2*n));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置高斯高通滤波器的截止频率（方差）' };
name='高斯高通滤波器的截止频率（方差）';
numlines=1;
defaultanswer={'10'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1-exp(-(D.^2)./(2*(D0^2)));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置理想低通滤波器的半径' };
name='理想低通滤波器的半径';
numlines=1;
defaultanswer={'300'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});

r=handles.imggray; %对灰度图进行滤波
% r=handles.imggray_add_noise;  %对添加了噪声的图片进行滤波


[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=double(D<=D0);
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
% handles.imdata=g;
% guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置巴特沃斯低通滤波器的截止频率半径' '请设置巴特沃斯低通滤波器的阶数'};
name='巴特沃斯低通滤波器的截止频率半径和阶数';
numlines=1;
defaultanswer={'300' '1'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});
n=str2num(anss{2});

r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=1./(1+(D./D0).^(2*n));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt={'请设置高斯低通滤波器的截止频率（方差）' };
name='高斯低通滤波器的截止频率（方差）';
numlines=1;
defaultanswer={'300'};
anss=inputdlg(prompt,name,numlines,defaultanswer);
D0=str2num(anss{1});

r=handles.imggray;
[M N]=size(r);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>M/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=exp(-(D.^2)./(2*(D0^2)));
%r=mat2gray(r);
%PQ=paddedsize(size(r));
F=fft2(r,size(H,1),size(H,2));
G=H.*F;
g=real(ifft2(G));
g=g(1:size(r,1),1:size(r,2));
g=uint8(g);
axes(handles.axes3);
imshow(g);
handles.imdata=g;
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_29_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=handles.imggray_add_noise;
[M,N]=size(f);
y=fft2(f);
g=log(abs(fftshift(y))+1);
axes(handles.axes3);
imshow(g,[8,12]);
handles.ft=y;
handles.ftimg=log(abs(fftshift(y))+1);
guidata(hObject, handles);

% --------------------------------------------------------------------
function ifft_Callback(hObject, eventdata, handles)
% hObject    handle to ifft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=handles.ft;
[M,N]=size(f);
y=ifft2(f);
axes(handles.axes3);
imshow(y,[min(min(abs(y))),max(max(abs(y)))]);

% handles.imdata=abs(y);
% guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Untitled_31_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%截图操作,完成截取操作后双击鼠标即确定截取

x= imcrop(handles.imgdata);
disp('截图完成！')
[r,c] = size(x)
set(handles.edit11,'String',num2str(r));
set(handles.edit12,'String',num2str(c));

handles.roi = x;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Untitled_32_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%显示截图

axes(handles.axes3);imshow(handles.roi);

% --------------------------------------------------------------------
function Untitled_33_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%保存截图
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';
                                 '*.bmp','Bitmap(*.bmp)';
                                 '*.gif','GIF(*.gif)';
                                 '*.*',  'All Files (*.*)'},'Save Picture','Untitled');

if FileName==0
    return;

else
    %这么写保存的图像的大小与打开的原图像的大小相同
    imwrite(handles.roi,[PathName,FileName]);

end;

% --- Executes on button press in radiobutton_Canny.
function radiobutton_Canny_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_Canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_Canny


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%灰度图的亮度变化
% img = handles.imggray;
% val = round(get(handles.slider2,'Value'))
% [r,c]=size(img)
% b=ones(r,c)*val;%自动生成的是uint16  uint8与uint16不能直接相加 
% new=imadd(img,uint8(b));
% 
% axes(handles.axes3);imshow(new);

img= handles.imgdata;
val = round(get(handles.slider2,'Value'))
[w,h,c]=size(img)
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

n1=ones(w,h)*val;
r1=imadd(r,uint8(n1));
r2=imadd(g,uint8(n1));
r3=imadd(b,uint8(n1));
new(:,:,1) = r1;
new(:,:,2) = r2;
new(:,:,3) = r3;
axes(handles.axes3);imshow(new);



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
