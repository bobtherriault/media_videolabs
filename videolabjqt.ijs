NB. multimedia lab viewer - video processes (even when closed) remain until jqt has exited. 
coclass 'qtvideo'

NB. === initializing verb must be run at the beginning of each video lab
init =: 3 : 0
if. 0 -: 4!:0 <'QThandle_qtvideo_' do. erase 'QThandle_qtvideo_' [ wd 'psel ',QThandle,';pclose;' end. NB. close window if it exists - cleans up orphan ghost windows 
'WM HM'=: _300 + 2 3 { ". wd 'qscreen' NB. establish screen width and height with 300 px allowance    
'SS MS LS'=:  ": each VM=: WM>400 800 1600
if.y-:'' do.VM=:<: 2<.+/VM else. VM=:y end. NB. sets viewmode to default or smaller if argument is '' or to size if called from size buttons
'WM HM'=:>VM {400 225;800 450;1600 900 NB. set medium size as default
 wd MULTIMEDIA NB. opens new video form at the beginning of lab or when size changes
 QThandle=: wd 'qhwndp'  NB. Establishes identifier for the video window
 wd 'setp wh ',":80 60 + WM , HM
 wd 'set s visible ',SS,';set m visible ',MS,';set l visible ',LS,';'
 wd 'set ',(VM{'sml'),' value 1;'
if. -. y -: '' do. display VIDEO end. NB. when resizing don't forget to reload the current video
i. 0 0
)

NB. === verb used to show video if new or resized - y argument is code for video
display=: 3 : 0
 VIDEO=:y  NB. used in reset to rerun display
  wd 'psel ',QThandle,';'
  wd 'set mm html <iframe width="',(":WM) ,'" height="',(":HM) ,'" src="https://www.youtube.com/embed/',VIDEO,'?feature=oembed;rel=0&amp;"></iframe> ;set mm visible;set mm minwh ',(":WM , HM),' ;'
 wd 'pshow;'
)

NB. === form description
MULTIMEDIA=: 0 : 0
pc multimedia;
pcenter;
bin h;
bin vs;
cc SI static;cn "Size";set _ tooltip "Available Display Sizes";
maxwh 20 20;cc s radiobutton;cn "";set s visible;set _ tooltip "Extra small screen size - 400 X 225";set _ wh 20 20;
maxwh 20 20;cc m radiobutton group;cn "";set m visible;set _ tooltip "Medium screen size - 800 X 450";set _ wh 20 20;
maxwh 20 20;cc l radiobutton group;cn "";set l visible;set _ tooltip "Large screen size - 1600 X 900";set _ wh 20 20;
bin sz;
cc mm webview;set mm sizepolicy expanding;
bin z;
)

NB. === button controls
multimedia_s_button=: 3 : 'init 0'
multimedia_m_button=: 3 : 'init 1'
multimedia_l_button=: 3 : 'init 2'

NB. === close button 
resetvid=:multimedia_close=: 3 : 0
if. wdisparent 'multimedia' do. 
                         wd 'psel ',QThandle,';'
                         wd 'pshow hide;'
                               end. NB. Select video form,  hide so there is not a new ghost window 
)
