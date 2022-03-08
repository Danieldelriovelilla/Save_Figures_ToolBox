clc
clear
close all


%% FIGURE 2D

f1 = figure();
ax = gca;
    plot([0,1], [0,1])
    grid on
xlabel('time [s]')
ylabel({'aasda';'[F]'})

% legend('Location','eastoutside')
ax.PlotBoxAspectRatio = [1.0000 0.7903 0.7903];

axpos_ini = ax.Position;
axpos_end = [0.1300 0.1100 0.7750 0.8150];

f1.Position = [680, 558, ... 
    axpos_end(3)/axpos_ini(3)*560   axpos_end(4)/axpos_ini(4)*420]; % [680   558   560   420];
ax.Position = axpos_end;



% ax.Position = [0.1300, 0.1100, 0.7750, 0.8150];

Save_Figure(f1, 'test.pdf', 'save', true, 'rotation', true)
% f1.InnerPosition = [7.0729 5.8021 6.8333 4.3750];

% Save_Figure(f1, 'test.pdf', 'save', true)


%% FIGURE 3D

f2 = figure();
    scatter3([0, 0, 1],[0, 1, 0],[1, 0, 0])
    box on
xlabel('X [mm]')
ylabel('Y [mm]')
zlabel({'Z';'[mm]'})

ax = gca;

Save_Figure(f2, 'test.pdf', 'save', false, 'rotation', true)