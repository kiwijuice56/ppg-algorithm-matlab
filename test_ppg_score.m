sampling_frequency = 50; % Hertz
cutoff_frequency = 1; % Hertz
resampling_scale = 4;

% Initialize the output
scores = {[],[],[],[],[],[]};

% Read the classification data
table = readtable("data/patient_classification.csv");
ids = table2array(table(:,1));
labels = table2array(table(:,2));
classification_lookup = dictionary(ids, labels);

% Calculate scores for all PPG signals
folders = ["data/young-athletic", "data/young-nonathletic", "data/good-nagpur"];
for i = 1:3
    directory = folders(i); 
    files = dir(fullfile(directory,'*.csv')); 

    % Scan through all files in a folder
    for k = 1:length(files)
        base_name = files(k).name;
        file_name = fullfile(directory, base_name);
        data = readmatrix(file_name);
        raw_ppg_signal = data(:,:);
        
        % Resample the pulse to a higher rate to increase resolution,
        % using cubic spline interpolation
        time = linspace(raw_ppg_signal(1, 1), ...
            raw_ppg_signal(length(raw_ppg_signal), 1), ...
            resampling_scale * length(raw_ppg_signal));
        ppg_signal = interp1(raw_ppg_signal(:, 1), raw_ppg_signal(:, 2), time, 'pchip');
       
        % Some signals are unusually short, discard those
        if length(ppg_signal) < 5800
            continue;
        end

        % Calculate the score
        score = score_ppg_signal(ppg_signal, ...
                                 sampling_frequency * resampling_scale, ...
                                 cutoff_frequency * resampling_scale);
        
        if i <= 2
            % Store young athletic/non-athletic in their own plots
            scores{i}(end + 1) = score;
        else 
            % Split Nagpur data based on classification
            id = str2double(base_name(1:3)); % Hacky way of getting the ID...
            class = classification_lookup{id};

            if strcmp(class, 'healthy') == 1 
                index = 3;
            elseif strcmp(class, 'hypertensive') == 1
                index = 4;
            elseif strcmp(class, 'pre CAD') == 1
                index = 5;
            elseif strcmp(class, 'CAD') == 1
                index = 6;
            end

            scores{index}(end + 1) = score;
        end
    end
end


% Process data into a format that boxplot can use...
% Strange and hacky
y = num2cell(1:numel(scores));
x = cellfun(@(x, y) [x(:) y*ones(size(x(:)))], scores, y, 'UniformOutput', 0);
X = vertcat(x{:});

hold on 

% Plot individual points
spread = 0.125;
x_center = 1:numel(scores); 
for i = 1:numel(scores)
    plot(rand(size(scores{i}))*spread -(spread/2) + x_center(i), scores{i}, '.', 'linewidth', 1)
end

boxplot(X(:,1), X(:,2))

title('Cardiovascular Scores')
key = {'Young Athletic', 'Young Nonathletic', 'Old Healthy', 'Old Hypertensive', 'Old Pre CAD', 'Old CAD'};
xticklabels(key)
ylabel('Score')

hold off
