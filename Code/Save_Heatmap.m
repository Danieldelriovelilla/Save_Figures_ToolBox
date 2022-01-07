function [] = Save_Heatmap(format, h, path)

% Save figure as desired format
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h, path, strcat('-d', format), '-r0', '-painters')

end