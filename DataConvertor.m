% 250227
% Four Bay Frame experimental data

clear all;
close all;
clc;

Num_signal = 7;
format long;

Amp = '1mVpp';       % 1 5 20 50 100 150 200 400 Noise_Only
% Amp = 'Noise_Only'; % 1 5 20 50 100 150 200 400 Noise_Only


%% Autospectrum
Data = readmatrix(['Working.', Amp, '.Input.FFT.Autospectrum.txt']);

TF  = isnan(Data(:, 1));
del = find(TF == 0);
Data = Data(del, :);

for k = 1:Num_signal
    Autospectrum(:, :, k) = Data( ...
        length(Data)/Num_signal*(k-1) + 1 : length(Data)/Num_signal*k, : ...
    );
end


%% Autospectrum time
Data = readmatrix(['Working.', Amp, '.Input.FFT.Time.txt']);

TF  = isnan(Data(:, 1));
del = find(TF == 0);
Data = Data(del, :);

for k = 1:Num_signal
    Autospectrum_time(:, :, k) = Data( ...
        length(Data)/Num_signal*(k-1) + 1 : length(Data)/Num_signal*k, : ...
    );
end


%% Time captured compressed
Data = readmatrix(['Working.', Amp, '.Input.Time Cap.Compressed Time.txt']);

TF  = isnan(Data(:, 1));
del = find(TF == 0);
Data = Data(del, :);

for k = 1:Num_signal
    Time_Cap_compressed(:, :, k) = Data( ...
        length(Data)/Num_signal*(k-1) + 1 : length(Data)/Num_signal*k, : ...
    );
end

dt = Time_Cap_compressed(4, 2, 1) - Time_Cap_compressed(3, 2, 1);
save([Amp, '.mat'], 'Autospectrum', 'Autospectrum_time', 'Time_Cap_compressed');


%% Time captured measured
Data = readmatrix(['Working.', Amp, '.Input.Time Cap.txt']);

TF  = isnan(Data(:, 1));
del = find(TF == 0);
Data = Data(del, :);

for k = 1:Num_signal
    for l = 1:size(Data, 2) - 2
        Time_Cap(k, 1024*(l-1) + 1 : 1024*l) = Data( ...
            1024*(k-1) + 1 : 1024*k, l + 2 ...
        );
    end
end

dt = Data(2, 2);

Time_Cap(Num_signal + 1, :) = 0 : dt : (length(Time_Cap) - 1) * dt;
save([Amp, '_measured.mat'], 'Time_Cap');


%% Saving

