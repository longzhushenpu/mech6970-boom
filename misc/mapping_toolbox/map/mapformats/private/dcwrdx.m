function [X,nX] = dcwrdx(filepath,Xfilename)
%DCWRDX Read the Digital Chart of the World index file.
%
%  [X, NX] = DCWRDX(FILEPATH, FILENAME) reads the Digital Chart of the
%  World index file.  [FILEPATH FILENAME] must form a valid full filename.
%  X is a matrix containing the byte offset from beginning of file and the
%  number of bytes in the table record for each entry.  NX is the number of
%  index records (scalar).
%
%  See also: DCWREAD, DCWRHEAD.

%  Copyright 1996-2007 The MathWorks, Inc.
%  Written by:  W. Stumpf
%  $Revision: 1.1.6.2 $    $Date: 2007/10/10 20:49:35 $

if nargin ~= 2 ; error(['map:' mfilename ':mapformatsError'], 'Incorrect number of input arguments'); end

nX = 0;
X = [];

fid = fopen([filepath,Xfilename],'rb', 'ieee-le');

if fid == -1
	[filename,filepath] = uigetfile(filename,['Where is ',Xfilename,'?']);
	if filename == 0 ; return; end
	fid = fopen([filepath,filename],'rb', 'ieee-le');
end

nX = fread(fid, 1, 'integer*4');           % number of records in the table being indexed
nHeaderBytes = fread(fid, 1, 'integer*4');
X =  fread(fid, [2, nX], 'integer*4');    % Byte offset from beginning of file
	                                  % Number of bytes in table record

fclose(fid);
