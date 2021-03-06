function showm(object)
%SHOWM Show specified graphic objects on map axes
%
%  SHOWM('str') shows the object on the current axes specified
%  by the string 'str', where 'str' is any string recognized by HANDLEM.
%  Showing an object is accomplished by setting its visible property to on.
%
%  SHOWM will display a Graphical User Interface prompting for the
%  objects to be shown from the current axes.
%
%  SHOWM(h) shows the objects specified by the input handles h.
%
%  See also CLMO, HIDE, HANDLEM, NAMEM, TAGM.

% Copyright 1996-2007 The MathWorks, Inc.
% $Revision: 1.8.4.3 $  $Date: 2007/11/09 20:29:04 $

if nargin == 0
    object = 'taglist';
end

%  Get the appropriate object handles
if ischar(object) &  strmatch('scaleruler',object,'exact') % strip trailing numbers
	hndl = [];
	for i=1:20 % don't expect more than 20 distinct scalerulers
		tagstr = ['scaleruler' num2str(i)];
		hexists = findall(gca,'tag',tagstr,'HandleVisibility','on');
        if ~isempty(hexists)
            hndl = [hndl hexists];
        end
	end
	for i=1:length(hndl)
		s = get(hndl(i),'Userdata'); % Get the properties structure
		childtag = s.Children; % Handles of all elements of scale ruler
		hchild = findall(gca,'tag',childtag);
		set(hchild,'Visible','on');
	end
	return
elseif ischar(object) &  strmatch('scaleruler',object) % strip trailing numbers	
	hndl = findall(gca,'tag',object);
else
	hndl = handlem(object);
end

%  Show the identified graphics objects
set(hndl,'Visible','on')
