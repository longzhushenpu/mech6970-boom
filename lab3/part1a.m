%% Data Cleaning/Processing
% This whole cell is stolen from Rob's code for part 1b. 

clear all; clc; close all;

c = 299792458;
transit_time_est = 20e6/c;



fprintf('\nPart 1 - a)\n')
load(['..' filesep 'data' filesep 'Novatel_Data_ephemfixed.mat'])
clear time gNovatel1

psrL1 = gNovatel0.zPsrL1_gNovatel0;
adrL1 = gNovatel0.zAdrL1_gNovatel0;
adrL2 = gNovatel0.zAdrL2_gNovatel0;

ndat = length(psrL1); % number of measurement epochs
valid_dat = [];

% Find the GPS milliseconds into GPS week for which we have raw measurements
time = zeros(1,length(psrL1));
for i = 1:ndat
  if isempty(psrL1{i}) || isempty(adrL2{i}) || isempty(adrL2{i})
    continue
  end
  time(i) = psrL1{i}(34);
  valid_dat(end+1) = i;
  %!! assume that all ADR and PSR came in at the same time
end
% fixing measurements - remove invalid data epochs
time = time(valid_dat);
psrL1_ = psrL1(valid_dat);
adrL1_ = adrL1(valid_dat);
adrL2_ = adrL2(valid_dat);
ndat = length(time);

% SV's for which ephemeris data exists
prns = [1 2 4 8 9 10 12 17 20 24 28 32];
nsv = length(prns);

% Turn PSR/ADR data into a matrix
psrL1 = zeros(nsv,ndat);
adrL1 = zeros(nsv,ndat);
adrL2 = zeros(nsv,ndat);
for k = 1:ndat
  psrL1(:,k) = psrL1_{k}(prns+1);
  adrL1(:,k) = adrL1_{k}(prns+1);
  adrL2(:,k) = adrL2_{k}(prns+1);
end

% if there's no data, remove the sv
have_dat = find(any(psrL1,2));
prns = prns(have_dat);
nsv = length(prns);
psrL1 = psrL1(have_dat,:);
adrL1 = adrL1(have_dat,:);
adrL2 = adrL2(have_dat,:);

clear valid_dat adrL1_ adrL2_ psrL1_ have_dat


ephem_mat_novatel = [...
  gNovatel0.zEphem1_gNovatel0{end},...
  gNovatel0.zEphem2_gNovatel0{end},...
  gNovatel0.zEphem4_gNovatel0{end},...
  gNovatel0.zEphem8_gNovatel0{end},...
  gNovatel0.zEphem9_gNovatel0{end},...
  gNovatel0.zEphem10_gNovatel0{end},...
  gNovatel0.zEphem12_gNovatel0{end},...
  gNovatel0.zEphem17_gNovatel0{end},...
  gNovatel0.zEphem20_gNovatel0{end},...
  gNovatel0.zEphem24_gNovatel0{end},...
  gNovatel0.zEphem28_gNovatel0{end},...
  gNovatel0.zEphem32_gNovatel0{end}...
];

ephem_mat = zeros(21,nsv);
ephem_time = zeros(1,nsv); % gps seconds into week at which ephem was transmitted
sv_clkcorr = zeros(nsv,ndat);
svpos = zeros(3,nsv,ndat);

for i = 1:nsv
  % get the ephemeris matrix into the correct format
  [ephem_mat(:,i), ephem_time(i)] = ephem_novatel2gavlab(ephem_mat_novatel(:,i));
  % Find the SV Position at each of the measurement epochs we have
  for k = 1:ndat
    [svpos(:,i,k), sv_clkcorr(i,k)] = calc_sv_pos(ephem_mat(:,i), time(k), transit_time_est);
  end
end


%% Psuedorange/Position Estimation

%building a matrix of pseudoranges, with rows of pseudo ranges for each sv.  NaN is no value.
psuedorange=zeros(nsv,ndat);
for j=1:nsv
    
    
    
    
    
    
    
    
end