function [] = plot_filter_result(pattern, responses, filters, titles)
    amt_iters = length(responses);
    figure;
    for i=1 : amt_iters
        subplot(3,3,(i-1)*3+1)
        imshow(mat2gray(pattern));
        title(titles{(i-1)*3+1});
        subplot(3,3,(i-1)*3+2)
        imshow(mat2gray(filters{i, :}));
        title(titles{(i-1)*3+2});
        subplot(3,3,(i-1)*3+3)
        imshow(mat2gray(responses{i, :}))
        title(titles{(i-1)*3+3});
    end
end

