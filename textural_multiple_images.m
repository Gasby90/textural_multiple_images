%% TEXTURE ANALYSIS TOOLBOX light  
% Riccardo Gasbarrone, 2017. Ver 1.0 (15 March 2017).
%This script allow to extract the gray-level co-occurrence matrices (at
%=0°, 45°, 90° and 135°) of all images occurring in a folder, then the
%Haralick textural features are computed for all the 4 direction. 

%https://www.researchgate.net/post/How_to_calculate_the_GLCM_features_of_each_image_in_a_folder_using_Matlab

tic

file_list = dir('*.tif'); %Search all .tif files in the current directory 
nfiles = length(file_list); %Add a semicolumn to prevent the function from printing out the output
for k = 1 : nfiles
    I = imread(strcat(file_list(k).name));
    if length(size(I))==3 %check if the image I is color
        I=rgb2gray(I);
    end
    glcm_0 = graycomatrix(I, 'offset', [0 1], 'Symmetric', true);
    stats_0{k} = haralickTextureFeatures(glcm_0);
    glcm_45 = graycomatrix(I, 'offset', [-1 1], 'Symmetric', true);
    stats_45{k} = haralickTextureFeatures(glcm_45);
    glcm_90 = graycomatrix(I, 'offset', [-1 0], 'Symmetric', true);
    stats_90{k} = haralickTextureFeatures(glcm_90);
    glcm_135 = graycomatrix(I, 'offset', [-1 1], 'Symmetric', true);
    stats_135{k} = haralickTextureFeatures(glcm_135);
end

%extract all Haralick features
m_stats_0=cell2mat(stats_0);
m_stats_45=cell2mat(stats_45);
m_stats_90=cell2mat(stats_90);
m_stats_135=cell2mat(stats_135);

%compute mean for all directions
Ave=(m_stats_0 + m_stats_135 + m_stats_45 + m_stats_90)/4

%extract parameters
ASM=Ave(1,:) %average Angular Second Moment (Energy) 
CON=Ave(2,:) %average Contrast  
COR=Ave(3,:) %average Correlation 
ENT=Ave(9,:) %average Entropy

toc