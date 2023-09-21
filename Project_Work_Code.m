% Project Work
clc; clear all; close all; 

%% opts1
% Import Data
opts1 = delimitedTextImportOptions("NumVariables", 26);

% Specify range and delimiter
opts1.DataLines = [1, Inf];
opts1.Delimiter = " ";

% Specify column names and types
opts1.VariableNames = ["unit_number", "time_in_cycles", "operational_setting_1", "operational_setting_2", "operational_setting_3",...
                      "sensor_measurement_1", "sensor_measurement_2", "sensor_measurement_3",...
                      "sensor_measurement_4", "sensor_measurement_5", "sensor_measurement_6",...
                      "sensor_measurement_7", "sensor_measurement_8", "sensor_measurement_9",...
                      "sensor_measurement_10", "sensor_measurement_11", "sensor_measurement_12",...
                      "sensor_measurement_13", "sensor_measurement_14", "sensor_measurement_15",...
                      "sensor_measurement_16", "sensor_measurement_17", "sensor_measurement_18",...
                      "sensor_measurement_19", "sensor_measurement_20", "sensor_measurement_21"];
opts1.SelectedVariableNames = ["unit_number", "time_in_cycles", "operational_setting_1", "operational_setting_2", "operational_setting_3",...
                      "sensor_measurement_1", "sensor_measurement_2", "sensor_measurement_3",...
                      "sensor_measurement_4", "sensor_measurement_5", "sensor_measurement_6",...
                      "sensor_measurement_7", "sensor_measurement_8", "sensor_measurement_9",...
                      "sensor_measurement_10", "sensor_measurement_11", "sensor_measurement_12",...
                      "sensor_measurement_13", "sensor_measurement_14", "sensor_measurement_15",...
                      "sensor_measurement_16", "sensor_measurement_17", "sensor_measurement_18",...
                      "sensor_measurement_19", "sensor_measurement_20", "sensor_measurement_21"];
opts1.VariableTypes = ["double", "double", "double", "double", "double",...
                      "double", "double", "double",...
                      "double", "double", "double",...
                      "double", "double", "double",...
                      "double", "double", "double",...
                      "double", "double", "double",...
                      "double", "double", "double",...
                      "double", "double", "double"];

% Specify file level properties
opts1.ExtraColumnsRule = "ignore";
opts1.EmptyLineRule = "read";

%% opts2
% Import Data
opts2 = delimitedTextImportOptions("NumVariables", 1);

% Specify range and delimiter
opts2.DataLines = [1, Inf];
opts2.Delimiter = " ";

% Specify column names and types
opts2.VariableNames = ["Remaining_Useful_Life"];
opts2.SelectedVariableNames = ["Remaining_Useful_Life"];
opts2.VariableTypes = ["double"];

% Specify file level properties
opts2.ExtraColumnsRule = "ignore";
opts2.EmptyLineRule = "read";

%% Import the data
% 1st data set
Train_Data1 = readtable("train_FD001.txt", opts1);  % Import data
Test_Data1 = readtable("test_FD001.txt", opts1);
RUL_Data1 = readtable("RUL_FD001.txt", opts2);
Data(1).Train = Delete_Missing_Values(Train_Data1); % Delete missing values in data
Data(1).Test = Delete_Missing_Values(Test_Data1);
Data(1).RUL = Delete_Missing_Values(RUL_Data1);
Data(1).TrainSplit = SplitData(Data(1).Train);      % Split the data according to unit number
Data(1).TestSplit = SplitData(Data(1).Test);

% 2nd data set
Train_Data2 = readtable("train_FD002.txt", opts1);
Test_Data2 = readtable("test_FD002.txt", opts1);
RUL_Data2 = readtable("RUL_FD002.txt", opts2);
Data(2).Train = Delete_Missing_Values(Train_Data2);
Data(2).Test = Delete_Missing_Values(Test_Data2);
Data(2).RUL = Delete_Missing_Values(RUL_Data2);
Data(2).TrainSplit = SplitData(Data(2).Train);
Data(2).TestSplit = SplitData(Data(2).Test);

