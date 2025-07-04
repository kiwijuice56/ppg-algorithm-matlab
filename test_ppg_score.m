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

    % Scan through all files in a folder, but only view half (to prevent
    % overfitting)
    for k = 1:length(files)
        % Load the signal
        base_name = files(k).name;
        file_name = fullfile(directory, base_name);
        [ppg_signal, timestamps] = read_ppg_signal(file_name);

        % Calculate the score of all pulses in a signal
        single_signal_scores = score_ppg_signal(ppg_signal, timestamps);
                
        % Return the median among the pulse scores
        score = median(single_signal_scores);

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

clf('reset');

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
