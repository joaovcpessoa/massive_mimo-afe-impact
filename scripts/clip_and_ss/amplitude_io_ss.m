%% CLEAR
% ####################################################################### %

clear;
close all;
clc;

%% PLOTTING PARAMETERS
% ####################################################################### %

linewidth  = 3;
fontname   = 'Times New Roman';
fontsize   = 18;
markersize = 10;

colors = [0.0000 0.0000 0.0000;
          0.0000 0.4470 0.7410;
          0.8500 0.3250 0.0980;
          0.9290 0.6940 0.1250;
          0.4940 0.1840 0.5560;
          0.4660 0.6740 0.1880;
          0.6350 0.0780 0.1840;
          0.3010 0.7450 0.9330];

%% MAIN PARAMETERS
% ####################################################################### %

root_save = ['C:\Users\joaov_zm1q2wh\OneDrive\Code\github\Impact-Analysis-of-Analog-Front-end-in-Massive-MIMO-Systems\images\'];
savefig = 1;

A0 = [1.0, 2.0];
p_values = [1, 2, 3];

N_A0 = length(A0);

N_amp_in = 100;
amplitude_in = linspace(0, 10, N_amp_in);

%% CALCULATION OF AMPLITUDE AND PHASE TRANSFER
% ####################################################################### %

amplitude_out = zeros(N_amp_in, length(p_values), N_A0);

for a0_idx = 1:N_A0
    a0 = A0(a0_idx);
    
    for p_idx = 1:length(p_values)
        p = p_values(p_idx);
        
        for amp_in_idx = 1:N_amp_in
            amp_in = amplitude_in(amp_in_idx);
            
            amp_out = abs(amp_in) ./ (1 + (abs(amp_in) / a0).^(2 * p)).^(1 / (2 * p)) .* exp(1j * angle(amp_in));
            
            amplitude_out(amp_in_idx, p_idx, a0_idx) = amp_out;
        end
    end
end

%% PLOT
% ####################################################################### %

figure;

for a0_idx = 1:N_A0
    for p_idx = 1:length(p_values)        
        plot(amplitude_in, squeeze(amplitude_out(:, p_idx, a0_idx)), '-', 'LineWidth', linewidth);
        hold on;
    end
end

xlabel('Amplitude de entrada', 'FontName', fontname, 'FontSize', fontsize);
ylabel('Amplitude de saída', 'FontName', fontname, 'FontSize', fontsize);

legend_text = {'$p = 1, A_0 = 1$', '$p = 2, A_0 = 1$', '$p = 3, A_0 = 1$', ...
               '$p = 1, A_0 = 2$', '$p = 2, A_0 = 2$', '$p = 3, A_0 = 2$'};
xlim([0 5]);
ylim([0 2]);

%legend(legend_text, 'Location', 'southeast', 'FontSize', fontsize, 'FontName', fontname, 'Interpreter', 'latex');
legend(legend_text, 'Location', 'southeast', 'FontSize', fontsize, ...
       'FontName', fontname, 'Interpreter', 'latex', 'NumColumns', 2);
legend box off;

set(gca, 'FontName', fontname, 'FontSize', fontsize);

graph_name = 'amplitude_io_ss';
    
if savefig == 1
   % saveas(gcf,[root_save graph_name],'fig');
   % saveas(gcf,[root_save graph_name],'png');
   saveas(gcf,[root_save graph_name],'epsc2');
end