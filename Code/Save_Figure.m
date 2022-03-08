function [] = Save_Figure(varargin)

%% VARARGIN

% Default
h = varargin{1};
path_str = varargin{2};

% Save figure
save_fig = find(strcmpi(varargin, 'save'), 1);
if ~isempty(save_fig)
    saveit = varargin{save_fig+1};
else
    saveit = true;
end

% Label rotation
label_rot = find(strcmpi(varargin, 'rotation'), 1);
if ~isempty(label_rot)
    rotateit = varargin{label_rot+1};
else
    rotateit = false;
end

% Axis position
%{
axposition = find(strcmpi(varargin, 'axposition'), 1);
if ~isempty(axposition)
    axposition_2D = varargin{axposition+1};
else
    axposition_2D = [0.1300, 0.1100, 0.7750, 0.8150];
end
%}


%% LABEL POSITIONING

ax = gca;
naxes = numel(axis(ax))/2;


if naxes == 2
    % Axis position
    % ax.Position = axposition_2D;

    % Move x label
    ax.XLabel.Position(1) = 0.9*( ax.XLim(2) - ax.XLim(1) ) + ax.XLim(1); 

    % If rotation is activated
    if rotateit
        % Rotate Y label
        ax.YLabel.Rotation = 0;
        label_length = length(ax.YLabel.String{1});

        % Move y label
        ax.YLabel.Position(1) = ax.XLim(1) - ( 0.1 + ( (label_length))/95 )*( ax.XLim(2) - ax.XLim(1) );
        ax.YLabel.Position(2) = 0.8*( ax.YLim(2) - ax.YLim(1) ) + ax.YLim(1);
    else
        label_length = 0;
    end
else
    % If rotation is activated
    if rotateit
        % Rotate Y label
        ax.ZLabel.Rotation = 0;
        label_length = length(ax.ZLabel.String{1});

        % Move y label
        % ax.YLabel.Position(1) = ax.XLim(1) - ( 0.1 + ( (label_length))/95 )*( ax.XLim(2) - ax.XLim(1) );
        ax.ZLabel.Position(3) = 0.8*( ax.ZLim(2) - ax.ZLim(1) ) + ax.ZLim(1);
        
        ax.ZLabel.Position(1)
        ax.ZLabel.Position(2)
        ax.ZLabel.Position(3)
    else
        label_length = 0;
    end

end


%% LEGEND

if isempty(ax.Legend)
    % No legend
else
    % Legend font
    ax.Legend.Interpreter = 'latex';

end



%% AXIS FONTSIZE
% Set labels format
ax.XLabel.Interpreter = 'latex';
ax.YLabel.Interpreter = 'latex';
ax.ZLabel.Interpreter = 'latex';
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 10;
ax.LabelFontSizeMultiplier = 1.25;
ax.TitleFontSizeMultiplier = 1.;



%% FUNCTION PROCDURE

% Paper configuration
h.Units = 'Inches';
h.PaperPositionMode = 'Auto';
h.PaperUnits = 'Inches';
h.PaperSize = [h.Position(3)*(2 + label_length/(2*35)/(ax.XLim(2)-ax.XLim(1))), h.Position(4)];

% Save figure as desired format
if saveit
    print(h, path_str, strcat('-d', path_str(end-2:end)), '-r0', '-painters')
end

end