function ph1valid03_prepro_loop( type, experiment, which_th )

%SessionInfo = ph1valid00_setup;

if nargin < 1
    type = 'both';
    experiment = 'Rp';
    which_th = 'Threshold';
elseif nargin < 2
    experiment = 'Rp';
    which_th = 'Threshold';
elseif nargin < 3
    which_th = 'Threshold';
end;

%todo = [11, 14];
skip = [1, 3];
j = 1;
tic;
fehler = cell(46,1);
for i = 1:46
    if i < 10
        b = ['0' num2str(i)];
    else
        b = num2str(i);
    end;
    %if ~ismember(i, todo)
    %    continue
    %end
    arg = ['VP' b];
    try
        switch type
            case 'prepro'
                ph1valid01_prepro(arg, experiment);
            case 'class'
                ph1valid02_classify(arg, which_th, experiment);
            case 'both'
                ph1valid01_prepro(arg, experiment);
                ph1valid02_classify(arg, which_th, experiment);
        end;
    catch ME
       % disp(ME);
        fehler{j} = sprintf('%s: %s', arg, ME.message);
        j = j + 1;
    end;
end
toc
fehler = fehler(~cellfun('isempty',fehler));
disp(fehler)