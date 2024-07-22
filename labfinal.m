M = 8;
k = log2(M);
n = 3000;

bitStream = randi([0, 1], n, 1);
symbolStream = reshape(bitStream, [], k); % Reshaping with empty rows argument
dataSymbolsIn = bi2de(symbolStream);
modulatedSignal = pskmod(dataSymbolsIn, M, pi/M);
SNR = 20;

% Generating received signal with noise
receivedSignal = awgn(modulatedSignal, SNR);

receivedSymbolsOut = pskdemod(receivedSignal, M, pi/M);
receivedBits = de2bi(receivedSymbolsOut, k);

receivedSymbolsOut = pskdemod(receivedSignal, M, pi/M);
receivedBitStream = receivedBits(:);
[numErrors, BER] = biterr(bitStream, receivedBitStream);
fprintf('Number of bit errors: %d\n', numErrors);
fprintf('Bit Error Rate (BER): %f\n', BER);

figure;
subplot(2,1,1);
plot(real(modulatedSignal), imag(modulatedSignal), 'bo');
title('Transmitted 8-PSK Modulated Signal');
xlabel('IN-PHASE');
ylabel('Quadrature');
grid on;
subplot(2,1,2);
plot(real(receivedSignal), imag(receivedSignal), 'ro');
title('Received 8-PSK Modulated Signal');
xlabel('IN-PHASE');
ylabel('Quadrature');
grid on;
