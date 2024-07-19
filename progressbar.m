function progressbar(progress, process_name)
    progress_percent = progress*100;
    progress_percent_round = round(progress*100);
    msg = ['[' repmat('*',[1 progress_percent_round]) repmat('.',[1 100-progress_percent_round]) ']' ...
        ' ' num2str(progress_percent, '%.2f') '% ' process_name];
    disp(msg)
end
