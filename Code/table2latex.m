% ----------------------------------------------------------------------- %
% Function table2latex(T, filename) converts a given MATLAB(R) table into %
% a plain .tex file with LaTeX formatting.                                %
%                                                                         %
%   Input parameters:                                                     %
%       - T:        MATLAB(R) table. The table should contain only the    %
%                   following data types: numeric, boolean, char or string.
%                   Avoid including structs or cells.                     %
%       - filename: (Optional) Output path, including the name of the file.
%                   If not specified, the table will be stored in a       %
%                   './table.tex' file.                                   %  
% ----------------------------------------------------------------------- %
%   Example of use:                                                       %
%       LastName = {'Sanchez';'Johnson';'Li';'Diaz';'Brown'};             %
%       Age = [38;43;38;40;49];                                           %
%       Smoker = logical([1;0;1;0;1]);                                    %
%       Height = [71;69;64;67;64];                                        %
%       Weight = [176;163;131;133;119];                                   %
%       T = table(Age,Smoker,Height,Weight);                              %
%       T.Properties.RowNames = LastName;                                 %
%       table2latex(T);                                                   %                                       
% ----------------------------------------------------------------------- %
%   Version: 1.1                                                          %
%   Author:  Victor Martinez Cagigal                                      %
%   Date:    09/10/2018                                                   %
%   E-mail:  vicmarcag (at) gmail (dot) com                               %
% ----------------------------------------------------------------------- %
function table2latex(T, filename, caption, label)
    
    % Error detection and default parameters
    if nargin < 2
        filename = 'table.tex';
        fprintf('Output path is not defined. The table will be written in %s.\n', filename); 
    elseif ~ischar(filename)
        error('The output file name must be a string.');
    else
        if ~strcmp(filename(end-3:end), '.tex')
            filename = [filename '.tex'];
        end
    end
    if nargin < 1, error('Not enough parameters.'); end
    if ~istable(T), error('Input must be a table.'); end
    
    % Parameters    ----> col spec changed to c
    n_col = size(T,2);
    col_spec = [];
    for c = 1:n_col, col_spec = [col_spec 'c']; end
    col_names = strjoin(T.Properties.VariableNames, ' & ');
    row_names = T.Properties.RowNames;
    if ~isempty(row_names)
        col_spec = ['c' col_spec]; 
        col_names = ['& ' col_names];
    end
    
    % Writing header
    fileID = fopen(filename, 'w');
    fprintf(fileID, '\\begin{table}[H] \n');                            
    fprintf(fileID, '\\centering \n');  
    fprintf(fileID, '\\captionsetup{justification=centering,margin=10mm} \n');  
    fprintf(fileID, '\\caption{%s} \n', caption);
    fprintf(fileID, '\t{\\renewcommand{\\arraystretch}{1.2} \n');       
    fprintf(fileID, '\t\\begin{tabular}{%s} \n', col_spec);
    fprintf(fileID, '\t\t%s \\\\ \n', col_names);  
    fprintf(fileID, '\t\t\\hline \n');
    
    % Writing the data
    try
        for row = 1:size(T,1)
            temp{1,n_col} = [];
            for col = 1:n_col
                value = T{row,col};
                if isstruct(value), error('Table must not contain structs.'); end
                while iscell(value), value = value{1,1}; end
                if isinf(value), value = '$\infty$'; end
                temp{1,col} = num2str(value);
            end
            if ~isempty(row_names)
                temp = [row_names{row}, temp];
            end
            fprintf(fileID, '\t\t%s \\\\ \n', strjoin(temp, ' & '));
            clear temp;
        end
    catch
        error('Unknown error. Make sure that table only contains chars, strings or numeric values.');
    end
    
    % Closing the file
    fprintf(fileID, '\t\t\\hline \n');                  
    fprintf(fileID, '\t\\end{tabular} \n');
    fprintf(fileID, '\t} \n');
    fprintf(fileID, '\\label{tab:%s} \n', label);
    fprintf(fileID, '\\end{table}');
    
    fclose(fileID);
end