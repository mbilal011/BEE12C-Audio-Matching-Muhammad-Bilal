function [sw, indices] = signalintoframes(X_sample, fs_sample, param)
    frame_size_time = param.frame_size_time;
    overlap = param.overlap;
    window_type = param.window_type;

    frame_size_samples = round(frame_size_time * fs_sample / 1000);
    overlap_samples = round(frame_size_samples * overlap / 100);

    signal_length = length(X_sample);

    num_frames = floor((signal_length - frame_size_samples) / (frame_size_samples - overlap_samples)) + 1;

    sw = zeros(frame_size_samples, num_frames);
    indices = zeros(num_frames, 2);

    for i = 1:num_frames
        start_idx = (i - 1) * (frame_size_samples - overlap_samples) + 1;
        end_idx = start_idx + frame_size_samples - 1;

        if end_idx > signal_length
            frame = [X_sample(start_idx:end); zeros(end_idx - signal_length, 1)];
        else
            frame = X_sample(start_idx:end_idx);
        end

        sw(:, i) = frame;
        indices(i, :) = [start_idx, end_idx];
    end
end
