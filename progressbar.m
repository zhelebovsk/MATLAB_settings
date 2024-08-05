function progressbar(progress, process_name)
    progress_percent = progress*100;
    progress_percent_round = round(progress*100);
    msg = ['[' repmat('*',[1 progress_percent_round]) repmat('.',[1 100-progress_percent_round]) ']' ...
        ' ' num2str(progress_percent, '%.2f') '%' ];
    if nargin == 1
        disp(msg);
    else
        disp([msg ' ' process_name]);
    end
end
