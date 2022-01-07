function [] = Save_3D_Figure(h, path_str, cbar, z_lab, width_pdf)

    % This function saves a figure to PDF format
    % Made by: Daniel del Rio Velilla
    
    % Check number of in parameters
    n = nargin;                                                             
    switch n  
        case 2
            cbar = 'off';
            z_lab = 0;
            width_pdf = 0;
        case 3
            z_lab = 0;
            width_pdf = 0;
        case 4
            width_pdf = z_lab;  
        otherwise
    end
    
    % Set labels format
    set(gca,'TickLabelInterpreter','latex');
    set(gca,'FontSize',10.5);
    set(gca,'LabelFontSizeMultiplier',1.35);
    set(gca,'TitleFontSizeMultiplier',1.25);
    
    if strcmp(cbar, 'on')
        c = colorbar;
        c.TickLabelInterpreter = 'Latex'; 
    end
    set(get(gca,'zlabel'),'rotation',0)
    zlh = get(gca,'zlabel');
    zlh.Position(1) = z_lab*zlh.Position(1);

    % save figure as PDF
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3)+width_pdf/10, pos(4)])
    print(h, path_str{1}(1:end-3),['-d', path_str{1}(end-2:end)],'-r0','-painters')

end