function [] = Save_Heatmap(varargin)

% VARARGIN
% Default
h = varargin{1};
path_str = varargin{2};
% Save figure
save_fig = find(strcmp(varargin, 'save'), 1);
if ~isempty(save_fig)
    action = varargin{save_fig+1};
else
    action = true;
end

% FUNCTION PROCDURE
% Save figure as desired format
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
if action
    print(h, path_str, strcat('-d', path_str{1}(end-2:end)), '-r0', '-painters')
end

end