% 3rd data set
Train_Data3 = readtable("train_FD003.txt", opts1);
Test_Data3 = readtable("test_FD003.txt", opts1);
RUL_Data3 = readtable("RUL_FD003.txt", opts2);
Data(3).Train = Delete_Missing_Values(Train_Data3);
Data(3).Test = Delete_Missing_Values(Test_Data3);
Data(3).RUL = Delete_Missing_Values(RUL_Data3);
Data(3).TrainSplit = SplitData(Data(3).Train);
Data(3).TestSplit = SplitData(Data(3).Test);

% 4rd data set
Train_Data4 = readtable("train_FD004.txt", opts1);
Test_Data4 = readtable("test_FD004.txt", opts1);
RUL_Data4 = readtable("RUL_FD004.txt", opts2);
Data(4).Train = Delete_Missing_Values(Train_Data4);
Data(4).Test = Delete_Missing_Values(Test_Data4);
Data(4).RUL = Delete_Missing_Values(RUL_Data4);
Data(4).TrainSplit = SplitData(Data(4).Train);
Data(4).TestSplit = SplitData(Data(4).Test);

% clearvars opts1
% clearvars opts2
figure(1);subplot(3,1,1)
boxplot(Data(1).Test);
title('Test1')
subplot(3,1,2)
boxplot(Data(1).Train);
title('Train1')
subplot(3,1,3)
boxplot(Data(1).RUL);
title('RUL1')

figure(2);subplot(3,1,1)
boxplot(Data(2).Test);
title('Test2')
subplot(3,1,2)
boxplot(Data(2).Train);
title('Train2')
subplot(3,1,3)
boxplot(Data(2).RUL);
title('RUL2')

figure(3);subplot(3,1,1)
boxplot(Data(3).Test);
title('Test3')
subplot(3,1,2)
boxplot(Data(3).Train);
title('Train3')
subplot(3,1,3)
boxplot(Data(3).RUL);
title('RUL3')

figure(4);subplot(3,1,1)
boxplot(Data(4).Test);
title('Test4')
subplot(3,1,2)
boxplot(Data(4).Train);
title('Train4')
subplot(3,1,3)
boxplot(Data(4).RUL);
title('RUL4')

%% Pretreat the data
% Center and scale the data by z-score normalization
for i=1:4
    Data(i).TrainNorm = normalize(Data(i).Train,'zscore'); % Normalize train data
    Data(i).TestNorm = normalize(Data(i).Test,'zscore');   % Normalize test data
    Data(i).RULNorm = normalize(Data(i).RUL,'zscore');     % Normalize RUL data
end

%% Visualize the data
figure(1);subplot(3,1,1)
boxplot(Data(1).TestNorm); % Plot normalized test data
title('Normalized Test Data for Subset 1')
subplot(3,1,2)
boxplot(Data(1).TrainNorm); % Plot normalized train data
title('Normalized Train Data for Subset 1')
subplot(3,1,3)
boxplot(Data(1).RULNorm); % Plot normalized RUL data
title('Normalized RUL Data for Subset 1')

figure(2);subplot(3,1,1)
boxplot(Data(2).TestNorm); % Plot normalized test data
title('Normalized Test Data for Subset 2')
subplot(3,1,2)
boxplot(Data(2).TrainNorm); % Plot normalized train data
title('Normalized Train Data for Subset 2')
subplot(3,1,3)
boxplot(Data(2).RULNorm); % Plot normalized RUL data
title('Normalized RUL Data for Subset 2')

figure(3);subplot(3,1,1)
boxplot(Data(3).TestNorm); % Plot normalized test data
title('Normalized Test Data for Subset 3')
subplot(3,1,2)
boxplot(Data(3).TrainNorm); % Plot normalized train data
title('Normalized Train Data for Subset 3')
subplot(3,1,3)
boxplot(Data(3).RULNorm); % Plot normalized RUL data
title('Normalized RUL Data for Subset 3')

figure(4);subplot(3,1,1)
boxplot(Data(4).TestNorm); % Plot normalized test data
title('Normalized Test Data for Subset 4')
subplot(3,1,2)
boxplot(Data(4).TrainNorm); % Plot normalized train data
title('Normalized Train Data for Subset 4')
subplot(3,1,3)
boxplot(Data(4).RULNorm); % Plot normalized RUL data
title('Normalized RUL Data for Subset 4')
