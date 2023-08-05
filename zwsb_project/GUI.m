function varargout = GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
global img1;
background_image = imread('background.jfif');
background_image1 = imread("2.jpg");
background_image2 = imread("4.jpg");
background_image3 = imread("3.jpg");
axes(handles.axes1);
imshow(background_image1);
axes(handles.axes2);
imshow(background_image2);
axes(handles.axes3);
imshow(background_image3);
set(handles.pushbutton3, 'Enable', 'off');
[filename, pathname] = uigetfile({'*.bmp'; '*.jpg'; '*.*'}, '��ѡ��Ҫ�����ָ��ͼ��');
if(filename == 0)
    return;
end
str = [pathname, filename];
img1 = imread(str);
axes(handles.axes1);
imshow(img1);
set(handles.pushbutton3, 'Enable', 'on');


function pushbutton2_Callback(hObject, eventdata, handles)
global img1;
img2 = main1(img1);
axes(handles.axes2);
imshow(img2);
load images_mat;
count = size(images, 3);
error_value = 1;
i = 1;
for i = 1 : count
    img3 = squeeze(images(:, :, i));
    img3_temp = main1(img3);
    error_value = main2(img2, img3_temp);
    if(error_value == 0)
        break;
    end
end
if(error_value == 0)
    logo = imread('logo.jfif');
    axes(handles.axes3);
    imshow(img3);
    msgbox('ƥ��ɹ���', '��ʾ', 'custom', logo);
else
    errordlg('ƥ��ʧ�ܣ�', '��ʾ');
end


function pushbutton3_Callback(hObject, eventdata, handles)
global img1;
img2 = main1(img1);
load images_mat;
count = size(images, 3);
error_value = 1;
for i = 1 : count
    img_temp = squeeze(images(:, :, i));
    img3 = main1(img_temp);
    error_value = main2(img2, img3);
    if(error_value == 0)
        break;
    end
end
if(error_value == 1)
    images(:, :, count + 1) = img1;
    logo = imread('logo.jfif');
    msgbox('¼��ɹ���', '��ʾ', 'custom', logo);
    save images_mat images;
    filepath = pwd;
    cd('D:\�ĵ�\ʵ��\����ͼ��\�洢����');
    imwrite(img1, [num2str(count + 1), '.bmp']);
    cd(filepath);
else
    errordlg('¼��ʧ�ܣ���ָ���Ѵ��ڣ�', '��ʾ');
end


function axes1_CreateFcn(hObject, eventdata, handles)
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));
% �����д��빦�ܣ�ȥ������̶�
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);


function axes2_CreateFcn(hObject, eventdata, handles)
% �����д��빦�ܣ��������������̶�תΪ��ɫ
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));
% �����д��빦�ܣ�ȥ������̶�
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);


function axes3_CreateFcn(hObject, eventdata, handles)
% �����д��빦�ܣ��������������̶�תΪ��ɫ
set(gca,'XColor',get(gca,'Color'));
set(gca,'YColor',get(gca,'Color'));
% �����д��빦�ܣ�ȥ������̶�
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);

