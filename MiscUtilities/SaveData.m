[] = function SaveData(filename, structure, Dropbox_path);
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%
%INPUTS
%   filename        name of the file to be saved in the path.
%                   as @SimFunctionName. And should have input/output:
%                   SimValues = simfunction(PopParams,TimeParams)                   
%   structure       structure that is to be saved in the file.  
%                   simulation function
%   Dropbox_path    name of the path, use something like 
%                       ~/Dropbox/folder_name
%                   Denote with [] if no path

save([Dropbox_path filename],'-struct',structure);