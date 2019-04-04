function varargout = Image_Magnifier(varargin)
% Image_Magnifier MATLAB code for Image_Magnifier.fig
%      Image_Magnifier, by itself, creates a new Image_Magnifier or raises the existing
%      singleton*.
%
%      H = Image_Magnifier returns the handle to a new Image_Magnifier or the handle to
%      the existing singleton*.
%
%      Image_Magnifier('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Image_Magnifier.M with the given input arguments.
%
%      Image_Magnifier('Property','Value',...) creates a new Image_Magnifier or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_Magnifier_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_Magnifier_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_Magnifier

% Last Modified by GUIDE v2.5 04-Apr-2019 23:34:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_Magnifier_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_Magnifier_OutputFcn, ...
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


% --- Executes just before Image_Magnifier is made visible.
function Image_Magnifier_OpeningFcn(hObject, eventdata, handles, varargin)
global current_x;
current_x = 1; % 初始倍率

global zoom_in; global zoom_out;, global zoom_in_Pressed; global zoom_out_Pressed;
% 剛開起來先設定Visible
set(handles.pushbutton2, 'Visible', 'Off');
set(handles.pushbutton4, 'Visible', 'Off');
set(handles.slider1, 'Visible', 'Off');
set(handles.slider2, 'Visible', 'Off');
set(handles.axes1, 'Visible', 'Off');
set(handles.axes2, 'Visible', 'Off');

% 讀放大鏡的圖
zoom_in= imread('0_Zoom-In.png');
zoom_out = imread('0_Zoom-out.png');
zoom_in_Pressed = imread('1_Zoom-In.png');
zoom_out_Pressed = imread('1_Zoom-out.png');

set(handles.pushbutton2,'CData',zoom_in);
set(handles.pushbutton4,'CData',zoom_out);

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_Magnifier (see VARARGIN)

% Choose default command line output for Image_Magnifier
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_Magnifier wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_Magnifier_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename, pathname, filterindex]  = uigetfile({'*.jpg'; '*.bmp'; '*.tif'; '*.png'},' Select an Image'); %顯示選檔介面
handles.img1 = imread([pathname filename]); %讀取影像並加入handles

global img_H; global img_W; global channels;
[img_H img_W channels] = size(handles.img1);

guidata(hObject, handles); %更新handles
axes(handles.axes1); %指定圖框
imshow(handles.img1); %秀圖

handles.img2 = handles.img1;
guidata(hObject, handles); %更新handles
axes(handles.axes2); %指定圖框
imshow(handles.img2); %秀圖


% 要先選圖片才能看見與使用
set(handles.pushbutton2, 'Visible', 'On')
set(handles.pushbutton4, 'Visible', 'On')
set(handles.slider1, 'Visible', 'On')
set(handles.slider2, 'Visible', 'On')
Draw(hObject, eventdata, handles);




% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
Draw(hObject, eventdata, handles);
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
Draw(hObject, eventdata, handles);
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global current_x;
current_x = current_x + 1;


    global zoom_in; global zoom_in_Pressed;
    
    set(handles.pushbutton2,'CData', zoom_in_Pressed);
    pause(0.07);
    set(handles.pushbutton2,'CData', zoom_in);
    Draw(hObject, eventdata, handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global current_x;
    if current_x >1
        current_x = current_x - 1;
    end

global zoom_out; global zoom_out_Pressed;

set(handles.pushbutton4,'CData', zoom_out_Pressed);
pause(0.07);
set(handles.pushbutton4,'CData', zoom_out);
Draw(hObject, eventdata, handles)

function Draw(hObject, eventdata, handles)
global img_H; global img_W; global channels; global current_x;
global h_Rect

% 原影像寬高除以放大倍率才是長方形框的寬高
rect_width = round(img_W/current_x);
rect_height = round(img_H/current_x);

% 取得slider 的當前 Value 用來算位置
Width_pos = get(handles.slider1,'Value');
High_pos = get(handles.slider2,'Value');

% 設定最高邊界
current_width = round((img_W - rect_width) * Width_pos);
current_height = round((img_H - rect_height) * (1 - High_pos)); 
delete(h_Rect);
axes(handles.axes1);
h_Rect = rectangle('Position', [current_width+1, current_height+1, rect_width-1, rect_height-1], 'LineWidth', 2, 'edgecolor','r'); % x y
pos = h_Rect.Position; % [x, y, w, h]

% disp(pos);

axes(handles.axes2);
img2 = handles.img1(round(pos(2))+1:round(pos(2)+pos(4)), round(pos(1)+1):round(pos(1)+pos(3)), :); % 切出紅框位置 show到右圖
handles.img2 = img2; %將處理後之影像存至handles
guidata(hObject, handles); %更新handles

axes(handles.axes2); %指定右圖框
imshow(img2); %秀圖
