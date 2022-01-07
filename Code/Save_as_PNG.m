clc
clear all
close all

y_lab = -5;
y_pdf = 00;

h = figure();
    plot([1:10], [1:10]); % Example graph
    ylabel({'I','[A]'})

% Get axis size
ax = axis();
    
% Move y label
set(get(gca,'ylabel'),'rotation',0)
ylh = get(gca,'ylabel');
ylh.Position(1) = -(0.11 + y_lab/100)*( ax(2) - ax(1) );
ylh.Position(2) = 0.8*( ax(4) - ax(3) ) + ax(3);
    
    
set(h,'Units','Inches');
pos = get(h,'Position');

%set(gcf,'PaperUnits','inches','PaperPosition',[0 0 pos(3), pos(4)])
set(gcf,'PaperUnits','Inches','PaperSize',[pos(3)+y_pdf/10, pos(4)])
%set(gca,'units','pix','pos',[100,100,500,300])
print(h, '-dpng', 'filename','-r750','-painters')
