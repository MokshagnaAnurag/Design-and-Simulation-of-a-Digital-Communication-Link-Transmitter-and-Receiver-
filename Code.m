% Parameters
N = 1e5; % Number of bits to transmit
Eb_N0_dB = 0:2:12; % Eb/N0 range in dB
M = 2; % Binary Modulation (BPSK, M = 2)

% Step 1: Generate Random Bit Stream
bitStream = randi([0 1], 1, N);

% Step 2: BPSK Modulation (Mapping: 0 -> -1, 1 -> 1)
txSymbols = 2*bitStream - 1;

% Pre-allocate space for BER results
BER = zeros(size(Eb_N0_dB));

% Step 3: Simulation Over Varying SNR Values
for i = 1:length(Eb_N0_dB)
    % Convert Eb/N0 from dB to linear
    Eb_N0_lin = 10^(Eb_N0_dB(i)/10);

    % Step 4: Calculate Noise Power (AWGN)
    noisePower = 1/(2*Eb_N0_lin);

    % Generate AWGN noise
    noise = sqrt(noisePower) * randn(1, N);

    % Step 5: Transmit Through Channel (Add Noise)
    rxSymbols = txSymbols + noise;

    % Step 6: Receiver Demodulation (BPSK Decision Rule)
    rxBits = rxSymbols > 0;

    % Step 7: Compute Bit Error Rate (BER)
    BER(i) = sum(bitStream ~= rxBits)/N;
end

% Step 8: Plot Results
figure;
semilogy(Eb_N0_dB, BER, 'bo-');
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate (BER)');
title('BER Performance of BPSK in AWGN Channel');
